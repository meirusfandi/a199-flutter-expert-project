import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv_entity.dart';
import 'package:ditonton/domain/repositories/movie_repository.dart';
import 'package:ditonton/common/failure.dart';

class GetTvAiringToday {
  final MovieRepository repository;

  GetTvAiringToday(this.repository);

  Future<Either<Failure, List<TvEntity>>> execute() {
    return repository.getAiringTodayTv();
  }
}
