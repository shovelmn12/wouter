# wouter

Supercharge your routering with wouter, simple yet advanced and fully customizable routing package.

## BETA Release - Docs WIP

this package is using [path_to_regexp](https://pub.dev/packages/path_to_regexp) in order to match route pattern to a path

simple example:

```dart
class MyApp extends StatelessWidget {
  final delegate = WouterRouterDelegate(
    child: WouterSwitch(
      routes: {
        "/": (context, arguments) => MaterialPage(
              child: HomeScreen(),
            ),
        "/people": (context, arguments) => MaterialPage(
              child: PeopleScreen(),
            ),
      },
    ),
  );

  @override
  Widget build(BuildContext context) => MaterialApp.router(
        routerDelegate: delegate,
        routeInformationParser: WouterRouteInformationParser(),
        backButtonDispatcher: WouterBackButtonDispatcher(
          delegate: delegate,
        ),
      );
}
```
