import 'dart:async';

import 'package:wouter/wouter.dart';

typedef PushAction = (WouterState, Future<R?>) Function<R>(WouterState, String);

typedef PopAction = (WouterState, bool) Function(WouterState, [dynamic]);

typedef ActionBuilder = ({
  PushAction push,
  PopAction pop,
  PathBuilder pathBuilder,
});

typedef WouterAction = R Function<R>(
  (WouterState, R) Function(ActionBuilder, WouterState),
);

typedef WouterActionsCallbacks = ({
  List<bool Function(String)> push,
  List<bool Function(String, [dynamic])> pop,
});
