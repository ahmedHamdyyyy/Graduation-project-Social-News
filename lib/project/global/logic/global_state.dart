part of 'global_cubit.dart';

class GlobalState extends Equatable {
  final String msg;
  final ErrorType error;
  final int currentTheme;
  final int currentScreen;
  final bool isNetworkConnected;
  final bool isUser;
  final List<SearchModel> searchList;
  final List<MapPointModel> mapPoints;
  final String currentLang;
  final Status searchState;
  final Status getMapPointsState;
  final Status themeState;
  final Status langState;

  const GlobalState({
    this.msg = '',
    this.currentTheme = 0,
    this.currentScreen = 1,
    this.currentLang = 'en',
    this.isNetworkConnected = false,
    this.isUser = false,
    this.searchList = const [],
    this.mapPoints = const [],
    this.error = ErrorType.non,
    this.searchState = Status.initial,
    this.getMapPointsState = Status.initial,
    this.themeState = Status.initial,
    this.langState = Status.initial,
  });

  GlobalState copyWith({
    String? msg,
    bool? isNetworkConnected,
    bool? isUser,
    ErrorType? error,
    int? currentTheme,
    int? currentScreen,
    List<SearchModel>? searchList,
    List<MapPointModel>? mapPoints,
    String? currentLang,
    Status? searchState,
    Status? getMapPointsState,
    Status? themeState,
    Status? langState,
  }) =>
      GlobalState(
        msg: msg ?? this.msg,
        searchList: searchList ?? this.searchList,
        mapPoints: mapPoints ?? this.mapPoints,
        error: error ?? this.error,
        isNetworkConnected: isNetworkConnected ?? this.isNetworkConnected,
        isUser: isUser ?? this.isUser,
        currentScreen: currentScreen ?? this.currentScreen,
        currentTheme: currentTheme ?? this.currentTheme,
        currentLang: currentLang ?? this.currentLang,
        searchState: searchState ?? this.searchState,
        getMapPointsState: getMapPointsState ?? this.getMapPointsState,
        themeState: themeState ?? this.themeState,
        langState: langState ?? this.langState,
      );

  @override
  List<Object> get props => [
        msg,
        isNetworkConnected,
        isUser,
        error,
        searchList,
        currentScreen,
        currentTheme,
        currentLang,
        searchState,
        getMapPointsState,
        themeState,
        langState,
        mapPoints,
      ];
}
