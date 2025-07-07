import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../models/wallet.dart';
import '../../repositories/wallet_repository.dart';

part 'wallet_event.dart';
part 'wallet_state.dart';

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  WalletBloc() : super(const WalletLoading()) {
    on<WalletRequested>(_onWalletRequest);
  }

  Future<void> _onWalletRequest(
    WalletRequested event,
    Emitter<WalletState> emit,
  ) async {
    final WalletRepository repository = WalletRepository();
    emit(const WalletLoading());
    try {
      final Wallet wallet = await repository.getWallet(event.data);
      emit(WalletLoaded(wallet: wallet));
    } catch (_) {
      if (kDebugMode) {
        print('Error occurred');
        emit(const WalletError());
      }
    }
  }
}
