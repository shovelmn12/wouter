part of 'model.dart';

mixin StackEntryBuilder implements Function {
  WouterRouteBuilder get builder;

  Map<String, dynamic> get arguments;

  Widget call(BuildContext context) => builder(context, arguments);
}
