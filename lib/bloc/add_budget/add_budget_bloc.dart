import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kurerefinancialplanner_app/apis/apis.dart';
import 'package:kurerefinancialplanner_app/bloc/add_budget/add_budget_event.dart';
import 'package:kurerefinancialplanner_app/bloc/add_budget/add_budget_state.dart';

class AddBudgetBloc extends Bloc<AddBudgetEvent, AddBudgetState> {
  AddBudgetBloc() : super(AddBudgetInitialState()) {
    on<CreateBudgetEvent>((event, emit) async {
      emit(AddBudgetLoadingState());

      try{
        final response = await APIService.createBudget(
          name: event.budget.category, 
          amount: event.budget.amount, 
          startDate: event.budget.startDate, 
          endDate: event.budget.endDate, 
        );

        if(response == 'Budget created successfully'){
          emit(AddBudgetSuccessState(response));
        } else {
          emit(const AddBudgetFailureState('Failed to create budget'));
        }
      } catch (error) {
        emit(AddBudgetFailureState("Error: ${error.toString()}"));
      }
    },);
  }
}