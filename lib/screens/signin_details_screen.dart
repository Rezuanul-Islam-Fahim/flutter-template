import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phantom_connect/phantom_connect.dart';
import 'package:uni_links/uni_links.dart';
import 'package:url_launcher/url_launcher.dart';

import '../blocs/reviews/reviews_bloc.dart';
import '../blocs/wallet/wallet_bloc.dart';
import '../core/app_theme.dart';
import '../utils/logger.dart';
import '../utils/navigator.dart';
import '../utils/nonce.dart';
import '../widgets/form_info.dart';
import 'list_screen.dart';

class SigninDetailsScreen extends StatefulWidget {
  const SigninDetailsScreen({super.key});

  static const String route = '/signin-details';

  @override
  State<SigninDetailsScreen> createState() => _SigninDetailsScreenState();
}

class _SigninDetailsScreenState extends State<SigninDetailsScreen> {
  final phantomConnectInstance = PhantomConnect(
    appUrl: "https://solgallery.vercel.app",
    deepLink: "dapp://phantomconnect.io",
  );
  late StreamSubscription sub;

  Future<void> _signInAuth() async {
    Uint8List nonce = generateNonce();
    Uri launchUri = phantomConnectInstance.generateSignMessageUri(
      nonce: nonce,
      redirect: '/onSignMessage',
    );
    logger.i(launchUri);
    await launchUrl(
      launchUri,
      mode: LaunchMode.externalApplication,
    );
  }

  void _handleIncomingLinks() async {
    try {
      sub = uriLinkStream.listen((Uri? link) {
        if (!mounted) return;

        Map<String, String> params = link?.queryParameters ?? {};
        logger.i("Params: $params");
        if (params.containsKey("errorCode")) {
          // _showSnackBar(context,
          //     params["errorMessage"] ?? "Error connecting wallet", "error");
          logger.e(params["errorMessage"]);
        } else {
          switch (link?.path) {
            case '/connected':
              {
                if (kDebugMode) {
                  print('Successfully connected');
                }
                if (phantomConnectInstance.createSession(params)) {
                  _signInAuth();
                } else {}
              }
              break;
            // case '/disconnect':
            //   setState(() {});
            //   break;
            case '/signAndSendTransaction':
              // var data = phantomConnectInstance.decryptPayload(
              //   data: params["data"]!,
              //   nonce: params["nonce"]!,
              // );
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => TransactionStatus(
              //       signature: data['signature'],
              //     ),
              //   ),
              // );
              break;
            case '/signTransaction':
              // var data = phantomConnectInstance.decryptPayload(
              //   data: params["data"]!,
              //   nonce: params["nonce"]!,
              // );
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => SendTxScreen(
              //       transaction: data["transaction"],
              //     ),
              //   ),
              // );
              break;
            case '/onSignMessage':
              var data = phantomConnectInstance.decryptPayload(
                data: params["data"]!,
                nonce: params["nonce"]!,
              );
              if (kDebugMode) {
                print(data);
                print('Successfully sent message');
              }

              context.read<WalletBloc>().add(
                    WalletRequested(
                      data: {
                        'publicKey': data['publicKey'],
                        'signature': data['signature'],
                        'message': nonce,
                      },
                    ),
                  );

              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => SignatureVerifyScreen(
              //       signature: data['signature'],
              //       phantomConnectInstance: phantomConnectInstance,
              //     ),
              //   ),
              // );
              break;
            default:
              logger.i('unknown');
          }
        }
      }, onError: (err) {
        logger.e('OnError Error: $err');
      });
    } on PlatformException {
      // Handle exception by warning the user their action did not succeed
      logger.e("Error occured PlatfotmException");
      return;
    }
  }

  @override
  void initState() {
    super.initState();
    _handleIncomingLinks();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return BlocListener<WalletBloc, WalletState>(
      listener: (BuildContext context, WalletState state) {
        if (state is WalletLoaded) {
          context.read<ReviewsBloc>().add(ReviewsStarted());
          Nav.toClearAll(context, ListScreen.route);
        }
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: const Text('Join Kallo'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                FormInfo(
                  title: 'My Password is',
                  inputHintText: 'Enter your password',
                ),
                SizedBox(height: 20),
                FormInfo(
                  title: 'New Account',
                  inputHintText: 'Yes',
                  enabled: false,
                ),
              ],
            ),
          ),
          bottomSheet: GestureDetector(
            onTap: () async {
              Uri launchUri = phantomConnectInstance.generateConnectUri(
                cluster: 'mainnet-beta',
                redirect: '/connected',
              );
              logger.d(launchUri);
              await launchUrl(
                launchUri,
                mode: LaunchMode.externalApplication,
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
      ),
    );
  }
}
