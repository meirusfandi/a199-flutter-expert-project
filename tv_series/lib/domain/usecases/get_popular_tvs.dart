import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:tv_series/domain/entities/tv_entity.dart';
import 'package:tv_series/tv_series.dart';

class GetPopularTvs {
  final TvRepository repository;

  GetPopularTvs(this.repository);

  Future<Either<Failure, List<TvEntity>>> execute() {
    return repository.getPopularTv();
  }
}
