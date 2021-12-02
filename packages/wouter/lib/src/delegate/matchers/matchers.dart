import '../../models/models.dart';
import 'regexp.dart';

export 'regexp.dart';

abstract class PathMatchers {
  const PathMatchers._();

  static PathMatcher regexp() {
    final regexpBuilder = pathToRegexpCache(pathToRegexp);

    return (
      String path,
      String pattern, {
      bool prefix = true,
    }) =>
        regexpPathMatcher(
          path,
          pattern,
          regexpBuilder: regexpBuilder,
          prefix: prefix,
        );
  }
}
