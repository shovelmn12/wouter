import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'model.freezed.dart';

/// A data class that holds a compiled regular expression ([RegExp]) and
/// a list of parameter names extracted from the original route pattern.
///
/// This structure is typically created by a [RegexpBuilder] (like `pathToRegexp`)
/// when a route pattern string is processed. It encapsulates the necessary
/// information for a [PathMatcher] to perform matching and extract arguments.
///
/// It uses the `freezed` package for generating immutable data class boilerplate.
@freezed
sealed class RegexpData with _$RegexpData {
  /// Creates an instance of [RegexpData].
  ///
  /// - [regexp]: The compiled [RegExp] object derived from a route pattern.
  ///   This is used to perform the actual matching against a path string.
  /// - [parameters]: A list of string names for the parameters found in the
  ///   route pattern (e.g., for a pattern like `/users/:id/posts/:postId`,
  ///   this list would be `['id', 'postId']`). This list is used in conjunction
  ///   with the match groups from the [regexp] to extract argument values.
  ///   Defaults to an empty list if no parameters are present in the pattern.
  const factory RegexpData({
    required RegExp regexp,
    @Default([]) List<String> parameters,
  }) = _RegexpData; // Refers to the concrete class generated by Freezed
}
