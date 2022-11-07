[![Pub Version](https://img.shields.io/pub/v/animated_multichild?color=blueviolet)](https://pub.dev/packages/animated_multichild)

# Animated Multichild

Create ListView, GridView, Row or Column whose children are animated easily.

## Showcase

#### Row

[AnimatedRow](./resources/row.gif)

#### Column

[AnimatedColumn](./resources/column.gif)

#### Grid

[AnimatedGridView](./resources/grid.gif)

#### List

[AnimatedListView](./resources/list_view.gif)

## Getting started

Add `animated_multichild` to `pubspec.yaml` of your project.

```yaml
    dependencies:
      animated_multichild: ^0.0.2
```

Or use the below command to install it with your terminal.

```shell
flutter pub add animated_multichild
```

## Usage

Import it in your Dart code:

```dart
import 'package:animated_multichild/animated_multichild.dart';
```

#### ListView

Replace ListView with AnimatedListView. You can also use `builder` and `separated` constructors. But 
`custom` constructor is not available

```dart
  AnimatedListView.builder(
    itemBuilder: (BuildContext context, int index) {
      return const SizedBox(
        width: double.infinity,
        height: 100,
        child: Card(
          margin: EdgeInsets.all(8),
          elevation: 4,
        ),
      );
    },
    itemCount: 16,
  )
```

See the example folder to view examples for other widgets.

#### Transitions

You can customize how the animation is built via the `transitionBuilder` property.

```dart
/// This will create a fade effect for the children
  AnimatedListView.builder(
    transitionBuilder: (context, animation, child) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    },
    /// rest of your code
  )
```

There are some pre-defined transitions available via the `Transitions` class. They are

- `fadeIn`
- `scale`
- `slideInFromLeft`
- `slideInFromRight`
- `slideInFromBottom`

The `Transitions` class also has a `combine` method which takes a list of transition builders to combine
multiple transitions into one transition.

Along with `transitionBuilder`, there are another functions which passes the index of the child widget
to the transition builder. This is known as `IndexedTransitionBuilder`. This is helpful to apply different 
transitions to different widgets based on the index.

#### Duration and Delay

You can customize the duration of the animation and starting delay of the animation.

The `duration` parameter takes in a `Duration` which defines how long the animation should run.

The `delay` parameter takes in a `Duration` which defines the starting delay of the of the animation. 
Remember that this delay is incremental. This is used to apply staggered animation effect. If you don't 
want staggered animation effect than set this delay to `Duration.zero`.

Also to customize the delay of the animation without staggered effect, you can define a 
[CurvedAnimation](https://api.flutter.dev/flutter/animation/CurvedAnimation-class.html) with an 
[Interval](https://api.flutter.dev/flutter/animation/Interval-class.html) curve to the transition builder.

## License

[MIT License](https://github.com/sushmoyr/animated_multichild/blob/main/LICENSE)
