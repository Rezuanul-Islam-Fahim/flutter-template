import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/wallet/wallet_bloc.dart';
import '../core/app_theme.dart';
import '../screens/signin_screen.dart';
import '../utils/navigator.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return BlocBuilder<WalletBloc, WalletState>(
      builder: (BuildContext context, WalletState state) {
        if (state is WalletLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is WalletLoaded) {
          return Drawer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.network(
                          'https://www.coindesk.com/resizer/nTRt4wlfN33AlXPRuSjL24XcgqY=/arc-photo-coindesk/arc2-prod/public/F5AFQN2V2JHUNPYYAAUSSTUDK4.jpg',
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 15),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 90,
                            child: Text(
                              state.wallet.publicKey!,
                              style: theme.textTheme.titleMedium,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'View Profile',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey[500],
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              _buildInfo(
                                data: '1.2k',
                                title: 'Points',
                                theme: theme,
                              ),
                              const SizedBox(width: 20),
                              _buildInfo(
                                data: '12,45,678',
                                title: 'Global Rank',
                                theme: theme,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () => Nav.toClearAll(context, SigninScreen.route),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 40,
                    ),
                    child: Text('Logout', style: theme.textTheme.titleLarge),
                  ),
                ),
              ],
            ),
          );
        }

        return const Text('Unknown error occurred');
      },
    );
  }

  Widget _buildInfo({
    required String data,
    required String title,
    required ThemeData theme,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          data,
          style: theme.textTheme.titleSmall!.copyWith(
            color: AppTheme.primaryColor,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          title,
          style: TextStyle(
            color: Colors.grey[500],
            fontSize: 13,
          ),
        ),
      ],
    );
  }
}
