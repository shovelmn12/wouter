import '../../models/models.dart';
import 'regexp.dart';

export 'regexp.dart';

abstract class PathMatchers implements Function {
  const PathMatchers._();

  static PathMatcher regexp() {
    final regexpBuilder = pathToRegexpCache(pathToRegexp);

    return (String path, String pattern) => regexpPathMatcher(
          path,
          pattern,
          regexpBuilder: regexpBuilder,
        );
  }
}
