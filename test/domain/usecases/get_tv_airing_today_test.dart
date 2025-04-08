import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv_entity.dart';
import 'package:ditonton/domain/usecases/get_tv_airing_today.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvAiringToday useCase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    useCase = GetTvAiringToday(mockTvRepository);
  });

  final tTvs = <TvEntity>[];

  test('should get list of tv series from the repository', () async {
    // arrange
    when(mockTvRepository.getAiringTodayTv())
        .thenAnswer((_) async => Right(tTvs));
    // act
    final result = await useCase.execute();
    // assert
    expect(result, Right(tTvs));
  });
}
