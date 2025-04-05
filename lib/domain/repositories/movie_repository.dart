import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_entity.dart';

abstract class MovieRepository {
  Future<Either<Failure, List<Movie>>> getNowPlayingMovies();
  Future<Either<Failure, List<Movie>>> getPopularMovies();
  Future<Either<Failure, List<Movie>>> getTopRatedMovies();
  Future<Either<Failure, MovieDetail>> getMovieDetail(int id);
  Future<Either<Failure, List<Movie>>> getMovieRecommendations(int id);
  Future<Either<Failure, List<Movie>>> searchMovies(String query);
  Future<Either<Failure, String>> saveWatchlist(MovieDetail movie);
  Future<Either<Failure, String>> removeWatchlist(MovieDetail movie);
  Future<bool> isAddedToWatchlist(int id);
  Future<Either<Failure, List<Movie>>> getWatchlistMovies();

  // tv section
  Future<Either<Failure, List<TvEntity>>> getAiringTodayTv();
  Future<Either<Failure, List<TvEntity>>> getPopularTv();
  Future<Either<Failure, List<TvEntity>>> getTopRatedTv();
  // Future<Either<Failure, MovieDetail>> getTvDetail(int id);
  Future<Either<Failure, List<TvEntity>>> getTvRecommendations(int id);
  Future<Either<Failure, List<TvEntity>>> searchTv(String query);
}
