import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:solar_team_twente/core.dart';
import 'package:solar_team_twente/src/ui/features/profile/cubit/change_password_cubit.dart';

class MockAuthenticationService extends Mock implements AuthenticationService {}

void main() {
  group('ChangePasswordCubit', () {
    late MockAuthenticationService mockAuthenticationService;

    setUp(() {
      mockAuthenticationService = MockAuthenticationService();
    });

    const String password = 'password';
    const String differentPassword = 'differentPassword';

    group('updates', () {
      blocTest<ChangePasswordCubit, ChangePasswordState>(
        'the new password',
        build: () => ChangePasswordCubit(
          mockAuthenticationService,
          const ChangePasswordState(),
        ),
        act: (ChangePasswordCubit cubit) => cubit.updateNewPassword(password),
        expect: () => <ChangePasswordState>[
          const ChangePasswordState(newPassword: password),
        ],
      );

      blocTest<ChangePasswordCubit, ChangePasswordState>(
        'the confirm new password',
        build: () => ChangePasswordCubit(
          mockAuthenticationService,
          const ChangePasswordState(),
        ),
        act: (ChangePasswordCubit cubit) =>
            cubit.updateConfirmNewPassword(password),
        expect: () => <ChangePasswordState>[
          const ChangePasswordState(confirmNewPassword: password),
        ],
      );
    });

    group('emits', () {
      blocTest<ChangePasswordCubit, ChangePasswordState>(
        'correct state after successful password change',
        build: () => ChangePasswordCubit(
          mockAuthenticationService,
          const ChangePasswordState(
            newPassword: password,
            confirmNewPassword: password,
          ),
        ),
        act: (ChangePasswordCubit cubit) async {
          when(
            () =>
                mockAuthenticationService.updatePassword(newPassword: password),
          ).thenAnswer((_) async {});
          await cubit.changePassword();
        },
        expect: () => <ChangePasswordState>[
          const ChangePasswordState(
            isLoading: true,
            newPassword: password,
            confirmNewPassword: password,
          ),
          const ChangePasswordState(
            changePasswordSuccessful: true,
            newPassword: password,
            confirmNewPassword: password,
          ),
        ],
      );

      blocTest<ChangePasswordCubit, ChangePasswordState>(
        'not successful state after unsuccessful password change',
        build: () => ChangePasswordCubit(
          mockAuthenticationService,
          const ChangePasswordState(
            newPassword: password,
            confirmNewPassword: differentPassword,
          ),
        ),
        act: (ChangePasswordCubit cubit) async {
          when(
            () =>
                mockAuthenticationService.updatePassword(newPassword: password),
          ).thenAnswer((_) async {});
          await cubit.changePassword();
        },
        expect: () => <ChangePasswordState>[
          const ChangePasswordState(
            newPassword: password,
            confirmNewPassword: differentPassword,
          ),
        ],
      );
    });

    group('newPasswordsMatch', () {
      test('is true when new passwords match', () {
        const ChangePasswordState state = ChangePasswordState(
          newPassword: password,
          confirmNewPassword: password,
        );
        expect(state.validNewPassword, true);
      });
      test("is false when new passwords don't match", () {
        const ChangePasswordState state = ChangePasswordState(
          newPassword: password,
          confirmNewPassword: differentPassword,
        );
        expect(state.validNewPassword, false);
      });
    });

    group('oldAndNewPasswordMatch', () {
      test('is true when current and new passwords match', () {
        const ChangePasswordState state = ChangePasswordState(
          currentPassword: password,
          newPassword: password,
        );
        expect(state.currentAndNewPasswordMatch, true);
      });
      test('is false when current and new passwords do not match', () {
        const ChangePasswordState state = ChangePasswordState(
          currentPassword: differentPassword,
          newPassword: password,
        );
        expect(state.currentAndNewPasswordMatch, false);
      });
    });

    group('validNewPassword', () {
      test(
          'is true when new passwords match and current password '
          'differs from them', () {
        const ChangePasswordState state = ChangePasswordState(
          currentPassword: differentPassword,
          newPassword: password,
          confirmNewPassword: password,
        );
        expect(state.validNewPassword, true);
      });
      test('is false when new passwords and current password match', () {
        const ChangePasswordState state = ChangePasswordState(
          currentPassword: password,
          newPassword: password,
          confirmNewPassword: password,
        );
        expect(state.validNewPassword, false);
      });
      test(
          'is false when new passwords do not match and '
          'current password differs from them', () {
        const ChangePasswordState state = ChangePasswordState(
          currentPassword: 'differentCurrentPassword',
          newPassword: password,
          confirmNewPassword: differentPassword,
        );
        expect(state.validNewPassword, false);
      });
      test(
          'is false when new passwords do not match and '
          'current password matches new password', () {
        const ChangePasswordState state = ChangePasswordState(
          currentPassword: password,
          newPassword: password,
          confirmNewPassword: differentPassword,
        );
        expect(state.validNewPassword, false);
      });
    });
  });
}
