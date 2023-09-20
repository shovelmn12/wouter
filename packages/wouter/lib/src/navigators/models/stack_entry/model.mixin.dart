part of 'model.dart';

mixin StackEntryBuilder<T> {
  WouterRouteBuilder<T> get builder;

  Map<String, dynamic> get arguments;

  T call(BuildContext context) => builder(context, arguments);
}
