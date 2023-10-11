part of 'store_bloc.dart';

abstract class StoreEvent extends Equatable {
  const StoreEvent();

  @override
  List<Object> get props => [];
}

class GetProductsEvent extends StoreEvent {}

class AddCarEvent extends StoreEvent {
  AddCarEvent();

  @override
  List<Object> get props => [];
}

class AddProductEvent extends StoreEvent {
  AddProductEvent();

  @override
  List<Object> get props => [];
}

class DeleteProductEvent extends StoreEvent {
  DeleteProductEvent();

  @override
  List<Object> get props => [];
}

class ShowDetailProduct extends StoreEvent {
  ShowDetailProduct();

  @override
  List<Object> get props => [];
}

class ViewCarEvent extends StoreEvent {
  ViewCarEvent();

  @override
  List<Object> get props => [];
}

class SearchEvent extends StoreEvent {
  SearchEvent();

  @override
  List<Object> get props => [];
}

class QrEvent extends StoreEvent {
  QrEvent();

  @override
  List<Object> get props => [];
}

class LoginEvent extends StoreEvent {
  LoginEvent();

  @override
  List<Object> get props => [];
}

class RegisterEvent extends StoreEvent {
  RegisterEvent();

  @override
  List<Object> get props => [];
}

class PayEvent extends StoreEvent {
  PayEvent();

  @override
  List<Object> get props => [];
}

class DeleteCarEvent extends StoreEvent {
  DeleteCarEvent();

  @override
  List<Object> get props => [];
}

class IncreaseProdcutEvent extends StoreEvent {
  IncreaseProdcutEvent();

  @override
  List<Object> get props => [];
}

class DecreseaseProductEvent extends StoreEvent {
  DecreseaseProductEvent();

  @override
  List<Object> get props => [];
}
