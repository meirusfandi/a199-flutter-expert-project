
import 'package:tv_series/domain/entities/genre.dart';
import 'package:tv_series/domain/entities/season.dart';
import 'package:tv_series/domain/entities/tv_detail.dart';
import 'package:tv_series/domain/entities/tv_entity.dart';
import 'package:tv_series/tv_series.dart';

final testTv = TvEntity(
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

final testTvList = [testTv];

final testTvDetail = TvDetail(
  adult: false,
  backdropPath: 'backdropPath',
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  originalName: 'originalName',
  overview: 'overview',
  posterPath: 'posterPath',
  firstAirDate: 'firstAirDate',
  runtime: 120,
  name: 'name',
  voteAverage: 1,
  voteCount: 1,
  seasons: [
    Season(
        airDate: "2014-02-17",
        episodeCount: 191,
        id: 1,
        name: "Season 1",
        overview: "overview",
        posterPath: "/jZ4lEt1vT260afMQIwVQcVFsAys.jpg",
        seasonNumber: 1,
        voteAverage: 6.4
    )
  ],
);

final testWatchlistTv = TvEntity.watchlist(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testTvTable = TvTable(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testTvToMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'name': 'name',
};
