import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:matrimony_db/Screen/AddScreen.dart';
import 'package:matrimony_db/Screen/FavScreen.dart';
import 'package:matrimony_db/Screen/ListScreen.dart';
import 'package:matrimony_db/Screen/SearchScreen.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    _portraitModeOnly();
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Montserrat'),
      home: const MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

void _portraitModeOnly() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9EFEB),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFE8A7E),
        automaticallyImplyLeading: false,
        title: const Text(
          'Matrimony',
          style: TextStyle(fontSize: 23.0, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: 310.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(10),
                        bottomLeft: Radius.circular(150),
                      ),
                      color: Color(0xFFFE8A7E),
                    ),
                  ),
                  Positioned(
                    bottom: 550,
                    right: 100,
                    child: Container(
                      height: 400,
                      width: 400,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(200),
                          color: Color(0xFFFFFFF).withOpacity(0.25)),
                    ),
                  ),
                  Positioned(
                    bottom: 480,
                    left: 200,
                    child: Container(
                      height: 300,
                      width: 300,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(150),
                          color: Color(0xFFFFFF).withOpacity(0.4)),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 15.0,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 15.0,
                          ),
                        ],
                      ),
                      SizedBox(height: 25),
                      Container(
                        margin: EdgeInsets.all(12),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  child: Material(
                                    elevation: 4.0,
                                    borderRadius: BorderRadius.circular(7.0),
                                    child: InkWell(
                                      splashColor: Colors.red,
                                      borderRadius: BorderRadius.circular(7.0),
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AddScreen()),
                                        );
                                      },
                                      child: Container(
                                        margin: EdgeInsets.all(5),
                                        height: 125.0,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(7.0),
                                            color: Colors.white),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            SizedBox(height: 10.0),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(left: 15.0),
                                              child: Image.asset(
                                                'assets/add.png',
                                                fit: BoxFit.cover,
                                                height: 50.0,
                                                width: 50.0,
                                              ),
                                            ),
                                            SizedBox(height: 15.0),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(left: 15.0),
                                              child: Text(
                                                'Add User',
                                                style: TextStyle(
                                                  fontSize: 18.0,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Material(
                                    elevation: 4.0,
                                    borderRadius: BorderRadius.circular(7.0),
                                    child: InkWell(
                                      splashColor: Colors.red,
                                      borderRadius: BorderRadius.circular(7.0),
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ListScreen()),
                                        );
                                      },
                                      child: Container(
                                        margin: EdgeInsets.all(5),
                                        height: 125.0,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(7.0),
                                            color: Colors.white),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            SizedBox(height: 10.0),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(left: 15.0),
                                              child: Image.asset(
                                                'assets/list.png',
                                                fit: BoxFit.cover,
                                                height: 50.0,
                                                width: 50.0,
                                              ),
                                            ),
                                            SizedBox(height: 15.0),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(left: 15.0),
                                              child: Text(
                                                'List Of User',
                                                style: TextStyle(
                                                  fontSize: 18.0,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  child: Material(
                                    elevation: 4.0,
                                    borderRadius: BorderRadius.circular(7.0),
                                    child: InkWell(
                                      splashColor: Colors.red,
                                      borderRadius: BorderRadius.circular(7.0),
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  SearchScreen()),
                                        );
                                      },
                                      child: Container(
                                        margin: EdgeInsets.all(5),
                                        height: 125.0,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(7.0),
                                            color: Colors.white),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            SizedBox(height: 10.0),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(left: 15.0),
                                              child: Image.asset(
                                                'assets/search.png',
                                                fit: BoxFit.cover,
                                                height: 50.0,
                                                width: 50.0,
                                              ),
                                            ),
                                            SizedBox(height: 15.0),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(left: 15.0),
                                              child: Text(
                                                'Search',
                                                style: TextStyle(
                                                  fontSize: 18.0,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Material(
                                    elevation: 4.0,
                                    borderRadius: BorderRadius.circular(7.0),
                                    child: InkWell(
                                      splashColor: Colors.red,
                                      borderRadius: BorderRadius.circular(7.0),
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  FavScreen()),
                                        );
                                      },
                                      child: Container(
                                        margin: EdgeInsets.all(5),
                                        height: 125.0,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(7.0),
                                            color: Colors.white),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            SizedBox(height: 10.0),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(left: 15.0),
                                              child: Image.asset(
                                                'assets/fav1.png',
                                                fit: BoxFit.cover,
                                                height: 50.0,
                                                width: 50.0,
                                              ),
                                            ),
                                            SizedBox(height: 15.0),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(left: 15.0),
                                              child: Text(
                                                'Favourite',
                                                style: TextStyle(
                                                  fontSize: 18.0,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              padding: EdgeInsets.all(50),
                              child: Image.asset(
                                'assets/couple.png',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
