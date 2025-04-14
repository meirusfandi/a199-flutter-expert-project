import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_entity.dart';
import 'package:ditonton/domain/usecases/get_popular_tvs.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tvs.dart';
import 'package:ditonton/domain/usecases/get_tv_airing_today.dart';
import 'package:flutter/material.dart';

class TvListNotifier extends ChangeNotifier {
  var _airingTodayTv = <TvEntity>[];
  List<TvEntity> get airingTodayTv => _airingTodayTv;

  RequestState _airingTodayState = RequestState.Empty;
  RequestState get airingTodayState => _airingTodayState;

  var _popularTv = <TvEntity>[];
  List<TvEntity> get popularTv => _popularTv;

  RequestState _popularTvState = RequestState.Empty;
  RequestState get popularTvState => _popularTvState;

  var _topRatedTv = <TvEntity>[];
  List<TvEntity> get topRatedTv => _topRatedTv;

  RequestState _topRatedTvState = RequestState.Empty;
  RequestState get topRatedTvState => _topRatedTvState;

  String _message = '';
  String get message => _message;

  final GetTvAiringToday getTvAiringToday;
  final GetPopularTvs getPopularTvs;
  final GetTopRatedTvs getTopRatedTvs;

  TvListNotifier({
    required this.getTvAiringToday,
    required this.getPopularTvs,
    required this.getTopRatedTvs,
  });

  Future<void> fetchAiringTodayTv() async {
    _airingTodayState = RequestState.Loading;
    notifyListeners();

    final result = await getTvAiringToday.execute();
    result.fold(
      (failure) {
        _airingTodayState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (TvData) {
        _airingTodayState = RequestState.Loaded;
        _airingTodayTv = TvData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchPopularTv() async {
    _popularTvState = RequestState.Loading;
    notifyListeners();

    final result = await getPopularTvs.execute();
    result.fold(
      (failure) {
        _popularTvState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (TvData) {
        _popularTvState = RequestState.Loaded;
        _popularTv = TvData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchTopRatedTv() async {
    _topRatedTvState = RequestState.Loading;
    notifyListeners();

    final result = await getTopRatedTvs.execute();
    result.fold(
      (failure) {
        _topRatedTvState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (TvData) {
        _topRatedTvState = RequestState.Loaded;
        _topRatedTv = TvData;
        notifyListeners();
      },
    );
  }
}
