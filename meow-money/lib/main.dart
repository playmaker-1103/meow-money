import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:monney_management/models/money.dart';
import 'package:monney_management/models/user.dart';
import 'package:monney_management/services/auth_service.dart';
import 'package:monney_management/pages/splash_page.dart';
import 'package:monney_management/services/database.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:flutter/services.dart';

void main() async{
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.white, // status bar color
  ));
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<MyUser?>.value(value: AuthService().user, initialData:null),
        StreamProvider<List<UserInformation>?>.value(value:Database().authData, initialData: null),
        StreamProvider<List<Bills>?>.value(value: Database().billsData, initialData:null),
        StreamProvider<List<Incomes>?>.value(value: Database().incomesData, initialData:null),
        StreamProvider<List<Saving>?>.value(value: Database().savingData, initialData:null),
      ],
      child:const MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Finance Management',
          home: Myscreen(),
        ),
    );
  }
}


