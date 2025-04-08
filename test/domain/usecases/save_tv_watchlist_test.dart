import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/save_tv_watchlist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/tv/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late SaveTvWatchlist useCase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    useCase = SaveTvWatchlist(mockTvRepository);
  });

  test('should save Tv to the repository', () async {
    // arrange
    when(mockTvRepository.saveTVWatchlist(testTvDetail))
        .thenAnswer((_) async => Right('Added TV to Watchlist'));
    // act
    final result = await useCase.execute(testTvDetail);
    // assert
    verify(mockTvRepository.saveTVWatchlist(testTvDetail));
    expect(result, Right('Added TV to Watchlist'));
  });
}
