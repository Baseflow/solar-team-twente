import 'package:mocktail/mocktail.dart';
import 'package:solar_team_twente/core.dart';
import 'package:test/test.dart';

class MockProfileRepository extends Mock implements ProfileRepository {}

void main() {
  final ProfileRepository mockProfileRepository = MockProfileRepository();
  final ProfileService profileService = ProfileService(
    profileRepository: mockProfileRepository,
  );

  group('resetPassword', () {
    test(
      'should call repository with correct email',
      () async {
        const String email = 'test@email.com';
        when(() => mockProfileRepository.resetPassword(email))
            .thenAnswer((_) async => Future<void>.value());
        await profileService.resetPassword(email);
        verify(() => mockProfileRepository.resetPassword(email)).called(1);
      },
    );
  });

  group('deleteAccount', () {
    test(
      'should call repository with valid password',
      () async {
        const String password = 'password';
        when(() => mockProfileRepository.deleteAccount(password: password))
            .thenAnswer((_) async => Future<void>.value());
        await profileService.deleteAccount(password: password);
        verify(
          () => mockProfileRepository.deleteAccount(password: password),
        ).called(1);
      },
    );
  });
}
