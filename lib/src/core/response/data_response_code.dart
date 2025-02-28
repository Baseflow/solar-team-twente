/// Enumerates all response codes used within
/// the core layer.
enum DataResponseCode {
  /// Indicates the data request executed successfully and the
  /// `DataResponse.value` can be accessed safely.
  success(200),

  /// Indicates the data layer performed an unauthorized call.
  unAuthorized(401),

  /// Indicates a forbidden path that is not allowed by the user.
  forbidden(403),

  /// Indicates general Error 404 - the object has not been found.
  notFound(404),

  /// Indicates that the data being inserted already exists.
  alreadyExists(409),

  /// Indicates that the call was recognized but couldn't be processed
  /// due to incomplete/invalid parameter input.
  invalidParameter(422),

  /// Unknown error.
  unknown(500);

  const DataResponseCode(this.statusCode);

  /// Http status code.
  final int statusCode;
}
