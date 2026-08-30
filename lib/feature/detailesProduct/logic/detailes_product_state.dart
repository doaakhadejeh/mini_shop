import 'package:equatable/equatable.dart';

sealed class DetailesProductState extends Equatable {}

class DetailesProductInitial extends DetailesProductState {
  @override
  List<Object?> get props => [];
}

class DetailesProductUpdated extends DetailesProductState {
  final int quantity;
  DetailesProductUpdated(this.quantity);
  @override
  List<Object?> get props => [quantity];
}
