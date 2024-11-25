import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:async/async.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'fachry',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const FuturePage(),
    );
  }
}

class FuturePage extends StatefulWidget {
  
  const FuturePage({super.key});

  @override
  State<FuturePage> createState() => _FuturePageState();
}

class _FuturePageState extends State<FuturePage> {
  late Completer completer;

Future getNumber() {
  completer = Completer<int>();
  calculate();
  return completer.future;
}

Future calculate() async {
  // await Future.delayed(const Duration(seconds : 5));
  // completer.complete(42);
  try {
    await Future.delayed(const Duration(seconds : 5));
    completer.complete(42);
  } catch (_) {
    completer.completeError({});
  }
}
  Future<int> returnOneAsync() async {
  await Future.delayed(const Duration(seconds: 3));
  return 1;
}

Future<int> returnTwoAsync() async {
  await Future.delayed(const Duration(seconds: 3));
  return 2;
}

Future<int> returnThreeAsync() async {
  await Future.delayed(const Duration(seconds: 3));
  return 3;
}
Future<void> count() async {
  int total = 0;
  total = await returnOneAsync();
  total += await returnTwoAsync();
  total += await returnThreeAsync();

  setState(() { // Memicu pembaruan UI
    result = total.toString();
  });
}
  String result = '';
Future<http.Response> getData() async {
  const authority = 'www.googleapis.com';
  const path = '/books/v1/volumes/LmXyDwAAQBAJ';

  final uri = Uri.https(authority, path);

  final response = await http.get(uri);
  return response;
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Back from the Future'),
      ),
      body: Center(
        child: Column(children: [
          const Spacer(),
          ElevatedButton(
                        child:Text('GO!'),
            onPressed: () {
              // setState(() {});
              // getData()
              //   .then((value) {
              //     result = value.body.toString().substring(0, 450);
              //     setState(() {});
              //   })
              //   .catchError((_) {
              //     result = 'An error occurred';
              //     setState(() {});
              //   });
              // count();
                getNumber().then((value) {
          setState(() {
            result = value.toString();
          });
        }).catchError((_) {
          result = 'An error occurred';
        });
            },
          ),
          const Spacer(),
          Text(result),
          const Spacer(),
          const CircularProgressIndicator(),
          const Spacer(),
        ]),
      ),
    );
  }
}
