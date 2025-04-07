import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_entity.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tvs.dart';
import 'package:flutter/foundation.dart';

class WatchlistTvNotifier extends ChangeNotifier {
  var _watchlistTvs = <TvEntity>[];
  List<TvEntity> get watchlistTvs => _watchlistTvs;

  var _watchlistState = RequestState.Empty;
  RequestState get watchlistState => _watchlistState;

  String _message = '';
  String get message => _message;

  WatchlistTvNotifier({required this.getWatchlistTvs});

  final GetWatchlistTvs getWatchlistTvs;

  Future<void> fetchWatchlistTv() async {
    _watchlistState = RequestState.Loading;
    notifyListeners();

    final result = await getWatchlistTvs.execute();
    result.fold(
          (failure) {
        _watchlistState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
          (tvsData) {
        _watchlistState = RequestState.Loaded;
        _watchlistTvs = tvsData;
        notifyListeners();
      },
    );
  }
}