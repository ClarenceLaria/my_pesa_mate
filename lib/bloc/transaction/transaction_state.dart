import 'package:equatable/equatable.dart';
import 'package:kurerefinancialplanner_app/models/transaction_model.dart';

abstract class TransactionState extends Equatable{
  const TransactionState();

  @override
  List<Object?> get props => [];
}

class TransactionInitialState extends TransactionState {}

class TransactionLoadingState extends TransactionState {}

class TransactionErrorState extends TransactionState {
  const TransactionErrorState(this.error);

  final String error;

  @override
  List<Object?> get props => [error];
}

class TransactionLoadedState extends TransactionState {
  const TransactionLoadedState(this.transactions);

  final List<FetchedTransaction> transactions;

  @override
  List<Object?> get props => [transactions];
}