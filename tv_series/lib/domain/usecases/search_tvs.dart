import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:tv_series/domain/entities/tv_entity.dart';
import 'package:tv_series/domain/repositories/tv_repository.dart';

class SearchTvs {
  final TvRepository repository;

  SearchTvs(this.repository);

  Future<Either<Failure, List<TvEntity>>> execute(query) {
    return repository.searchTv(query);
  }
}
