import 'package:monney_management/pages/home/home_page.dart';
import 'login/login.dart';
import 'package:provider/provider.dart';
import 'package:monney_management/models/user.dart';
import 'package:flutter/material.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user=Provider.of<MyUser?>(context);
    if(user!=null){
      return const MyHomePage();
    }
    else {
      return const Login();
    }
  }
}
