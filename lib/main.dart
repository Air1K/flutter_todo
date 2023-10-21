import 'package:flutter/material.dart';
import 'package:first_project/page/home_page.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_flutter/hive_flutter.dart';
void main() async{
  await Hive.initFlutter();
  await Hive.openBox("myBox");
  runApp(const MyMainWidget());
}

class MyMainWidget extends StatelessWidget {
  const MyMainWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "TO DO",
      theme: ThemeData(
        useMaterial3: false,
        fontFamily: "Gabarito",

        // colorScheme: ColorScheme.fromSeed(
        //   seedColor: Colors.green,
        // ),

        primarySwatch: Colors.blueGrey,
        // colorScheme: ColorScheme.fromSwatch().copyWith(
        //   primary: Colors.black12,
        //   // secondary: Colors.yellow.black12,
        // ),
      ),
      home: const HomePage(),
    );
  }
}


