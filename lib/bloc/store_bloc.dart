import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'store_event.dart';
part 'store_state.dart';

class StoreBloc extends Bloc<StoreEvent, StoreState> {
  StoreBloc() : super(StoreState()) {
    on<GetProductsEvent>((event, emit) {
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
}
