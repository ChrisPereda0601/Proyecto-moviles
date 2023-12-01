import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tienda_online/Pages/main_products.dart';
// import 'package:flutter/material.dart';
// import 'package:tienda_online/models/product.dart';
// import 'package:flutter/material.dart';
// import 'package:tienda_online/models/product.dart';

part 'store_event.dart';
part 'store_state.dart';

Map<String, dynamic> _productDetail = {};
Map<String, dynamic> get getProductDetail => _productDetail;

class Detail {
  void setProductDetail(Map<String, dynamic> productDetail) {
    _productDetail = productDetail;
  }
}

class StoreBloc extends Bloc<StoreEvent, StoreState> {
  StoreBloc() : super(StoreState()) {
    on<GetProductsEvent>((event, emit) {
      emit(LoadingState());
      emit(StoreHomeState());
    });
    on<AddProductEvent>((event, emit) {
      emit(LoadingState());
      emit(StoreCarState());
    });
    on<DeleteProductEvent>((event, emit) {
      emit(LoadingState());
      emit(StoreCarState());
    });
    on<ShowDetailProduct>((event, emit) {
      _productDetail = event.data;
      emit(StoreDetailState());
    });
    on<ShowOrderProduct>((event, emit) {
      emit(StoreOrderState());
    });
    on<ViewCarEvent>((event, emit) {
      emit(StoreCarState());
    });
    on<SearchEvent>((event, emit) {
      emit(LoadingState());
      emit(StoreSearchState());
    });
    on<QrEvent>((event, emit) {
      emit(StoreCarState());
    });
    on<LoginEvent>((event, emit) {
      emit(StoreLoginState());
    });
    on<RegisterEvent>((event, emit) {
      emit(StoreRegisterState());
    });
    on<PayEvent>((event, emit) {
      emit(PayState());
    });
    on<NoConnectionEvent>((event, emit) async {
      bool hasConnection = await ConnectivityService().hasConnection();

      if (!hasConnection) {
        emit(NoConnectionState());
      } else {
        emit(StoreLoginState());
      }
    });
    on<ViewOrdersEvent>((event, emit) {
      emit(StoreOrdersState());
    });
    on<UpdateCartEvent>((event, emit) {
      emit(LoadingState());

      Future.delayed(Duration(milliseconds: 300));

      emit(StoreUpdateState());
    });
    on<DeleteCarEvent>((event, emit) {
      emit(LoadingState());

      emit(StoreDeleteState());
    });
    on<ChangePageEvent>((event, emit) {
      emit(LoadingState());

      switch (event.newIndex) {
        case 0:
          emit(StoreHomeState());
          break;
        case 1:
          emit(StoreSearchState());
          break;
        case 2:
          emit(StoreCarState());
          break;
        case 3:
          emit(StoreOrdersState());
          break;
        default:
          emit(StoreHomeState());
      }
    });

    // on<StoreEvent>((event, emit) {});

    //   FutureOr<void> _getAllProducts(
    //     GetProductsEvent event, Emitter emit) async {
    //   try {
    //     emit(AmphibianLoadingState());
    //     var res = await get(
    //       Uri.parse(
    //           'https://developer.android.com/courses/pathways/android-basics-kotlin-unit-4-pathway-2/android-basics-kotlin-unit-4-pathway-2-project-api.json'),
    //     );
    //     if (res.statusCode == 200) {
    //       _amphibians = (jsonDecode(res.body) as List)
    //           .map((e) => Amphibian.fromMap(e))
    //           .toList();
    //       if (_amphibians == []) {
    //         emit(AmphibianUnavailableState());
    //       } else {
    //         emit(AmphibianSucessState(amphibianList: _amphibians));
    //       }
    //     } else {
    //       print("Error de respuesta http");
    //       emit(AmphibianUnavailableState());
    //     }
    //   } catch (e) {
    //     print("Error: ${e.toString()}.");
    //     emit(AmphibianErrorState());
    //   }
    // }
  }
}
