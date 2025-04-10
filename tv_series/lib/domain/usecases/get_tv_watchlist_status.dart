import 'package:tv_series/domain/repositories/tv_repository.dart';

class GetTVWatchlistStatus {
  final TvRepository repository;

  GetTVWatchlistStatus(this.repository);

  Future<bool> execute(int id) async {
    return repository.isAddedTVToWatchlist(id);
  }
}
