import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_entity.dart';
import 'package:ditonton/domain/repositories/tv_repository.dart';

class GetWatchlistTvs {
  final TvRepository repository;

  GetWatchlistTvs(this.repository);

  Future<Either<Failure, List<TvEntity>>> execute() async {
    return repository.getWatchlistTvs();
  }
}
