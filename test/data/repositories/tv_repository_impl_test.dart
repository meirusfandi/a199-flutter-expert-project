import 'dart:io';

import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/data/models/genre_model.dart';
import 'package:tv_series/data/models/season_model.dart';
import 'package:tv_series/data/models/tv_detail_model.dart';
import 'package:tv_series/data/models/tv_model.dart';
import 'package:tv_series/domain/entities/tv_entity.dart';
import 'package:tv_series/tv_series.dart';

import '../../dummy_data/tv/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late TvRepositoryImpl repository;
  late MockTvRemoteDataSource mockRemoteDataSource;
  late MockTvLocalDataSource mockLocalDataSource;

  setUp(() {
    mockRemoteDataSource = MockTvRemoteDataSource();
    mockLocalDataSource = MockTvLocalDataSource();

    repository = TvRepositoryImpl(
      tvLocalDataSource: mockLocalDataSource,
      tvRemoteDataSource: mockRemoteDataSource,
    );
  });

  final tTvModel = TvModel(
    adult: false,
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: [14, 28],
    id: 557,
    originalName: 'Spider-Man',
    overview:
    'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    firstAirDate: '2002-05-01',
    name: 'Spider-Man',
    voteAverage: 7.2,
    voteCount: 13507,
  );

  final tTv = TvEntity(
    adult: false,
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: [14, 28],
    id: 557,
    originalName: 'Spider-Man',
    overview:
    'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    firstAirDate: '2002-05-01',
    name: 'Spider-Man',
    voteAverage: 7.2,
    voteCount: 13507,
  );

  final tTvModelList = <TvModel>[tTvModel];
  final tTvList = <TvEntity>[tTv];

  group('Airing Today Tvs', () {
    test(
        'should return remote data when the call to remote data source is successful',
            () async {
          // arrange
          when(mockRemoteDataSource.getAiringToday())
              .thenAnswer((_) async => tTvModelList);
          // act
          final result = await repository.getAiringTodayTv();
          // assert
          verify(mockRemoteDataSource.getAiringToday());
          /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
          final resultList = result.getOrElse(() => []);
          expect(resultList, tTvList);
        });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
            () async {
          // arrange
          when(mockRemoteDataSource.getAiringToday())
              .thenThrow(ServerException());
          // act
          final result = await repository.getAiringTodayTv();
          // assert
          verify(mockRemoteDataSource.getAiringToday());
          expect(result, equals(Left(ServerFailure(''))));
        });

    test(
        'should return connection failure when the device is not connected to internet',
            () async {
          // arrange
          when(mockRemoteDataSource.getAiringToday())
              .thenThrow(SocketException('Failed to connect to the network'));
          // act
          final result = await repository.getAiringTodayTv();
          // assert
          verify(mockRemoteDataSource.getAiringToday());
          expect(result,
              equals(Left(ConnectionFailure('Failed to connect to the network'))));
        });
  });

  group('Popular Tvs', () {
    test('should return Tv list when call to data source is success',
            () async {
          // arrange
          when(mockRemoteDataSource.getPopularTvs())
              .thenAnswer((_) async => tTvModelList);
          // act
          final result = await repository.getPopularTv();
          // assert
          /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
          final resultList = result.getOrElse(() => []);
          expect(resultList, tTvList);
        });

    test(
        'should return server failure when call to data source is unsuccessful',
            () async {
          // arrange
          when(mockRemoteDataSource.getPopularTvs())
              .thenThrow(ServerException());
          // act
          final result = await repository.getPopularTv();
          // assert
          expect(result, Left(ServerFailure('')));
        });

    test(
        'should return connection failure when device is not connected to the internet',
            () async {
          // arrange
          when(mockRemoteDataSource.getPopularTvs())
              .thenThrow(SocketException('Failed to connect to the network'));
          // act
          final result = await repository.getPopularTv();
          // assert
          expect(
              result, Left(ConnectionFailure('Failed to connect to the network')));
        });
  });

  group('Top Rated Tvs', () {
    test('should return Tv list when call to data source is successful',
            () async {
          // arrange
          when(mockRemoteDataSource.getTopRatedTvs())
              .thenAnswer((_) async => tTvModelList);
          // act
          final result = await repository.getTopRatedTv();
          // assert
          /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
          final resultList = result.getOrElse(() => []);
          expect(resultList, tTvList);
        });

    test('should return ServerFailure when call to data source is unsuccessful',
            () async {
          // arrange
          when(mockRemoteDataSource.getTopRatedTvs())
              .thenThrow(ServerException());
          // act
          final result = await repository.getTopRatedTv();
          // assert
          expect(result, Left(ServerFailure('')));
        });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
            () async {
          // arrange
          when(mockRemoteDataSource.getTopRatedTvs())
              .thenThrow(SocketException('Failed to connect to the network'));
          // act
          final result = await repository.getTopRatedTv();
          // assert
          expect(
              result, Left(ConnectionFailure('Failed to connect to the network')));
        });
  });

  group('Get Tv Detail', () {
    final tId = 1;
    final tTvResponse = TvDetailResponse(
      adult: false,
      backdropPath: 'backdropPath',
      genres: [GenreModel(id: 1, name: 'Action')],
      homepage: "https://google.com",
      id: 1,
      originalLanguage: 'en',
      originalName: 'originalName',
      overview: 'overview',
      popularity: 1,
      posterPath: 'posterPath',
      firstAirDate: 'firstAirDate',
      status: 'Status',
      tagline: 'Tagline',
      name: 'name',
      voteAverage: 1,
      voteCount: 1,
      episodeRunTime: [30],
      inProduction: false,
      languages: ["en"],
      lastAirDate: "2020-05-05",
      numberOfEpisodes: 20,
      numberOfSeasons: 5,
      type: "standart",
      seasons: [
        SeasonModel(
            airDate: "2014-02-17",
            episodeCount: 191,
            id: 1,
            name: "Season 1",
            overview: "overview",
            posterPath: "/jZ4lEt1vT260afMQIwVQcVFsAys.jpg",
            seasonNumber: 1,
            voteAverage: 6.4
        )
      ]
    );

    test(
        'should return Tv data when the call to remote data source is successful',
            () async {
          // arrange
          when(mockRemoteDataSource.getTvDetail(tId))
              .thenAnswer((_) async => tTvResponse);
          // act
          final result = await repository.getTvDetail(tId);
          // assert
          verify(mockRemoteDataSource.getTvDetail(tId));
          expect(result, equals(Right(testTvDetail)));
        });

    test(
        'should return Server Failure when the call to remote data source is unsuccessful',
            () async {
          // arrange
          when(mockRemoteDataSource.getTvDetail(tId))
              .thenThrow(ServerException());
          // act
          final result = await repository.getTvDetail(tId);
          // assert
          verify(mockRemoteDataSource.getTvDetail(tId));
          expect(result, equals(Left(ServerFailure(''))));
        });

    test(
        'should return connection failure when the device is not connected to internet',
            () async {
          // arrange
          when(mockRemoteDataSource.getTvDetail(tId))
              .thenThrow(SocketException('Failed to connect to the network'));
          // act
          final result = await repository.getTvDetail(tId);
          // assert
          verify(mockRemoteDataSource.getTvDetail(tId));
          expect(result,
              equals(Left(ConnectionFailure('Failed to connect to the network'))));
        });
  });

  group('Get Tv Recommendations', () {
    final tTvList = <TvModel>[];
    final tId = 1;

    test('should return data (Tv list) when the call is successful',
            () async {
          // arrange
          when(mockRemoteDataSource.getTvRecommendations(tId))
              .thenAnswer((_) async => tTvList);
          // act
          final result = await repository.getTvRecommendations(tId);
          // assert
          verify(mockRemoteDataSource.getTvRecommendations(tId));
          /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
          final resultList = result.getOrElse(() => []);
          expect(resultList, equals(tTvList));
        });

    test(
        'should return server failure when call to remote data source is unsuccessful',
            () async {
          // arrange
          when(mockRemoteDataSource.getTvRecommendations(tId))
              .thenThrow(ServerException());
          // act
          final result = await repository.getTvRecommendations(tId);
          // assertbuild runner
          verify(mockRemoteDataSource.getTvRecommendations(tId));
          expect(result, equals(Left(ServerFailure(''))));
        });

    test(
        'should return connection failure when the device is not connected to the internet',
            () async {
          // arrange
          when(mockRemoteDataSource.getTvRecommendations(tId))
              .thenThrow(SocketException('Failed to connect to the network'));
          // act
          final result = await repository.getTvRecommendations(tId);
          // assert
          verify(mockRemoteDataSource.getTvRecommendations(tId));
          expect(result,
              equals(Left(ConnectionFailure('Failed to connect to the network'))));
        });
  });

  group('Seach Tvs', () {
    final tQuery = 'spiderman';

    test('should return Tv list when call to data source is successful',
            () async {
          // arrange
          when(mockRemoteDataSource.searchTvs(tQuery))
              .thenAnswer((_) async => tTvModelList);
          // act
          final result = await repository.searchTv(tQuery);
          // assert
          /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
          final resultList = result.getOrElse(() => []);
          expect(resultList, tTvList);
        });

    test('should return ServerFailure when call to data source is unsuccessful',
            () async {
          // arrange
          when(mockRemoteDataSource.searchTvs(tQuery))
              .thenThrow(ServerException());
          // act
          final result = await repository.searchTv(tQuery);
          // assert
          expect(result, Left(ServerFailure('')));
        });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
            () async {
          // arrange
          when(mockRemoteDataSource.searchTvs(tQuery))
              .thenThrow(SocketException('Failed to connect to the network'));
          // act
          final result = await repository.searchTv(tQuery);
          // assert
          expect(
              result, Left(ConnectionFailure('Failed to connect to the network')));
        });
  });

  group('save watchlist', () {
    test('should return success message when saving successful', () async {
      // arrange
      when(mockLocalDataSource.insertWatchlistTv(testTvTable))
          .thenAnswer((_) async => 'Added to Watchlist');
      // act
      final result = await repository.saveTVWatchlist(testTvDetail);
      // assert
      expect(result, Right('Added to Watchlist'));
    });

    test('should return DatabaseFailure when saving unsuccessful', () async {
      // arrange
      when(mockLocalDataSource.insertWatchlistTv(testTvTable))
          .thenThrow(DatabaseException('Failed to add watchlist'));
      // act
      final result = await repository.saveTVWatchlist(testTvDetail);
      // assert
      expect(result, Left(DatabaseFailure('Failed to add watchlist')));
    });
  });

  group('remove watchlist', () {
    test('should return success message when remove successful', () async {
      // arrange
      when(mockLocalDataSource.removeWatchlistTv(testTvTable))
          .thenAnswer((_) async => 'Removed from watchlist');
      // act
      final result = await repository.removeTVWatchlist(testTvDetail);
      // assert
      expect(result, Right('Removed from watchlist'));
    });

    test('should return DatabaseFailure when remove unsuccessful', () async {
      // arrange
      when(mockLocalDataSource.removeWatchlistTv(testTvTable))
          .thenThrow(DatabaseException('Failed to remove watchlist'));
      // act
      final result = await repository.removeTVWatchlist(testTvDetail);
      // assert
      expect(result, Left(DatabaseFailure('Failed to remove watchlist')));
    });
  });

  group('get watchlist status', () {
    test('should return watch status whether data is found', () async {
      // arrange
      final tId = 1;
      when(mockLocalDataSource.getTvById(tId)).thenAnswer((_) async => null);
      // act
      final result = await repository.isAddedTVToWatchlist(tId);
      // assert
      expect(result, false);
    });
  });

  group('get watchlist Tvs', () {
    test('should return list of Tvs', () async {
      // arrange
      when(mockLocalDataSource.getWatchlistTvs())
          .thenAnswer((_) async => [testTvTable]);
      // act
      final result = await repository.getWatchlistTvs();
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, [testWatchlistTv]);
    });
  });
}
