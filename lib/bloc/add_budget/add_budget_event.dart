import 'package:equatable/equatable.dart';
import 'package:kurerefinancialplanner_app/models/budget_model.dart';

class AddBudgetEvent extends Equatable{
  const AddBudgetEvent();

  @override
  List<Object?> get props => [];
}

class CreateBudgetEvent extends AddBudgetEvent {
  const CreateBudgetEvent({
    required this.budget,
  });

  final Budget budget;

  @override
  List<Object?> get props => [budget.category, budget.amount, budget.startDate, budget.startDate];
}