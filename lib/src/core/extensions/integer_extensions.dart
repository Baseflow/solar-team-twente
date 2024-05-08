import '../entities/data/data_response_code.dart';

/// Extension on [int] to convert a http status code to a [DataResponseCode].
extension StatusCodeExtension on int? {
  /// Converts a status code to a [DataResponseCode] for dev readability.
  DataResponseCode toDataResponseCode() {
    return DataResponseCode.values.firstWhere(
      (DataResponseCode element) => element.statusCode == this,
      orElse: () => DataResponseCode.unknown,
    );
  }
}
