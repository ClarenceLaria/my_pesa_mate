import 'package:equatable/equatable.dart';
import 'package:kurerefinancialplanner_app/models/transaction_model.dart';

abstract class TransactionEvent extends Equatable {
  const TransactionEvent();

  @override
  List<Object?> get props => [];
}

class LoadTransactionsEvent extends TransactionEvent {}

class UpdateTransactionListEvent extends TransactionEvent {
  const UpdateTransactionListEvent(this.transactions);

  final List<FetchedTransaction> transactions;

  @override
  List<Object?> get props => [transactions];
}