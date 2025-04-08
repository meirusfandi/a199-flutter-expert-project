import 'package:ditonton/domain/usecases/get_tv_watchlist_status.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTVWatchlistStatus useCase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    useCase = GetTVWatchlistStatus(mockTvRepository);
  });

  test('should get watchlist status tv from repository', () async {
    // arrange
    when(mockTvRepository.isAddedTVToWatchlist(1))
        .thenAnswer((_) async => true);
    // act
    final result = await useCase.execute(1);
    // assert
    expect(result, true);
  });
}
