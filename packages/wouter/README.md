# wouter

<a href="https://pub.dev/packages/wouter"><img src="https://img.shields.io/pub/v/wouter.svg" alt="pub"></a>

A simple yet powerful and fully customizable Flutter routing package, inspired by the ease-of-use of [wouter (npm)](https://www.npmjs.com/package/wouter) and designed to make Navigator 2.0 feel intuitive and widget-centric.

- [Motivation](#motivation)
- [Key Features](#key-features)
- [Core Components](#core-components)
  - [WouterRouterDelegate](#wouterrouterdelegate)
  - [WouterRouteInformationParser](#wouterrouteinformationparser)
- [Routing Widgets](#routing-widgets)
  - [Wouter](#wouter-scoping-widget)
  - [WouterSwitch](#wouterswitch)
  - [WouterNavigator](#wouternavigator)
- [UI Integration Widgets](#ui-integration-widgets)
  - [WouterListenable](#wouterlistenable)
  - [WouterTab](#woutertab)
  - [WouterPage](#wouterpage)
- [Declarative Navigation Widgets](#declarative-navigation-widgets)
  - [Replace](#replace)
  - [ReplaceUntil](#replaceuntil)
  - [Reset](#reset)
- [Performing Navigation](#performing-navigation)
  - [Accessing Actions](#accessing-actions)
  - [Available Actions](#available-actions)
- [Concepts](#concepts)
  - [Widget-Centric Routing](#widget-centric-routing)
  - [Scoped State with WouterStateStreamable](#scoped-state-with-wouterstatestreamable)
  - [Path Matching](#path-matching)
  - [Action Interceptors](#action-interceptors)
- [Getting Started Example](#getting-started-example)
- [Advanced Usage Examples](#advanced-usage-examples)
  - [Nested Routing](#nested-routing)
  - [Conditional Routes & Guards](#conditional-routes--guards)
  - [Custom Stack UI with WouterNavigator](#custom-stack-ui-with-wouternavigator)

## Motivation

Flutter's Navigator 2.0, while powerful, can often feel complex and introduce significant boilerplate compared to the simpler paradigms found in web frameworks or even Flutter's original Navigator 1.0. If you've ever found yourself wrestling with extensive route configurations or struggling to integrate routing naturally within your widget tree, Wouter is for you.

Wouter aims to:

1.  **Simplify Navigator 2.0:** Bring back the ease of Navigator 1.0's widget-based approach to the declarative Navigator 2.0 system. We believe routing should feel like just another widget in your tree.
2.  **Reduce Boilerplate:** Many routing solutions require defining elaborate route classes or deeply nested configuration objects. Wouter lets you define routes with a simple `Map<String, WidgetBuilderFunction>`.
    ```dart
    // Other packages might require:
    // ARouter(
    //   routes: [
    //     ARoute(path: "/here", builder: ...),
    //     ARoute(path: "/there", subpaths: [ ASubRoute(...) ]),
    //   ],
    // )

    // Wouter approach:
    WouterSwitch(
      routes: {
        "/here": (context, args) => MyHerePage(),
        "/there/subpath": (context, args) => MyThereSubPage(),
      }
    )
    ```
3.  **Enable True Widget-Centric Nesting:** With Navigator 1.0, placing a `Navigator` widget within a `Provider` to scope data was straightforward. Wouter reclaims this simplicity for Navigator 2.0. You can easily nest `Wouter` scopes or `WouterSwitch` widgets within specific parts of your UI, providing scoped data or layouts without restructuring your entire routing setup.
    ```dart
    MyWidget(
      child: SomeProvider( // Provide data specifically for this section
        child: Wouter(     // Create a routing scope for this section
          base: '/section',
          child: WouterSwitch(
            routes: {
              '/item': (context, args) => ItemPage(),
            }
          ),
        ),
      )
    )
    ```
4.  **Facilitate Reactive Parallel UIs:** A key strength of Wouter is its ability to have multiple independent `WouterSwitch` or `WouterNavigator` widgets reacting to the same route. Imagine a layout with a main content area and a sidebar, both changing based on the current path:
    ```dart
    Row(
      children: [
        // Sidebar changes based on the route
        MySidebarWithWouterSwitch(),
        // Main content area also changes based on the route
        Expanded(child: MainContentWithWouterSwitch()),
      ],
    )
    ```
    If the path is `/dashboard/profile`, both the sidebar and main content can independently display relevant information for `/dashboard/profile` without complex coordination.
5.  **Focus on Routing, Not Extras:** Many packages bundle features like tab controllers, bottom navigation handlers, or complex guard systems. Wouter focuses purely on routing. For features like conditional navigation (guards), Wouter encourages leveraging Flutter's reactive nature:
    ```dart
    // Using a reactive getter like context.watch<AuthService>().isUserAuth
    WouterSwitch(
      routes: {
        if (!authService.isUserAuth) // Assuming authService is available
          "/auth": (context, args) => LoginPage(),
        if (authService.isUserAuth)
          "/home": (context, args) => HomePage(),
        // A simple redirect for unmatched routes (assuming Redirect widget exists)
        "/:_(.*)": (context, args) => Redirect(
          to: authService.isUserAuth ? "/home" : "/auth",
        ),
      }
    )
    ```
    Changes to `isUserAuth` will naturally rebuild the `WouterSwitch`, updating the available routes without needing explicit guard mechanisms within the routing package itself.

Wouter strives to be the "missing piece" for developers who love Flutter's widget composition model and want their routing to integrate just as seamlessly.

## Key Features

*   **Widget-Centric API:** Manage routes using familiar Flutter widgets like `Wouter`, `WouterSwitch`, and `WouterNavigator`.
*   **Minimal Boilerplate:** Define routes with simple `Map<String, WouterWidgetBuilder>`. No complex route classes needed.
*   **Powerful Path Matching:** Utilizes [path_to_regexp](https://pub.dev/packages/path_to_regexp) for robust route pattern matching, including parameters (e.g., `/:id(\d+)`) and wildcards (e.g., `/:_(.*)`).
*   **Relative Path Navigation:** Easily navigate with relative paths (e.g., `push("details")`, `replace("../overview")`) using path normalization.
*   **Nested and Parallel Routing:**
    *   Use the `Wouter` widget to define nested scopes with base paths.
    *   Place multiple `WouterSwitch` or `WouterNavigator` widgets in `Column`, `Row`, etc., for parallel route-dependent UIs.
*   **Scoped State Management:** `WouterStateStreamable` provides reactive access to the current route state, scoped appropriately for nested contexts, and distributed via `Provider`.
*   **Customizable Stack Display:** `WouterNavigator` allows you to define how a stack of matched routes is rendered (e.g., using Flutter's `Stack`, `PageView`, or custom transitions).
*   **Immutability:** Core state objects (`WouterState`, `RouteEntry`, etc.) are immutable, built with [freezed](https://pub.dev/packages/freezed).
*   **Declarative Navigation:** Widgets like `Replace`, `Reset`, `ReplaceUntil` trigger navigation effects when built.
*   **UI Integration:** `WouterTab` and `WouterPage` offer seamless integration with `TabController` and `PageController`.
*   **Action Extensions:** Convenient extensions on `WouterAction` like `popCount` and `popUntil`.
*   **Action Interceptors:** Use `WouterActionsScope` to intercept push/pop actions for implementing guards or side effects.

## Core Components

These are the foundational pieces for integrating Wouter into your Flutter application's `Router`.

### WouterRouterDelegate

The main `RouterDelegate` implementation for Wouter. It manages the navigation state, communicates with Flutter's `Router`, and builds your app's UI based on the current route.

```dart
final delegate = WouterRouterDelegate(
  builder: (context) => WouterSwitch( // Or any root widget
    routes: {
      '/': (context, args) => HomeScreen(),
      // ... other routes
    },
  ),
);

// In your MaterialApp.router:
MaterialApp.router(
  routerDelegate: delegate,
  // ...
);
```

### WouterRouteInformationParser

A `RouteInformationParser` that converts between the platform's `RouteInformation` (like URLs) and Wouter's internal string-based route representation.

```dart
// In your MaterialApp.router:
MaterialApp.router(
  routeInformationParser: const WouterRouteInformationParser(),
  // ...
);
```
You can provide a custom `parse` callback for advanced URL parsing needs.

## Routing Widgets

These widgets are used to define how your UI responds to different routes.

### Wouter (Scoping Widget)

Establishes a nested Wouter routing scope with a specific `base` path. Widgets within its `child` tree will operate with paths relative to this base.

```dart
const Wouter({
  super.key,
  this.base = '', // Base path for this scope
  required this.child,
});
```

**Example:**
```dart
Wouter(
  base: '/settings',
  child: WouterSwitch(
    routes: {
      // Matches /settings/profile
      '/profile': (context, args) => ProfileSettingsScreen(),
      // Matches /settings/account
      '/account': (context, args) => AccountSettingsScreen(),
    },
  ),
)
```

### WouterSwitch

Displays one widget from a set of `routes` based on the first matching path pattern.

```dart
const WouterSwitch({
  super.key,
  required Map<String, WouterWidgetBuilder> routes,
  Color? background,
  Widget? fallback, // Widget to show if no route matches
  WouterEntryBuilder entryBuilder = WouterNavigator.defaultEntryBuilder,
});
```

**Example:**
```dart
WouterSwitch(
  routes: {
    '/': (context, args) => HomePage(),
    r'/users/:id(\d+)': (context, args) => UserProfilePage(userId: args['id'] as String), // Ensure type safety
    '/:_(.*)': (context, args) => NotFoundPage(), // Fallback for any other path
  },
)
```

### WouterNavigator

A more advanced widget that manages a stack of child routes based on the parent Wouter state. It allows for custom rendering of this stack using a `builder` (of type `WouterStackBuilder`).

```dart
const WouterNavigator({
  super.key,
  PathMatcher? matcher,
  required Map<String, WouterWidgetBuilder> routes,
  required WouterStackBuilder builder, // Custom stack rendering
  WouterEntryBuilder entryBuilder = WouterNavigator.defaultEntryBuilder,
});
```

This is powerful for creating UIs where multiple matched routes from a nested scope might be visible or managed in a custom way (e.g., master-detail views, custom page transitions).

## UI Integration Widgets

Widgets to easily integrate Wouter with common Flutter UI patterns.

### WouterListenable

Synchronizes a generic Flutter `Listenable` (e.g., `ChangeNotifier`, `ValueNotifier`) with Wouter's navigation state. Useful for custom scenarios.

```dart
const WouterListenable<T extends Listenable>({
  // ... create, dispose, index, onChanged, routes, builder, toPath, toIndex ...
});
```

### WouterTab

Synchronizes a `TabController` (for `TabBar` and `TabBarView`) with Wouter routes. Each tab corresponds to a route.

```dart
const WouterTab({
  super.key,
  required Map<String, Widget> routes, // Tab content widgets
  required WouterListenableWidgetBuilder<TabController> builder,
});
```

### WouterPage

Synchronizes a `PageController` (for `PageView`) with Wouter routes. Each page corresponds to a route.

```dart
const WouterPage({
  super.key,
  required Map<String, Widget> routes, // Page widgets
  required WouterListenableWidgetBuilder<PageController> builder,
});
```

## Declarative Navigation Widgets

These widgets trigger navigation actions when they are built.

### Replace

Replaces the current route with a new one specified by `to`.

```dart
Replace(to: '/new-destination')
// Often used as: child: Replace(to: '/other')
```

### ReplaceUntil

Pops routes until a `predicate` is met, then pushes the `to` path.

```dart
ReplaceUntil(
  to: '/new-section',
  predicate: (path) => path == '/dashboard', // Pop until /dashboard is current
)
```

### Reset

Clears the current navigation stack and builds a new one from the `to` list of paths.

```dart
Reset(to: ['/', '/home', '/profile']) // Sets a new stack
Reset(to: ['/login']) // Resets to only the login page
```

## Performing Navigation

### Accessing Actions

Navigation actions are performed using the `WouterAction` function, typically accessed via an extension on `BuildContext`:

```dart
// Inside a widget's build method or a callback:
context.wouter.actions.push('/new-route');
context.wouter.actions.pop();
```
This requires `WouterRouterDelegate` to have set up the necessary `Provider`s.

### Available Actions

The `WouterAction` dispatcher, accessed via `context.wouter.actions`, provides the following core methods (often through extensions):

*   `push<R>(String path)`: Pushes a new route. Returns `Future<R?>`.
*   `pop([dynamic result])`: Pops the current route. Returns `bool`.
*   `replace<T>(String path, [dynamic result])`: Replaces the current route. Returns `Future<T?>`.
*   `reset([List<String> stack])`: Resets the navigation stack.
*   `popCount(int times, [dynamic Function(String)? result])`: Pops multiple routes.
*   `popUntil(bool Function(String) predicate, [dynamic Function(String)? result])`: Pops routes until a predicate is met.
*   `replaceUntil<R>(String path, bool Function(String) predicate, [dynamic Function(String)? result])`: Pops until a predicate, then pushes.

These actions are processed by the `WouterRouterDelegate` and update the navigation state.

## Concepts

### Widget-Centric Routing

Wouter treats routing components (`Wouter`, `WouterSwitch`, `WouterNavigator`) as regular Flutter widgets. This allows you to place them anywhere in your widget tree, combine them with `Provider`s for dependency injection at specific route scopes, and build your UI declaratively.

### Scoped State with WouterStateStreamable

The `WouterRouterDelegate` provides a root `WouterStateStreamable`. The `Wouter` widget creates child (scoped) `WouterStateStreamable` instances. This streamable object gives access to:
*   `state`: The current `WouterState` (immutable, contains `base`, `stack`, `canPop`).
*   `stream`: A `Stream<WouterState>` that emits new states upon route changes.

These are made available via `Provider`, so descendant widgets can `context.watch<WouterStateStreamable>()` or use `context.wouter.stream` / `context.wouter.state`. The `WouterParentMixin` helps widgets correctly subscribe to the appropriate parent/scoped stream.

### Path Matching

Wouter uses a `PathMatcher` (function type `MatchData? Function(String path, String pattern, {bool prefix})`) to match URL paths against route patterns.
*   `PathMatchers.regexp()`: Standard RegExp matcher.
*   `PathMatchers.cachedRegexp()`: Recommended RegExp matcher with caching for performance.
This system uses `package:path_to_regexp` for flexible pattern definitions.

### Action Interceptors

The `WouterActionsScope` widget allows you to register `onPush` and `onPop` callbacks. These callbacks are invoked before a push or pop action is executed and can prevent the action by returning `false`. This is useful for implementing navigation guards or logging.

```dart
WouterActionsScope(
  onPush: (path) {
    if (path == '/admin' && !isAdmin) { // Assuming isAdmin is available
      print('Access to $path denied.');
      return false; // Prevent navigation
    }
    return true; // Allow
  },
  child: MyAppContent(),
)
```

## Getting Started Example

```dart
import 'package:flutter/material.dart';
import 'package:wouter/wouter.dart';

void main() {
  runApp(MyApp());
}

// Define a Redirect widget (if not part of wouter core, implement as needed)
class Redirect extends StatefulWidget {
  final String to;
  const Redirect({super.key, required this.to});

  @override
  State<Redirect> createState() => _RedirectState();
}

class _RedirectState extends State<Redirect> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) context.wouter.actions.replace(widget.to);
    });
  }
  @override
  Widget build(BuildContext context) => const SizedBox.shrink();
}


class MyApp extends StatelessWidget {
  // 1. Create the WouterRouterDelegate
  //    Pass your root routing widget (e.g., WouterSwitch) to its builder.
  final delegate = WouterRouterDelegate(
    builder: (context) => WouterSwitch(
      routes: {
        '/': (context, arguments) => const HomeScreen(),
        '/users': (context, arguments) => const UsersScreen(),
        r'/users/:id(\d+)': (context, arguments) => UserDetailsScreen(id: arguments['id'] as String),
        // Fallback for any unmatched route
        '/:_(.*)': (context, arguments) => const NotFoundScreen(),
      },
    ),
  );

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // 2. Use MaterialApp.router
    return MaterialApp.router(
      title: 'Wouter Demo',
      // 3. Provide the WouterRouterDelegate
      routerDelegate: delegate,
      // 4. Provide the WouterRouteInformationParser
      routeInformationParser: const WouterRouteInformationParser(),
      // 5. Optional: Add a BackButtonDispatcher if needed
      // backButtonDispatcher: WouterBackButtonDispatcher(delegate: delegate), // Implement if needed
    );
  }
}

// Example Screen Widgets
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => context.wouter.actions.push('/users'),
              child: const Text('Go to Users'),
            ),
            ElevatedButton(
              onPressed: () => context.wouter.actions.push('/users/123'),
              child: const Text('Go to User 123'),
            ),
            ElevatedButton(
              onPressed: () => context.wouter.actions.push('/non-existent-page'),
              child: const Text('Go to Not Found'),
            ),
          ],
        ),
      ),
    );
  }
}

class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Users')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => context.wouter.actions.push('/users/456'),
          child: const Text('View User 456'),
        ),
      ),
    );
  }
}

class UserDetailsScreen extends StatelessWidget {
  final String id;
  const UserDetailsScreen({super.key, required this.id});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User Details: $id')),
      body: Center(child: Text('Details for user $id')),
    );
  }
}

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Not Found')),
      body: const Center(child: Text('404 - Page Not Found!')),
    );
  }
}
```

## Advanced Usage Examples

### Nested Routing

Use the `Wouter` widget to create nested routing scopes.

```dart
// In UsersScreen.dart (matches '/users' from parent scope)
Wouter(
  base: '/users', // Parent route is /users, this Wouter handles paths starting with /users
  child: WouterSwitch(
    routes: {
      // Matches /users (if parent path is /users and this Wouter's base is /users, effective path is /)
      '/': (context, args) => UserListPage(),
      // Matches /users/profile
      '/profile': (context, args) => UserProfilePage(),
      // Matches /users/:id
      r'/:id(\d+)': (context, args) => UserDetailsPage(id: args['id'] as String),
    },
  ),
)
```
If the app navigates to `/users/profile`, the outer router matches `/users`, and then the nested `Wouter` and `WouterSwitch` handle the `/profile` segment relative to the `/users` base.

### Conditional Routes & Guards

Routes in `WouterSwitch` or `WouterNavigator` are just entries in a `Map`. You can conditionally include them based on application state. For more complex guards, use `WouterActionsScope`.

```dart
// auth_service.dart (conceptual - use your preferred state management)
// class AuthService extends ChangeNotifier { bool isAuthenticated = false; ... }

// app_routes.dart
// Assuming `authService` is accessible, e.g., via Provider
// final authService = context.watch<AuthService>();

WouterSwitch(
  routes: {
    // Public routes
    '/login': (context, args) => LoginPage(),

    // Protected routes - using a hypothetical AuthService
    if (context.watch<AuthService>().isAuthenticated) ...{ // Replace with your actual auth check
      '/dashboard': (context, args) => DashboardPage(),
      '/settings': (context, args) => SettingsPage(),
    },

    // Fallback / Redirect
    '/:_(.*)': (context, args) => context.watch<AuthService>().isAuthenticated
        ? const Redirect(to: '/dashboard')
        : const Redirect(to: '/login'),
  },
)
```

### Custom Stack UI with WouterNavigator

Use `WouterNavigator` with a custom `WouterStackBuilder` to control how multiple active routes are displayed (e.g., for master-detail layouts or custom page transitions).

```dart
WouterNavigator(
  routes: {
    // Assuming base path is '/' for this example
    '/items': (context, args) => ItemListScreen(), // Master
    r'/items/:id(\d+)': (context, args) => ItemDetailScreen(id: args['id'] as String), // Detail
  },
  builder: (context, List<Widget> stackedWidgets) {
    // Example: Simple side-by-side layout for master-detail
    // This builder logic needs to be smart about what `stackedWidgets` contains based on `_createEntries`
    if (stackedWidgets.length == 2) {
      return Row(
        children: [
          SizedBox(width: 200, child: stackedWidgets[0]), // Master (e.g., ItemListScreen)
          Expanded(child: stackedWidgets[1]), // Detail (e.g., ItemDetailScreen)
        ],
      );
    } else if (stackedWidgets.isNotEmpty) {
      return stackedWidgets.first; // Show only master or only detail
    }
    return const SizedBox.shrink(); // Or a fallback
  },
)
```