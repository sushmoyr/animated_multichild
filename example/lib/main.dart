import 'package:animated_multichild/animated_multichild.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Builder(builder: (context) {
        return Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (_) => const ListViewPage(title: 'title')),
                    );
                  },
                  child: const Text('Animated ListView'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const ColumnPage()),
                    );
                  },
                  child: const Text('Animated Column'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const RowPage()),
                    );
                  },
                  child: const Text('Animated Row'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const GridPage()),
                    );
                  },
                  child: const Text('Animated Grid'),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

class GridPage extends StatelessWidget {
  const GridPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animated Grid'),
      ),
      body: AnimatedGridView.extent(
        padding: const EdgeInsets.all(16),
        transitionBuilder:
            Transitions.combine([Transitions.scale, Transitions.fadeIn]),
        curve: Curves.ease,
        maxCrossAxisExtent: 150,
        children: [
          for (int i = 0; i < 30; i++)
            Card(
              elevation: 4,
            )
        ],
      ),
    );
  }
}

class ColumnPage extends StatelessWidget {
  const ColumnPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animated Column'),
      ),
      body: AnimatedColumn(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          for (int i = 0; i < 5; i++)
            const SizedBox(
              width: double.infinity,
              height: 100,
              child: Card(
                margin: EdgeInsets.all(8),
                elevation: 4,
              ),
            )
        ],
      ),
    );
  }
}

class RowPage extends StatelessWidget {
  const RowPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animated Row'),
      ),
      body: AnimatedRow(
        children: [
          for (int i = 0; i < 5; i++)
            const SizedBox(
              width: 64,
              height: 64,
              child: Card(
                margin: EdgeInsets.all(8),
                elevation: 4,
              ),
            ),
        ],
      ),
    );
  }
}

class ListViewPage extends StatefulWidget {
  const ListViewPage({super.key, required this.title});
  final String title;

  @override
  State<ListViewPage> createState() => _ListViewPageState();
}

class _ListViewPageState extends State<ListViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.grey.shade400,
      body: AnimatedListView.builder(
        // indexedChildTransitionBuilder: (context, animation, child, index) {
        //   return index.isEven
        //       ? Transitions.slideInFromLeft(context, animation, child)
        //       : Transitions.slideInFromRight(context, animation, child);
        // },
        transitionBuilder: (context, animation, child) {
          final position = Tween(begin: const Offset(0, 50), end: Offset.zero)
              .animate(animation);
          return Transform.translate(
            offset: position.value,
            child: Opacity(
              opacity: animation.value,
              child: child,
            ),
          );
        },
        delay: const Duration(milliseconds: 40),
        curve: Curves.ease,
        duration: const Duration(milliseconds: 375),
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
        // separatorBuilder: (BuildContext context, int index) {
        //   return Text('I am separator');
        // },
      ),
    );
  }
}
