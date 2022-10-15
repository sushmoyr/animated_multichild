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
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => MyHomePage(title: 'title')),
                );
              },
              child: Text('Go'),
            ),
          ),
        );
      }),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedListView.separated(
        transitionBuilder: Transitions.combine([
          // Transitions.slideInFromLeft,
          Transitions.fadeIn,
          Transitions.slideInFromBottom,
        ]),
        delay: kThemeChangeDuration,
        curve: Curves.decelerate,
        duration: const Duration(milliseconds: 300),
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: const EdgeInsets.all(16),
            color: Colors.primaries[index],
            height: 100,
            width: double.maxFinite,
          );
        },
        itemCount: Colors.primaries.length,
        separatorBuilder: (BuildContext context, int index) {
          return Text('I am separator');
        },
      ),
    );
  }
}
