import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_entity.dart';
import 'package:ditonton/domain/usecases/search_tvs.dart';
import 'package:flutter/foundation.dart';

class TvSearchNotifier extends ChangeNotifier {
  final SearchTvs searchTv;

  TvSearchNotifier({required this.searchTv});

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<TvEntity> _searchResult = [];
  List<TvEntity> get searchResult => _searchResult;

  String _message = '';
  String get message => _message;

  Future<void> fetchTvSearch(String query) async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await searchTv.execute(query);
    result.fold(
          (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
          (data) {
        _searchResult = data;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
