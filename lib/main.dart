import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
        ),
        body: Column(
          children: <Widget> [
            const TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  labelText: 'Email'
              ),
            ),
            const TextField(
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                  labelText: 'Password'
              ),
            ),
            ElevatedButton(
                onPressed: () => print('login clicked'),
                child: const Text('Login'),
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 36)),
            )
          ],
        ),
      )
    );
  }
}
