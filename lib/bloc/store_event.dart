part of 'store_bloc.dart';

abstract class StoreEvent extends Equatable {
  const StoreEvent();

  @override
  List<Object> get props => [];
}

class GetProductsEvent extends StoreEvent {
  GetProductsEvent();

  @override
  List<Object> get props => [];
}

class AddCarEvent extends StoreEvent {
  AddCarEvent();

  @override
  List<Object> get props => [];
}

class AddProductEvent extends StoreEvent {
  AddProductEvent();
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
}

// ignore: must_be_immutable
class SearchEvent extends StoreEvent {
  String product;
  SearchEvent(this.product);
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

class NoConnectionEvent extends StoreEvent {
  NoConnectionEvent();
}
