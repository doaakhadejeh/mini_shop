import 'package:equatable/equatable.dart';

sealed class DetailesProductState extends Equatable {}

class DetailesProductInitial extends DetailesProductState {
  @override
  List<Object?> get props => [];
}

class DetailesProductUpdated extends DetailesProductState {
  @override
  List<Object?> get props => [];
}
