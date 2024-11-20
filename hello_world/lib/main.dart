import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp( // 머티리얼 디자인 위젯
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              Text('Code'),
              Text('Factory'),
            ],
          ),
        ),
      ),
    ),
  );
}

