part of 'wallet_bloc.dart';

@immutable
abstract class WalletEvent extends Equatable {
  const WalletEvent();

  @override
  List<Object> get props => [];
}

class WalletRequested extends WalletEvent {
  const WalletRequested({required this.data});

  final Map<String, dynamic> data;

  @override
  List<Object> get props => [];
}
