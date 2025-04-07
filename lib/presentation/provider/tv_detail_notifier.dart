import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:ditonton/domain/entities/tv_entity.dart';
import 'package:ditonton/domain/usecases/get_tv_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_recommendation.dart';
import 'package:ditonton/domain/usecases/get_tv_watchlist_status.dart';
import 'package:ditonton/domain/usecases/remove_tv_watchlist.dart';
import 'package:ditonton/domain/usecases/save_tv_watchlist.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TvDetailNotifier extends ChangeNotifier {
  static const watchlistAddSuccessMessage = 'Added TV to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed TV from Watchlist';

  final GetTvDetail getTvDetail;
  final GetTvRecommendation getTvRecommendations;
  final GetTVWatchlistStatus getWatchListStatus;
  final SaveTvWatchlist saveWatchlist;
  final RemoveTvWatchlist removeWatchlist;

  TvDetailNotifier({
    required this.getTvDetail,
    required this.getTvRecommendations,
    required this.getWatchListStatus,
    required this.saveWatchlist,
    required this.removeWatchlist,
  });

  late TvDetail _Tv;
  TvDetail get Tv => _Tv;

  RequestState _TvState = RequestState.Empty;
  RequestState get TvState => _TvState;

  List<TvEntity> _TvRecommendations = [];
  List<TvEntity> get TvRecommendations => _TvRecommendations;

  RequestState _recommendationState = RequestState.Empty;
  RequestState get recommendationState => _recommendationState;

  String _message = '';
  String get message => _message;

  bool _isAddedtoWatchlist = false;
  bool get isAddedToWatchlist => _isAddedtoWatchlist;

  Future<void> fetchTvDetail(int id) async {
    _TvState = RequestState.Loading;
    notifyListeners();
    final detailResult = await getTvDetail.execute(id);
    final recommendationResult = await getTvRecommendations.execute(id);
    detailResult.fold(
          (failure) {
        _TvState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
          (Tv) {

        _recommendationState = RequestState.Loading;
        _Tv = Tv;
        notifyListeners();
        recommendationResult.fold(
              (failure) {
            _recommendationState = RequestState.Error;
            _message = failure.message;
          },
              (Tvs) {
            _recommendationState = RequestState.Loaded;
            _TvRecommendations = Tvs;
          },
        );
        _TvState = RequestState.Loaded;
        notifyListeners();
      },
    );
  }

  String _watchlistMessage = '';
  String get watchlistMessage => _watchlistMessage;

  Future<void> addWatchlist(TvDetail Tv) async {
    final result = await saveWatchlist.execute(Tv);

    await result.fold(
          (failure) async {
        _watchlistMessage = failure.message;
      },
          (successMessage) async {
        _watchlistMessage = successMessage;
      },
    );

    await loadWatchlistStatus(Tv.id);
  }

  Future<void> removeFromWatchlist(TvDetail Tv) async {
    final result = await removeWatchlist.execute(Tv);

    await result.fold(
          (failure) async {
        _watchlistMessage = failure.message;
      },
          (successMessage) async {
        _watchlistMessage = successMessage;
      },
    );

    await loadWatchlistStatus(Tv.id);
  }

  Future<void> loadWatchlistStatus(int id) async {
    final result = await getWatchListStatus.execute(id);
    _isAddedtoWatchlist = result;
    notifyListeners();
  }
}
