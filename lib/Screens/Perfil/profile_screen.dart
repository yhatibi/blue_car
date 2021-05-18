import 'package:flutter/material.dart';
import 'components/body.dart';

class ProfileScreen extends StatefulWidget {
  static String routeName = "/profile";

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Body(),
    );
  }
}
