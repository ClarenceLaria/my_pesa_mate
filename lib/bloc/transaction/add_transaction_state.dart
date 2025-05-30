import 'package:equatable/equatable.dart';

abstract class AddTransactionState extends Equatable{
  const AddTransactionState();

  @override
  List<Object?> get props => [];
}

class AddTransactionInitialState extends AddTransactionState{}

class AddTransactionLoadingState extends AddTransactionState{}

class AddTransactionSuccessState extends AddTransactionState{
  const AddTransactionSuccessState(this.message);

  final String message;

  @override 
  List<Object?> get props => [message];
}

class AddTransactionFailureState extends AddTransactionState{
  const AddTransactionFailureState(this.error);

  final String error;

  @override
  List<Object?> get props => [error];
}