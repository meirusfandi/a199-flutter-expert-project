import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_entity.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tvs.dart';
import 'package:flutter/foundation.dart';

class TopRatedTvNotifier extends ChangeNotifier {
  final GetTopRatedTvs getTopRatedTv;

  TopRatedTvNotifier({required this.getTopRatedTv});

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<TvEntity> _Tv = [];
  List<TvEntity> get Tv => _Tv;

  String _message = '';
  String get message => _message;

  Future<void> fetchTopRatedTv() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getTopRatedTv.execute();

    result.fold(
          (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
          (TvData) {
        _Tv = TvData;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
