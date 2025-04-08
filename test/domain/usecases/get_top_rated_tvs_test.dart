import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv_entity.dart';
import 'package:ditonton/domain/usecases/get_top_rated_Tvs.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTopRatedTvs useCase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    useCase = GetTopRatedTvs(mockTvRepository);
  });

  final tTvs = <TvEntity>[];

  test('should get list of tv series from repository', () async {
    // arrange
    when(mockTvRepository.getTopRatedTv())
        .thenAnswer((_) async => Right(tTvs));
    // act
    final result = await useCase.execute();
    // assert
    expect(result, Right(tTvs));
  });
}
