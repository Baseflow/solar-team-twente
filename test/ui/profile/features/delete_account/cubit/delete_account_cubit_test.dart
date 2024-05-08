import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:solar_team_twente/core.dart';
import 'package:solar_team_twente/src/ui/features/profile/feature/delete_account/cubit/delete_account_cubit.dart';

class MockProfileService extends Mock implements ProfileService {}

const String mockPassword = 'password';

void main() {
  group('DeleteAccountCubit', () {
    late MockProfileService mockProfileService;

    setUp(() {
      mockProfileService = MockProfileService();
    });

    blocTest<DeleteAccountCubit, DeleteAccountState>(
      'Load and successfully delete account',
      build: () {
        when(
          () => mockProfileService.deleteAccount(password: mockPassword),
        ).thenAnswer(
          (_) => Future<void>.value(),
        );
        return DeleteAccountCubit(mockProfileService);
      },
      act: (DeleteAccountCubit cubit) {
        cubit
          ..updatePassword(mockPassword)
          ..deleteAccount();
      },
      expect: () => <DeleteAccountState>[
        const DeleteAccountInitial(password: mockPassword),
        const DeleteAccountLoadingState(password: mockPassword),
        const DeleteAccountSuccessState(password: mockPassword),
      ],
    );

    blocTest<DeleteAccountCubit, DeleteAccountState>(
      'Load and delete account with invalid password',
      build: () {
        final DeleteAccountCubit cubit = DeleteAccountCubit(mockProfileService);
        when(
          () => mockProfileService.deleteAccount(password: mockPassword),
        ).thenAnswer((_) {
          throw const DeleteAccountException(
            errorCode: DeleteAccountExceptionCode.invalidPassword,
          );
        });
        return cubit;
      },
      act: (DeleteAccountCubit cubit) {
        cubit
          ..updatePassword(mockPassword)
          ..deleteAccount();
      },
      expect: () => <DeleteAccountState>[
        const DeleteAccountInitial(password: mockPassword),
        const DeleteAccountLoadingState(password: mockPassword),
        const DeleteAccountErrorState(
          password: mockPassword,
          errorCode: DeleteAccountExceptionCode.invalidPassword,
        ),
      ],
    );

    blocTest<DeleteAccountCubit, DeleteAccountState>(
      'Load and delete account with unknown error',
      build: () {
        final DeleteAccountCubit cubit = DeleteAccountCubit(mockProfileService);
        when(
          () => mockProfileService.deleteAccount(password: mockPassword),
        ).thenAnswer((_) {
          throw const DeleteAccountException(
            errorCode: DeleteAccountExceptionCode.unknown,
          );
        });
        return cubit;
      },
      act: (DeleteAccountCubit cubit) {
        cubit
          ..updatePassword(mockPassword)
          ..deleteAccount();
      },
      expect: () => <DeleteAccountState>[
        const DeleteAccountInitial(password: mockPassword),
        const DeleteAccountLoadingState(password: mockPassword),
        const DeleteAccountErrorState(
          password: mockPassword,
          errorCode: DeleteAccountExceptionCode.unknown,
        ),
      ],
    );
  });
}
