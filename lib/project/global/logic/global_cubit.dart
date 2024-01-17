import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../config/constants/app_constants/constants.dart';
import '../../../models/map/map_point_model.dart';
import '../../../models/search/search_model.dart';
import '../domain/global_repository.dart';
part 'global_state.dart';

class GlobalCubit extends Cubit<GlobalState> {
  final _repository = GlobalRepository();
  GlobalCubit() : super(const GlobalState());

  void get setApp async {
    final themeResponse = _repository.getCurrentTheme;
    final langResponse = _repository.getCurrentLang;
    emit(state.copyWith(
      themeState: themeResponse.state,
      langState: langResponse.state,
      currentLang: langResponse.data,
      currentTheme: themeResponse.data,
      msg: themeResponse.msg,
    ));
  }

  void setTheme(int theme) async {
    emit(state.copyWith(themeState: Status.loading));
    final themeResult = await _repository.setTheme(theme);
    emit(state.copyWith(
      themeState: themeResult.state,
      error: themeResult.error,
      currentTheme: themeResult.data,
    ));
  }

  void setLang(String lang) async {
    emit(state.copyWith(langState: Status.loading));
    final langResult = await _repository.setLang(lang);
    emit(state.copyWith(
      langState: langResult.state,
      error: langResult.error,
      currentLang: langResult.data,
    ));
  }

  void search(String value) async {
    emit(state.copyWith(searchState: Status.loading));
    final result = await _repository.search(value, state.isUser);
    emit(state.copyWith(
      searchList: result.data,
      searchState: result.state,
      msg: result.msg,
      error: result.error,
    ));
  }

  void get getMapPoints async {
    emit(state.copyWith(getMapPointsState: Status.loading));
    final result = await _repository.getMapPoints;
    emit(state.copyWith(
      mapPoints: result.data,
      getMapPointsState: result.state,
      msg: result.msg,
      error: result.error,
    ));
  }

  void setSearch(bool value) =>
      emit(state.copyWith(isUser: value, searchList: []));
  void setScreen(int page) => emit(state.copyWith(currentScreen: page));
  void get initSearch =>
      emit(state.copyWith(searchList: [], searchState: Status.initial));

  bool get isLoggedIn => _repository.isLoggedIn.data;
  int get getCurrentTheme => state.currentTheme;
  int get getCurrentScreen => state.currentScreen;
  String get getCurrentLang => state.currentLang;
}
