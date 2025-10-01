/// Provides a conditional `takeIf` method on any object.
///
/// This extension allows for writing more fluent, expression-based conditional
/// logic, similar to functionality found in other languages like Kotlin.
///
/// @typeparam T The type of the object this extension is applied to.
extension TakeIfExtension<T> on T {
  /// Returns this object if it satisfies the given [predicate], or `null` otherwise.
  ///
  /// This method is useful for chaining calls or for assigning a value to a
  /// variable in a more concise way than using a traditional `if` statement.
  ///
  /// ### Example:
  ///
  /// ```dart
  /// // Instead of this:
  /// String? name;
  /// if (potentialName.isNotEmpty) {
  ///   name = potentialName;
  /// }
  ///
  /// // You can write this:
  /// final name = potentialName.takeIf((it) => it.isNotEmpty);
  ///
  /// // It is also useful in nullable chains:
  /// final positiveNumber = someNullableInt?.takeIf((it) => it > 0);
  /// ```
  ///
  /// @param predicate A function that evaluates this object.
  /// @return The object itself if the [predicate] returns `true`; otherwise, `null`.
  T? takeIf(bool Function(T) predicate) {
    return predicate(this) ? this : null;
  }
}
