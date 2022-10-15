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
                          builder: (_) => ListViewPage(title: 'title')),
                    );
                  },
                  child: Text('Animated ListView'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => ColumnPage()),
                    );
                  },
                  child: Text('Animated Column'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => RowPage()),
                    );
                  },
                  child: Text('Animated Row'),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

class ColumnPage extends StatelessWidget {
  const ColumnPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animated Column'),
      ),
      body: AnimatedColumn(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          for (int i = 0; i < 5; i++)
            SizedBox(
              width: double.infinity,
              height: 100,
              child: Card(
                margin: const EdgeInsets.all(8),
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
        title: Text('Animated Row'),
      ),
      body: AnimatedRow(
        children: [
          for (int i = 0; i < 5; i++)
            SizedBox(
              width: 64,
              height: 64,
              child: Card(
                margin: const EdgeInsets.all(8),
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
          return SizedBox(
            width: double.infinity,
            height: 100,
            child: Card(
              margin: const EdgeInsets.all(8),
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
