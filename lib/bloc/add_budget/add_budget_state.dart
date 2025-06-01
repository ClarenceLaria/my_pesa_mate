import 'package:equatable/equatable.dart';

abstract class AddBudgetState extends Equatable{
  const AddBudgetState();

  @override
  List<Object?> get props => [];
} 

class AddBudgetInitialState extends AddBudgetState {}

class AddBudgetLoadingState extends AddBudgetState {}

class AddBudgetSuccessState extends AddBudgetState {
  const AddBudgetSuccessState(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}

class AddBudgetFailureState extends AddBudgetState {
  const AddBudgetFailureState(this.error);

  final String error;

  @override
  List<Object?> get props => [error];
}