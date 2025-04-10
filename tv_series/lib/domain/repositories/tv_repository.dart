import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:tv_series/domain/entities/tv_detail.dart';
import 'package:tv_series/domain/entities/tv_entity.dart';

abstract class TvRepository {
  Future<Either<Failure, List<TvEntity>>> getAiringTodayTv();
  Future<Either<Failure, List<TvEntity>>> getPopularTv();
  Future<Either<Failure, List<TvEntity>>> getTopRatedTv();
  Future<Either<Failure, TvDetail>> getTvDetail(int id);
  Future<Either<Failure, List<TvEntity>>> getTvRecommendations(int id);
  Future<Either<Failure, List<TvEntity>>> searchTv(String query);
  Future<Either<Failure, String>> saveTVWatchlist(TvDetail tv);
  Future<Either<Failure, String>> removeTVWatchlist(TvDetail tv);
  Future<bool> isAddedTVToWatchlist(int id);
  Future<Either<Failure, List<TvEntity>>> getWatchlistTvs();
}
