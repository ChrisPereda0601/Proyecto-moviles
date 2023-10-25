import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'theme_bloc_event.dart';
part 'theme_bloc_state.dart';

class ThemeBlocBloc extends Bloc<ThemeBlocEvent, ThemeBlocState> {
  ThemeBlocBloc() : super(ThemeBlocInitial()) {
    on<ThemeBlocEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
