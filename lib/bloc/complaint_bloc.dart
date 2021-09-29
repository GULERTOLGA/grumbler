import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:grumbler/models/compliant.dart';

abstract class ComplaintFormState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ComplaintFormInitialState extends ComplaintFormState {}

class ComplaintFormLoadingState extends ComplaintFormState {}

class ComplaintFormErrorState extends ComplaintFormState {}

class ComplaintFormChangedState extends ComplaintFormState {
  final Complaint complaint;
  ComplaintFormChangedState(this.complaint);
  @override
  List<Object?> get props => [complaint];
}

abstract class ComplaintFormEvent extends Equatable {}

class ComplaintFormLoadEvent extends ComplaintFormEvent {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class ComplaintFormBloc extends Bloc<ComplaintFormEvent, ComplaintFormState> {
  ComplaintFormBloc(ComplaintFormState initialState) : super(initialState);

  @override
  Stream<ComplaintFormState> mapEventToState(ComplaintFormEvent event) async* {
    if (event is ComplaintFormLoadEvent) {}
  }
}
