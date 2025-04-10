import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/entities/tv_entity.dart';
import 'package:tv_series/tv_series.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvRecommendation useCase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    useCase = GetTvRecommendation(mockTvRepository);
  });

  final tId = 1;
  final tTvs = <TvEntity>[];

  test('should get list of Tv recommendations from the repository',
          () async {
        // arrange
        when(mockTvRepository.getTvRecommendations(tId))
            .thenAnswer((_) async => Right(tTvs));
        // act
        final result = await useCase.execute(tId);
        // assert
        expect(result, Right(tTvs));
      });
}
