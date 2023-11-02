// import 'dart:async';

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
// import 'package:tienda_online/models/product.dart';
// import 'package:flutter/material.dart';
// import 'package:tienda_online/models/product.dart';

part 'store_event.dart';
part 'store_state.dart';

class StoreBloc extends Bloc<StoreEvent, StoreState> {
  List<dynamic> _productsList = [];
  List<dynamic> get getNotesList => _productsList;
  TextEditingController _productsController = TextEditingController();

  StoreBloc() : super(StoreState()) {
    on<GetStoredProductsEvent>(_onGetStoredNotesEvent);
    on<SaveProductToStorageEvent>(_onSaveNoteToStorageEvent);
    on<GetProductsEvent>((event, emit) {
      emit(StoreHomeState());
    });
    on<AddProductEvent>((event, emit) {
      emit(StoreCarState());
    });
    on<DeleteProductEvent>((event, emit) {
      emit(StoreCarState());
    });
    on<ShowDetailProduct>((event, emit) {
      emit(StoreDetailState());
    });
    on<ViewCarEvent>((event, emit) {
      emit(StoreCarState());
    });
    on<SearchEvent>((event, emit) {
      emit(StoreSearchState());
    });
    on<QrEvent>((event, emit) {
      emit(StoreCarState()); //emit pendiente
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
    on<DeleteCarEvent>((event, emit) {
      emit(StoreCarState());
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

  FutureOr<void> _onSaveNoteToStorageEvent(
    SaveProductToStorageEvent event,
    Emitter emit,
  ) async {
    var _notesBox = await Hive.openBox<dynamic>("productConfigs");
    try {
      emit(RetrievedProductsProcessingState());
      //: save notes to storage
      _productsList.add({
        "name": "${_productsController.text}",
        "price": "${_productsController.value}",
      });
      await _notesBox.put("records", _productsList);
      emit(FormSavedState());
    } catch (e) {
      emit(
        FormSavedErrorState(
            errorMsg: "Error al guardar los productos en storage..."),
      );
    }
  }

  FutureOr<void> _onGetStoredNotesEvent(
    GetStoredProductsEvent event,
    Emitter emit,
  ) async {
    try {
      emit(RetrievedProductsProcessingState());
      //: get stored data
      var _notesBox = await Hive.openBox<dynamic>("productConfigs");
      _productsList = _notesBox.values.first;
      emit(RetrievedProductsState(productsList: _productsList));
    } catch (e) {
      emit(
        RetrievedProductsErrorState(
          errorMsg: "No se encontraron productos guardadas...",
        ),
      );
    }
  }
}
