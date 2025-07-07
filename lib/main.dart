import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/reviews/reviews_bloc.dart';
import 'blocs/wallet/wallet_bloc.dart';
import 'core/app_theme.dart';
import 'core/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ReviewsBloc()),
        BlocProvider(create: (_) => WalletBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        routes: AppRoutes.routes,
        initialRoute: AppRoutes.initialRoute,
        theme: AppTheme.theme,
      ),
    );
  }
}
