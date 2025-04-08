import 'dart:convert';

import 'package:ditonton/data/models/tv_model.dart';
import 'package:ditonton/data/models/tv_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main() {
  final tTvModel = TvModel(
    adult: false,
    backdropPath: "/7VO04TtL1jIT6XOPs9u4jdB8KaB.jpg",
    genreIds: [35, 10767],
    id: 59941,
    originalName: "The Tonight Show Starring Jimmy Fallon",
    overview: "After Jay Leno's second retirement from the program, Jimmy Fallon stepped in as his permanent replacement. After 42 years in Los Angeles the program was brought back to New York.",
    popularity: 632.588,
    posterPath: "/g4amxJvtpnY79J77xeamnAEUO8r.jpg",
    firstAirDate: "2014-02-17",
    name: "The Tonight Show Starring Jimmy Fallon",
    voteAverage: 5.842,
    voteCount: 329,
  );
  final tTvResponseModel = TvResponse(tvList: <TvModel>[tTvModel]);
  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
      json.decode(readJson('dummy_data/tv/airing_today.json'));
      // act
      final result = TvResponse.fromJson(jsonMap);
      // assert
      expect(result, tTvResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tTvResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        "results": [
          {
            "adult": false,
            "backdrop_path": "/7VO04TtL1jIT6XOPs9u4jdB8KaB.jpg",
            "genre_ids": [
              35,
              10767
            ],
            "id": 59941,
            "original_name": "The Tonight Show Starring Jimmy Fallon",
            "overview": "After Jay Leno's second retirement from the program, Jimmy Fallon stepped in as his permanent replacement. After 42 years in Los Angeles the program was brought back to New York.",
            "popularity": 632.588,
            "poster_path": "/g4amxJvtpnY79J77xeamnAEUO8r.jpg",
            "first_air_date": "2014-02-17",
            "name": "The Tonight Show Starring Jimmy Fallon",
            "vote_average": 5.842,
            "vote_count": 329
          }
        ],
      };
      expect(result, expectedJsonMap);
    });
  });
}
