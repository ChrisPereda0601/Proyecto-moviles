part of 'store_bloc.dart';

abstract class StoreEvent extends Equatable {
  const StoreEvent();

  @override
  List<Object> get props => [];
}

class GetProductsEvent extends StoreEvent {
  GetProductsEvent();
}

class AddCarEvent extends StoreEvent {
  AddCarEvent();
}

class AddProductEvent extends StoreEvent {
  AddProductEvent();
}

class DeleteProductEvent extends StoreEvent {
  DeleteProductEvent();
}

// ignore: must_be_immutable
class ShowDetailProduct extends StoreEvent {
  var data;

  ShowDetailProduct(this.data);
}

class ShowOrderProduct extends StoreEvent {
  ShowOrderProduct();
}

class ViewCarEvent extends StoreEvent {
  ViewCarEvent();
}

// ignore: must_be_immutable
class SearchEvent extends StoreEvent {
  SearchEvent();
}

class QrEvent extends StoreEvent {
  QrEvent();
}

class LoginEvent extends StoreEvent {
  LoginEvent();
}

class RegisterEvent extends StoreEvent {
  RegisterEvent();
}

class PayEvent extends StoreEvent {
  PayEvent();
}

class DeleteCarEvent extends StoreEvent {
  DeleteCarEvent();
}

class IncreaseProdcutEvent extends StoreEvent {
  IncreaseProdcutEvent();
}

class DecreseaseProductEvent extends StoreEvent {
  DecreseaseProductEvent();
}

class NoConnectionEvent extends StoreEvent {
  NoConnectionEvent();
}

//Manejo de pedidos
class ViewOrdersEvent extends StoreEvent {
  ViewOrdersEvent();
}

class UpdateCartEvent extends StoreEvent {}

class ShowProfileEvent extends StoreEvent {}

class ChangePageEvent extends StoreEvent {
  final int newIndex;

  ChangePageEvent(this.newIndex);
}
