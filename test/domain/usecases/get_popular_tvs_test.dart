import 'package:dartz/dartz.dart';
import 'package:tv_series/domain/entities/tv_entity.dart';
import 'package:tv_series/tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetPopularTvs useCase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    useCase = GetPopularTvs(mockTvRepository);
  });

  final tTvs = <TvEntity>[];

  group('GetPopularTvs Tests', () {
    group('execute', () {
      test(
          'should get list of tv series from the repository when execute function is called',
              () async {
            // arrange
            when(mockTvRepository.getPopularTv())
                .thenAnswer((_) async => Right(tTvs));
            // act
            final result = await useCase.execute();
            // assert
            expect(result, Right(tTvs));
          });
    });
  });
}
