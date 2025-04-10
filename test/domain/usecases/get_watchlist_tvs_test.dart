import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/usecases/get_watchlist_tvs.dart';

import '../../dummy_data/tv/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetWatchlistTvs useCase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    useCase = GetWatchlistTvs(mockTvRepository);
  });

  test('should get list of tv series from the repository', () async {
    // arrange
    when(mockTvRepository.getWatchlistTvs())
        .thenAnswer((_) async => Right(testTvList));
    // act
    final result = await useCase.execute();
    // assert
    expect(result, Right(testTvList));
  });
}
