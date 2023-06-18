import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Center(
            child: MyHomePage(),
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _frontRotation;
  late Animation<double> _backRotation;
  bool isFrontVisible = true;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    )..addListener(() {
        setState(() {});
      });

    _frontRotation = TweenSequence(
      <TweenSequenceItem<double>>[
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: -math.pi / 2)
              .chain(CurveTween(curve: Curves.easeIn)),
          weight: 50.0,
        ),
        TweenSequenceItem<double>(
          tween: ConstantTween<double>(-math.pi / 2),
          weight: 50.0,
        ),
      ],
    ).animate(_controller);

    _backRotation = TweenSequence(
      <TweenSequenceItem<double>>[
        TweenSequenceItem<double>(
          tween: ConstantTween<double>(math.pi / 2),
          weight: 50.0,
        ),
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: math.pi / 2, end: 0.0)
              .chain(CurveTween(curve: Curves.easeOut)),
          weight: 50.0,
        ),
      ],
    ).animate(_controller);
  }

  void _flip() {
    isFrontVisible = !isFrontVisible;
    if (isFrontVisible)
      _controller.reverse();
    else
      _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Spacer(),
        GestureDetector(
          onTap: _flip,
          child: AnimatedBuilder(
            animation: _controller,
            builder: (BuildContext context, Widget? _) {
              if (_controller.value <= 0.5) {
                return Transform(
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.002)
                    ..rotateY(_frontRotation.value),
                  alignment: Alignment.center,
                  child: _logInCard(),
                );
              } else {
                return Transform(
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.002)
                    ..rotateY(_backRotation.value),
                  alignment: Alignment.center,
                  child: _signUpCard(),
                );
              }
            },
          ),
        ),
        Spacer(),
        ElevatedButton(
          onPressed: _flip,
          child: Text("Flip"),
        ),
        SizedBox(height: 20),
      ],
    );
  }

  Widget _logInCard() {
    return Container(
      height: 400,
      width: 300,
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Log In',
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
            SizedBox(height: 30),
            TextFormField(
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Email',
                hintStyle: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              style: TextStyle(color: Colors.white),
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Password',
                hintStyle: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                print('Logged In');
              },
              child: Text('Log In'),
            ),
          ],
        ),
      ),
    );
  }

    Widget _signUpCard() {
    return Container(
      height: 400,
      width: 300,
      decoration: BoxDecoration(
        color: Colors.deepOrange,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Sign Up',
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
            SizedBox(height: 30),
            TextFormField(
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Name',
                hintStyle: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Email',
                hintStyle: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              style: TextStyle(color: Colors.white),
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Password',
                hintStyle: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                print('Signed Up');
              },
              child: Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }


  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}








 
