part of 'base.dart';



class BaseWouterNavigatorBuilder<T> extends BaseWouterNavigator<T> {
  final WouterStackBuilder<T> builder;

  const BaseWouterNavigatorBuilder({
    Key? key,
    required Map<String, WouterRouteBuilder<T>> routes,
    required this.builder,
  }) : super(
          key: key,
          routes: routes,
        );

  @override
  BaseWouterNavigatorBuilderState<BaseWouterNavigatorBuilder<T>, T>
      createState() =>
          BaseWouterNavigatorBuilderState<BaseWouterNavigatorBuilder<T>, T>();
}

class BaseWouterNavigatorBuilderState<T extends BaseWouterNavigatorBuilder<W>,
    W> extends BaseWouterNavigatorState<T, W> {
  @override
  Widget builder(BuildContext context, List<W> stack) =>
      widget.builder(context, parent, stack);
}
