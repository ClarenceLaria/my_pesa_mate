import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kurerefinancialplanner_app/apis/apis.dart';
import 'package:kurerefinancialplanner_app/bloc/transaction/transaction_event.dart';
import 'package:kurerefinancialplanner_app/bloc/transaction/transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  TransactionBloc() : super(TransactionInitialState()) {
    on<LoadTransactionsEvent>((event, emit) async {
      emit(TransactionLoadingState());

      try{
        final transactions = await APIService.getTransactions();
        emit(TransactionLoadedState(transactions));
      } catch (error) {
        emit(const TransactionErrorState("Failed to load transactions"));
      }
    },);
  }
}