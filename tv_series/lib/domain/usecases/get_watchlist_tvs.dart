import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:tv_series/domain/entities/tv_entity.dart';
import 'package:tv_series/domain/repositories/tv_repository.dart';

class GetWatchlistTvs {
  final TvRepository repository;

  GetWatchlistTvs(this.repository);

  Future<Either<Failure, List<TvEntity>>> execute() async {
    return repository.getWatchlistTvs();
  }
}
