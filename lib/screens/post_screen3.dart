import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../blocs/reviews/reviews_bloc.dart';
import '../blocs/wallet/wallet_bloc.dart';
import '../core/app_theme.dart';
import '../repositories/reviews_repository.dart';
import '../utils/navigator.dart';
import 'list_screen.dart';

class PostScreen3 extends StatefulWidget {
  const PostScreen3({super.key});

  static const String route = '/post3';

  @override
  State<PostScreen3> createState() => _PostScreen3State();
}

class _PostScreen3State extends State<PostScreen3> {
  final ImagePicker _picker = ImagePicker();
  File? _pickedImage;

  @override
  Widget build(BuildContext context) {
    final List<dynamic> values =
        ModalRoute.of(context)!.settings.arguments as List<dynamic>;

    final ThemeData theme = Theme.of(context);

    Future<void> pickImage() async {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
      );
      if (image != null) {
        if (kDebugMode) {
          print(_pickedImage!.path);
        }

        setState(() {
          _pickedImage = File(image.path);
        });
      }
    }

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: 200,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    color: Colors.grey[350],
                  ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 40,
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: pickImage,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 7,
                              horizontal: 15,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              color: AppTheme.primaryColor,
                            ),
                            child: Text(
                              'Add product image',
                              style: theme.textTheme.titleSmall!.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 20,
                    left: 15,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.arrow_back_rounded,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 30,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.info, color: Colors.white, size: 15),
                        SizedBox(width: 3),
                        Text(
                          'No image needed for review',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        values[0].name,
                        style: theme.textTheme.titleMedium!.copyWith(
                          color: AppTheme.primaryColor,
                        ),
                      ),
                      // const SizedBox(height: 5),
                      // Text(
                      //   'Mobile & Accesories',
                      //   style: TextStyle(color: Colors.grey[500]),
                      // ),
                      const SizedBox(height: 20),
                      Text(
                        values[1]!,
                        style: theme.textTheme.titleMedium,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        values[2]!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: List.generate(
                              5,
                              (int index) {
                                return Icon(
                                  Icons.star,
                                  size: 20,
                                  color: index > values[3]
                                      ? Colors.amber[200]
                                      : Colors.amber,
                                );
                              },
                            ),
                          ),
                          Text(
                            DateFormat.yMMMMEEEEd().format(
                              DateTime.now(),
                            ),
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey[500],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 120),
          ],
        ),
        bottomSheet: SizedBox(
          height: 120,
          width: double.infinity,
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey[200]!,
                        offset: const Offset(0, -8),
                        spreadRadius: 5,
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      'Back to edit review',
                      style: theme.textTheme.titleMedium!.copyWith(
                        color: AppTheme.primaryColor,
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  WalletState walletState =
                      BlocProvider.of<WalletBloc>(context).state;

                  if (walletState is WalletLoaded) {
                    await ReviewsRepository().postReview(
                      title: values[1],
                      description: values[2],
                      stars: values[3] + 1,
                      locationId: values[0].id,
                      wallet: walletState.wallet,
                    );
                    if (!mounted) return;
                    context.read<ReviewsBloc>().add(ReviewsStarted());
                  }
                  if (!mounted) return;
                  Nav.toClearAll(context, ListScreen.route);
                },
                child: Container(
                  height: 60,
                  color: AppTheme.primaryColor,
                  child: Center(
                    child: Text(
                      'Upload image & submit',
                      style: theme.textTheme.titleMedium!.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
