import 'package:equatable/equatable.dart';

abstract class AddTransactionEvent extends Equatable{
  const AddTransactionEvent();

  @override
  List<Object?> get props => [];
}

class CreateTransactionEvent extends AddTransactionEvent {
  const CreateTransactionEvent({
    required this.type,
    required this.amount,
    required this.category,
    required this.txnDate,    
  });
  
  final String type;
  final double amount;
  final String category;
  final DateTime txnDate;

  @override 
  List<Object?> get props => [type, amount, category, txnDate];
}