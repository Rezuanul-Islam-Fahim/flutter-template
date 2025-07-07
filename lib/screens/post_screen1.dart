import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';

import '../blocs/wallet/wallet_bloc.dart';
import '../core/app_theme.dart';
import '../models/location.dart';
import '../models/wallet.dart';
import '../repositories/location_repository.dart';
import '../utils/navigator.dart';
import '../widgets/form_info.dart';
import 'post_screen2.dart';

class PostScreen1 extends StatefulWidget {
  const PostScreen1({super.key});

  static const String route = '/post1';

  @override
  State<PostScreen1> createState() => _PostScreen1State();
}

class _PostScreen1State extends State<PostScreen1> {
  bool _isLoading = true;
  late Location _loadedLocation;

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.',
      );
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<Location> loadLocation(Wallet wallet) async {
    Position deviceLocation = await _determinePosition();
    Location? location = await LocationRepository().addLocation(
      lat: deviceLocation.latitude.toString(),
      lng: deviceLocation.longitude.toString(),
      wallet: wallet,
    );

    return location!;
  }

  @override
  void initState() {
    WalletState walletState = BlocProvider.of<WalletBloc>(context).state;

    if (walletState is WalletLoaded) {
      loadLocation(walletState.wallet).then((Location location) {
        setState(() {
          _isLoading = false;
          _loadedLocation = location;
        });
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return !_isLoading
        ? SafeArea(
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(backgroundColor: Colors.white),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Hey,', style: theme.textTheme.titleLarge),
                      const SizedBox(height: 8),
                      FormInfo(
                        title: 'I wanna add review about',
                        inputHintText: _loadedLocation.name!,
                        enabled: false,
                      ),
                      const SizedBox(height: 25),
                      const FormInfo(
                        title: 'Which is brand of',
                        inputHintText: 'Automatically Detected',
                        enabled: false,
                      ),
                      const SizedBox(height: 25),
                      _buildCategoryPopup(context, theme),
                    ],
                  ),
                ),
              ),
              bottomSheet: GestureDetector(
                onTap: () async {
                  Nav.to(
                    context,
                    PostScreen2.route,
                    arguments: _loadedLocation,
                  );
                },
                child: Container(
                  height: 60,
                  width: double.infinity,
                  color: AppTheme.primaryColor,
                  child: Center(
                    child: Text(
                      'Continue',
                      style: theme.textTheme.titleMedium!.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        : SafeArea(
            child: Scaffold(
              body: Center(
                child: CircularProgressIndicator(
                  color: AppTheme.primaryColor,
                ),
              ),
            ),
          );
  }

  Widget _buildCategoryPopup(BuildContext context, ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Of following category', style: theme.textTheme.titleLarge),
        const SizedBox(height: 15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Automatically Detected',
                  style: theme.textTheme.titleLarge!.copyWith(
                    color: Colors.grey[400],
                  ),
                ),
                const Icon(Icons.arrow_drop_down),
              ],
            ),
            const SizedBox(height: 5),
            const Divider(),
          ],
        ),
      ],
    );
  }
}
