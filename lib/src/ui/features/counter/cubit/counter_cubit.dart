import 'package:flutter_bloc/flutter_bloc.dart';

/// The [CounterCubit] is responsible for managing counter the state and
/// notifying widgets of state changes.
class CounterCubit extends Cubit<int> {
  /// Creates a new instance of [CounterCubit].
  CounterCubit() : super(0);

  /// Increments the counter by 1.
  void increment() => emit(state + 1);
}
