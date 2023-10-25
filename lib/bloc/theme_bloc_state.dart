part of 'theme_bloc_bloc.dart';

sealed class ThemeBlocState extends Equatable {
  const ThemeBlocState();
  
  @override
  List<Object> get props => [];
}

final class ThemeBlocInitial extends ThemeBlocState {}
