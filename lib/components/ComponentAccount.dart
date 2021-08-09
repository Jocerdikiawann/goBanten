import 'package:flutter/material.dart';

class ComponentAccount extends StatefulWidget {
  const ComponentAccount({Key key}) : super(key: key);

  @override
  _ComponentAccountState createState() => _ComponentAccountState();
}

class _ComponentAccountState extends State<ComponentAccount> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Screen Account'),
    );
  }
}
