part of 'store_bloc.dart';

class StoreState extends Equatable {
  StoreState();

  @override
  List<Object> get props => [];
}

final class StoreHomeState extends StoreState {}

final class StoreSearchState extends StoreState {}

final class StoreDetailState extends StoreState {}

final class StoreOrderState extends StoreState {}

final class StoreCarState extends StoreState {}

final class StoreLoginState extends StoreState {}

final class StoreRegisterState extends StoreState {}

final class ProfileState extends StoreState {}

final class PayState extends StoreState {}

final class LoadingState extends StoreState {}

//Estados para adición de productos a carrito
final class RetrievedProductsProcessingState extends StoreState {}

final class RetrievedProductsState extends StoreState {
  final List<dynamic> productsList;

  RetrievedProductsState({required this.productsList});
  @override
  List<Object> get props => [productsList];
}

final class RetrievedProductsErrorState extends StoreState {
  final String errorMsg;

  RetrievedProductsErrorState({required this.errorMsg});
  @override
  List<Object> get props => [errorMsg];
}

final class FormSavedState extends StoreState {}

final class FormSavedErrorState extends StoreState {
  final String errorMsg;

  FormSavedErrorState({required this.errorMsg});
  @override
  List<Object> get props => [errorMsg];
}

//Estado para falta de conexión
final class NoConnectionState extends StoreState {}

//Manejo de pedidos
final class StoreOrdersState extends StoreState {}

final class StoreUpdateState extends StoreState {}

final class StoreDeleteState extends StoreState {}
