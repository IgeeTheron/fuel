/// A utility class with helper methods for JSON validation.
///
/// Provides static methods to perform runtime checks on JSON objects, primarily
/// for ensuring data integrity during development and debugging.
class JsonUtils {
  /// Asserts that a JSON map contains a set of expected keys with correct data types.
  ///
  /// This is a debug-only utility that helps catch API contract violations early
  /// by verifying the structure of a decoded JSON object. It checks for the
  /// presence of required keys and validates their corresponding value types against
  /// a predefined list.
  ///
  /// The [json] parameter is the decoded JSON map to be validated.
  ///
  /// The [expectedTypes] parameter defines the validation contract. Each entry's
  /// key is a `String` representing a required key in the JSON. The value is a
  /// list of acceptable `Type`s. To allow a key to be `null`, include `null`
  /// in its list of types.
  ///
  /// Throws an [AssertionError] with a descriptive, localized message if a
  /// validation check fails. This method has no effect in release builds.
  ///
  /// {@tool snippet}
  /// This example demonstrates how to validate a user JSON object.
  ///
  /// ```dart
  /// final userJson = {
  ///   "id": 123,
  ///   "name": "Jane Doe",
  ///   "email_verified_at": null,
  ///   "posts": [
  ///     {"id": 1, "title": "First Post"},
  ///     {"id": 2, "title": "Second Post"},
  ///   ]
  /// };
  ///
  /// final expectedUserStructure = <String, List<Type?>?>{
  ///   "id": [int],
  ///   "name": [String],
  ///   "email_verified_at": [String, null], // Allows the value to be null
  ///   "posts": [List],
  /// };
  ///
  /// // This will pass validation.
  /// JsonUtils.assertJsonKeys(
  ///   json: userJson,
  ///   expectedTypes: expectedUserStructure,
  /// );
  ///
  /// final invalidJson = {"id": "123"}; // 'id' is a String, not an int.
  ///
  /// // This will throw an AssertionError in debug mode.
  /// // JsonUtils.assertJsonKeys(
  /// //   json: invalidJson,
  /// //   expectedTypes: expectedUserStructure,
  /// // );
  /// ```
  /// {@end-tool}
  static void assertJsonKeys({
    required Map<String, dynamic> json,
    required Map<String, List<Type?>?> expectedTypes,
  }) {
    for (String key in expectedTypes.keys) {
      assert(
        json.containsKey(key),
        "JSON must contain a key named $key.",
      );

      final List<Type?>? expectedTypeList = expectedTypes[key];
      if (expectedTypeList == null || expectedTypeList.isEmpty) continue;

      final dynamic value = json[key];

      bool isTypeOf(val, Type? type) {
        if (type == null) return val == null;
        if (type == Map) return val is Map;
        if (type == List) return val is List;

        return val.runtimeType == type;
      }

      if (expectedTypeList.contains(null)) {
        assert(
          expectedTypeList.any((type) => isTypeOf(value, type)),
          "The value for $key must be one of the following types: ${expectedTypeList.join(', ')}\nActual type: ${value.runtimeType}",
        );
      } else {
        assert(
          value != null,
          "The value for $key cannot be null.",
        );
        assert(
          expectedTypeList.any((type) => isTypeOf(value, type)),
          "The value for $key must be one of the following types: ${expectedTypeList.join(', ')}\nActual type: ${value.runtimeType}",
        );
      }
    }
  }
}
