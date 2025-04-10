import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:tv_series/domain/entities/tv_entity.dart';
import 'package:tv_series/domain/repositories/tv_repository.dart';

class GetTvAiringToday {
  final TvRepository repository;

  GetTvAiringToday(this.repository);

  Future<Either<Failure, List<TvEntity>>> execute() {
    return repository.getAiringTodayTv();
  }
}
