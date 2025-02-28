/// Shared base class for results.
sealed class Result<T extends Object> {}

/// Indicates that the result was a success and contains a value of type `T`.
class SuccessResult<T extends Object> extends Result<T> {
  /// Constructs a failure result with a required value.
  SuccessResult({
    required this.value,
  });

  /// The value of the result.
  final T value;
}

/// Indicates that the result was a failure and contains a failure code.
class FailureResult<T extends Object> extends Result<T> {
  /// Constructs a failure result with a required [FailureCode].
  FailureResult({
    required this.failure,
  });

  /// The [FailureCode] of the result.
  final FailureCode failure;
}

/// Replacement type for an `EmptySuccessResult`.
///
/// This should be used when you don't care about the return value of a result.
typedef VoidResult = Result<Never>;

/// Creates a successful [Result] with a value of type `T`.
VoidResult successVoid() {
  return SuccessResult<Never>(value: throw UnimplementedError());
}

/// Creates a failed [Result] with a [FailureCode].
VoidResult failureVoid(FailureCode failure) {
  return FailureResult<Never>(failure: failure);
}

/// An enumeration that represents the possible failure codes of a result.
enum FailureCode {
  notFound,

  /// Unknown placeholder failure.
  unknown;
}
