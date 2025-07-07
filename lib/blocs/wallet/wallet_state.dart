part of 'wallet_bloc.dart';

@immutable
abstract class WalletState extends Equatable {
  const WalletState();

  @override
  List<Object> get props => [];
}

class WalletLoaded extends WalletState {
  const WalletLoaded({required this.wallet});

  final Wallet wallet;

  @override
  List<Object> get props => [wallet];
}

class WalletLoading extends WalletState {
  const WalletLoading();

  @override
  List<Object> get props => [];
}

class WalletError extends WalletState {
  const WalletError();

  @override
  List<Object> get props => [];
}
