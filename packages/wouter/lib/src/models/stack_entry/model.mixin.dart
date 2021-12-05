part of 'model.dart';

mixin StackEntryBuilder<T> implements Function {
  WouterRouteBuilder<T> get builder;

  Map<String, dynamic> get arguments;

  T call(BuildContext context) => builder(context, arguments);
}
