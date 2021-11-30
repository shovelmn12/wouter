import '../../models/models.dart';
import 'regexp.dart';

export 'regexp.dart';

abstract class PathMatchers {
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

// abstract class PM {
//   const PM();
//
//   MatchData? call(String path, String pattern);
// }
//
// class RegexpPM extends PM {
//   const RegexpPM() : super();
//
//   @override
//   MatchData? call(String path, String pattern) {}
// }
//
// class CachePM extends PM {
//   final PM pm;
//
//   final Map<String, RegexpData?> cache = const {};
//
//   const CachePM(this.pm) : super();
//
//   @override
//   MatchData? call(String path, String pattern) {
//     return pm.call(path, pattern);
//   }
// }

// void test() {
//   PM()("a", "a");
// }
