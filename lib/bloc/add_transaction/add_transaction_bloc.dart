import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kurerefinancialplanner_app/apis/apis.dart';
import 'package:kurerefinancialplanner_app/bloc/add_transaction/add_transaction_event.dart';
import 'package:kurerefinancialplanner_app/bloc/add_transaction/add_transaction_state.dart';



class AddTransactionBloc extends Bloc<AddTransactionEvent, AddTransactionState>{
  AddTransactionBloc() : super(AddTransactionInitialState()) {
    on<CreateTransactionEvent>((event, emit) async {
      emit(AddTransactionLoadingState());
      try{
        final response = await APIService.createTransaction(
          type: event.type.toUpperCase(), 
          category: event.category, 
          amount: event.amount, 
          date: event.txnDate,
        );

        if(response == 'Transaction created successfully'){
          emit(AddTransactionSuccessState(response));
        } else {
          emit(const AddTransactionFailureState('Failed to create transaction'));
        }
      }catch (error){
        emit(AddTransactionFailureState("Error: ${error.toString()}"));
      }
    },);
  }
}