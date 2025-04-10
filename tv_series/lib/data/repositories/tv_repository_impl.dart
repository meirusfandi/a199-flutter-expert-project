import 'dart:io';
import 'package:core/utils/exception.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:tv_series/data/datasources/tv_local_data_source.dart';
import 'package:tv_series/data/datasources/tv_remote_data_source.dart';
import 'package:tv_series/data/models/tv_table.dart';
import 'package:tv_series/domain/entities/tv_detail.dart';
import 'package:tv_series/domain/entities/tv_entity.dart';
import 'package:tv_series/domain/repositories/tv_repository.dart';

class TvRepositoryImpl implements TvRepository {
  final TvRemoteDataSource tvRemoteDataSource;
  final TvLocalDataSource tvLocalDataSource;

  TvRepositoryImpl(
      {required this.tvRemoteDataSource, required this.tvLocalDataSource});

  @override
  Future<Either<Failure, List<TvEntity>>> getAiringTodayTv() async {
    try {
      final result = await tvRemoteDataSource.getAiringToday();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<TvEntity>>> getPopularTv() async {
    try {
      final result = await tvRemoteDataSource.getPopularTvs();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<TvEntity>>> getTopRatedTv() async {
    try {
      final result = await tvRemoteDataSource.getTopRatedTvs();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<TvEntity>>> getTvRecommendations(int id) async {
    try {
      final result = await tvRemoteDataSource.getTvRecommendations(id);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<TvEntity>>> searchTv(String query) async {
    try {
      final result = await tvRemoteDataSource.searchTvs(query);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, TvDetail>> getTvDetail(int id) async {
    try {
      final result = await tvRemoteDataSource.getTvDetail(id);
      return Right(result.toEntity());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<TvEntity>>> getWatchlistTvs() async {
    final result = await tvLocalDataSource.getWatchlistTvs();
    return Right(result.map((data) => data.toEntity()).toList());
  }

  @override
  Future<bool> isAddedTVToWatchlist(int id) async {
    final result = await tvLocalDataSource.getTvById(id);
    return result != null;
  }

  @override
  Future<Either<Failure, String>> removeTVWatchlist(TvDetail tv) async {
    try {
      final result =
          await tvLocalDataSource.removeWatchlistTv(TvTable.fromEntity(tv));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> saveTVWatchlist(TvDetail tv) async {
    try {
      final result =
          await tvLocalDataSource.insertWatchlistTv(TvTable.fromEntity(tv));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      throw e;
    }
  }
}
