import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:solar_team_twente/core.dart';
import 'package:solar_team_twente/src/ui/features/authentication/cubit/forgot_password_cubit.dart';
import 'package:test/test.dart';

class MockAuthenticationService extends Mock implements AuthenticationService {}

void main() {
  late MockAuthenticationService mockAuthenticationService;

  setUp(() {
    mockAuthenticationService = MockAuthenticationService();
  });
  group('updateEmail', () {
    blocTest<ForgotPasswordCubit, ForgotPasswordState>(
      'should emit state with updated email',
      build: () => ForgotPasswordCubit(mockAuthenticationService),
      act: (ForgotPasswordCubit cubit) => cubit.updateEmail('email@test.com'),
      expect: () => <ForgotPasswordState>[
        const ForgotPasswordState(email: 'email@test.com'),
      ],
    );
  });

  group(
    'sendPasswordResetEmail',
    () => <void>{
      blocTest<ForgotPasswordCubit, ForgotPasswordState>(
        'should emit loading, then success state when email is not empty',
        setUp: () {
          when(() => mockAuthenticationService.resetPassword(any()))
              .thenAnswer((_) async {});
        },
        build: () => ForgotPasswordCubit(mockAuthenticationService),
        act: (ForgotPasswordCubit cubit) async {
          // Using separate actions with delays to ensure proper ordering
          cubit.updateEmail('test@example.com');
          await Future<void>.delayed(Duration.zero);
          await cubit.sendPasswordResetEmail();
        },
        expect: () => <ForgotPasswordState>[
          const ForgotPasswordState(email: 'test@example.com'),
          const ForgotPasswordState(email: 'test@example.com', isLoading: true),
          const ForgotPasswordState(
            email: 'test@example.com',
            emailSentSuccessfully: true,
          ),
        ],
      ),
      blocTest<ForgotPasswordCubit, ForgotPasswordState>(
        'should emit loading, then error state when service throws exception',
        setUp: () {
          when(() => mockAuthenticationService.resetPassword(any())).thenThrow(
            const AuthenticationException(
              errorCode: AuthenticationExceptionCode.userNotFound,
            ),
          );
        },
        build: () => ForgotPasswordCubit(mockAuthenticationService),
        act: (ForgotPasswordCubit cubit) async {
          cubit.updateEmail('test@example.com');
          await Future<void>.delayed(Duration.zero);
          await cubit.sendPasswordResetEmail();
        },
        expect: () => <ForgotPasswordState>[
          const ForgotPasswordState(
            email: 'test@example.com',
          ),
          const ForgotPasswordState(
            email: 'test@example.com',
            isLoading: true,
          ),
          const ForgotPasswordState(
            email: 'test@example.com',
            authErrorCode: AuthenticationExceptionCode.userNotFound,
          ),
        ],
      ),
    },
  );
}
