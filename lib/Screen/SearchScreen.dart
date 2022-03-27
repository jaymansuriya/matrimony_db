import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:matrimony_db/Screen/AddScreen.dart';
import 'package:matrimony_db/main.dart';

import '../db/db_service.dart';
import '../models/user_model.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

TextEditingController myController = TextEditingController();

class _SearchScreenState extends State<SearchScreen> {
  String a = "";
  late List<UserModel> num = [];

  void cont() async {
    setState(() {
      a = myController.text.trim();
    });
    if (a.isNotEmpty) {
      num = await dbService.getSearch(a);
      setState(() {
        for (int i = 0; i < num.length; i++) {
          num[i].toJson()["UserName"];
        }
      });
    } else {
      return null;
    }
  }

  void blank() async {
    setState(() {
      a = "1234";
    });
    if (a.isNotEmpty) {
      num = await dbService.getSearch(a);
      setState(() {
        for (int i = 0; i < num.length; i++) {
          num[i].toJson()["UserName"];
        }
      });
    } else {
      return null;
    }
  }

  dynamic getSearch() async {
    num = await dbService.getSearch(a);
    setState(() {
      for (int i = 0; i < num.length; i++) {
        num[i].toJson()["UserName"];
      }
    });
  }

  DbService dbService = DbService();
  final myController = TextEditingController();
  @override
  void initState() {
    super.initState();

    myController.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFE8A7E),
        title: const Text(
          'Search User',
          style: TextStyle(fontSize: 23.0, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      backgroundColor: const Color(0xFFF9EFEB),
      body: ListView(
        children: [
          Column(
            children: [
              Container(
                padding: EdgeInsets.all(25),
                child: TextField(
                  onChanged: (text) {
                    a = myController.text.trim();
                    if (a.isNotEmpty) {
                      cont();
                    } else {
                      blank();
                    }
                  },
                  controller: myController,
                  onEditingComplete: cont,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Colors.red,
                    ),
                    suffixIcon: myController.text.isEmpty
                        ? Container(width: 0)
                        : IconButton(
                            icon: Icon(
                              Icons.clear,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              myController.clear();
                              blank();
                            },
                          ),
                    prefixIconColor: Colors.red,
                    hintText: 'Search User Here',
                    hintStyle: const TextStyle(
                      fontFamily: 'WorkSans',
                    ),
                    labelText: 'Search Users',
                    labelStyle: const TextStyle(
                      fontFamily: 'WorkSans',
                      color: Colors.red,
                    ),
                    contentPadding: const EdgeInsets.only(
                      left: 12.0,
                      bottom: 6.0,
                      top: 6.0,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.red,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.red,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(25),
                      ),
                    ),
                  ),
                ),
              ),
              _fetchData(),
            ],
          ),
        ],
      ),
    );
  }

  //
  _fetchData() {
    return FutureBuilder<List<UserModel>>(
        future: dbService.getSearch(a),
        builder: (BuildContext context, num) {
          if (num.hasData) {
            return _buildDataTable(num.data!);
          }
          return const Center(child: CircularProgressIndicator());
        });
  }

  _buildDataTable(List<UserModel> user) {
    return Container(
        height: 500,
        child: ListView.builder(
            itemCount: num.length,
            itemBuilder: (BuildContext context, int index) {
              return SizedBox(
                height: MediaQuery.of(context).size.height - 100,
                child: ListView.builder(
                    itemCount: user.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 15.0, top: 15.0),
                        child: Stack(
                          children: <Widget>[
                            Container(
                              height: 190.0,
                              width: 500,
                            ),
                            Positioned(
                              left: 30.0,
                              top: 30.0,
                              child: Container(
                                height: 130.0,
                                width: 500,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF9EFEB),
                                  borderRadius: BorderRadius.circular(5.0),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.withOpacity(0.3),
                                        spreadRadius: 9.0,
                                        blurRadius: 9.0)
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                                left: 95.0,
                                top: 60.0,
                                child: Container(
                                  height: 120.0,
                                  width: 500,
                                  decoration: BoxDecoration(
                                      color: const Color(0xFFF9EFEB),
                                      borderRadius: BorderRadius.circular(5.0),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey.withOpacity(0.3),
                                            spreadRadius: 5.0,
                                            blurRadius: 5.0)
                                      ]),
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 10.0, left: 10.0),
                                      child: Row(
                                        children: <Widget>[
                                          InkWell(
                                            onTap: () {},
                                            child: FavoriteButton(
                                              iconSize: 35,
                                              isFavorite:
                                                  user[index].IsFavorite == 1
                                                      ? true
                                                      : false,
                                              valueChanged: (favbutton) {
                                                print(user[index].id);

                                                if (favbutton == true) {
                                                  dbService.setFav(
                                                      1,
                                                      int.parse(user[index]
                                                          .id
                                                          .toString()));
                                                }
                                                if (favbutton == false) {
                                                  dbService.setFav(
                                                      0,
                                                      int.parse(user[index]
                                                          .id
                                                          .toString()));
                                                }
                                              },
                                            ),
                                          ),
                                          const SizedBox(width: 90.0),
                                          InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      AddScreen(
                                                    isEditMode: true,
                                                    model: user[index],
                                                  ),
                                                ),
                                              );
                                            },
                                            child: const Icon(
                                              Icons.edit,
                                              color: Colors.blueAccent,
                                              size: 23.0,
                                            ),
                                          ),
                                          const SizedBox(width: 90.0),
                                          InkWell(
                                            onTap: () {
                                              showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext contex) {
                                                    return AlertDialog(
                                                      title:
                                                          const Text("Delete"),
                                                      content: const Text(
                                                          "Do you want to delete this record"),
                                                      actions: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            ElevatedButton(
                                                              onPressed: () {
                                                                dbService
                                                                    .deleteUser(
                                                                        user[
                                                                            index])
                                                                    .then(
                                                                  (value) {
                                                                    setState(
                                                                        () {
                                                                      Navigator.push(
                                                                          context,
                                                                          MaterialPageRoute(
                                                                              builder: (context) => const MyHomePage()));
                                                                    });
                                                                  },
                                                                );
                                                              },
                                                              child: const Text(
                                                                  "Delete"),
                                                            ),
                                                            const SizedBox(
                                                              width: 5,
                                                            ),
                                                            ElevatedButton(
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                              child: const Text(
                                                                  "No"),
                                                            )
                                                          ],
                                                        )
                                                      ],
                                                    );
                                                  });
                                            },
                                            child: const Icon(
                                                Icons.delete_rounded,
                                                color: Colors.red,
                                                size: 23.0),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )),
                            PhysicalModel(
                              color: Colors.white,
                              elevation: 4,
                              shadowColor: Colors.red,
                              borderRadius: BorderRadius.circular(100),
                              child: Container(
                                height: 135.0,
                                width: 500,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.white,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        user[index].toJson()["Gender"] as int ==
                                                1
                                            ? "assets/man.png"
                                            : user[index].toJson()["Gender"]
                                                        as int ==
                                                    2
                                                ? "assets/girl.png"
                                                : "assets/ftm.png",
                                        height: 70,
                                        width: 70,
                                      ),
                                      const SizedBox(width: 10.0),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          const SizedBox(height: 10.0),
                                          Text(
                                            user[index].toJson()['UserName'],
                                            style: const TextStyle(
                                                color: Color(0xFF563734),
                                                fontFamily: 'Montserrat',
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.w800),
                                          ),
                                          const SizedBox(height: 5.0),
                                          Row(
                                            children: [
                                              const Text(
                                                'Date of birth : ',
                                                style: TextStyle(
                                                    fontFamily: 'Montserrat',
                                                    fontSize: 12.0,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              Text(
                                                user[index].toJson()["DOB"],
                                                style: const TextStyle(
                                                    color: Color(0xFFB2A9A9),
                                                    fontFamily: 'Montserrat',
                                                    fontSize: 12.0,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              const Text(
                                                'Age : ',
                                                style: TextStyle(
                                                    fontFamily: 'Montserrat',
                                                    fontSize: 12.0,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              Text(
                                                user[index]
                                                    .toJson()["Age"]
                                                    .toString(),
                                                style: const TextStyle(
                                                    color: Color(0xFFB2A9A9),
                                                    fontFamily: 'Montserrat',
                                                    fontSize: 12.0,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 4.0),
                                          Row(
                                            children: [
                                              const Text(
                                                'Gender : ',
                                                style: TextStyle(
                                                    fontFamily: 'Montserrat',
                                                    fontSize: 12.0,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              user[index].toJson()["Gender"]
                                                          as int ==
                                                      1
                                                  ? const Text(
                                                      " Male",
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xFFB2A9A9),
                                                          fontFamily:
                                                              'Montserrat',
                                                          fontSize: 12.0,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    )
                                                  : user[index].toJson()[
                                                                  "Gender"]
                                                              as int ==
                                                          2
                                                      ? const Text(
                                                          " Female",
                                                          style: TextStyle(
                                                            color: Color(
                                                                0xFFB2A9A9),
                                                            fontFamily:
                                                                'Montserrat',
                                                            fontSize: 12.0,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        )
                                                      : const Text(
                                                          " Other",
                                                          style: TextStyle(
                                                            color: Color(
                                                                0xFFB2A9A9),
                                                            fontFamily:
                                                                'Montserrat',
                                                            fontSize: 12.0,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                              const SizedBox(
                                                width: 15.0,
                                              ),
                                              const Text(
                                                'Mobile Number : ',
                                                style: TextStyle(
                                                    fontFamily: 'Montserrat',
                                                    fontSize: 12.0,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              Text(
                                                user[index]
                                                    .toJson()['MobileNumber'],
                                                style: const TextStyle(
                                                    color: Color(0xFFB2A9A9),
                                                    fontFamily: 'Montserrat',
                                                    fontSize: 12.0,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 3,
                                          ),
                                          Row(
                                            children: [
                                              const Text(
                                                'E-mail : ',
                                                style: TextStyle(
                                                    fontFamily: 'Montserrat',
                                                    fontSize: 12.0,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              Text(
                                                user[index].toJson()['Email'],
                                                style: const TextStyle(
                                                    color: Color(0xFFB2A9A9),
                                                    fontFamily: 'Montserrat',
                                                    fontSize: 12.0,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              )
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 3,
                                          ),
                                          Row(
                                            children: [
                                              const Text(
                                                "City :",
                                                style: TextStyle(
                                                  fontSize: 12.0,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                              Text(
                                                user[index]
                                                    .toJson()['CityName'],
                                                style: const TextStyle(
                                                    color: Color(0xFFB2A9A9),
                                                    fontFamily: 'Montserrat',
                                                    fontSize: 12.0,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 3,
                                          ),
                                          Row(
                                            children: [
                                              const Text(
                                                "Country : ",
                                                style: TextStyle(
                                                  fontSize: 12.0,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                              Text(
                                                user[index]
                                                    .toJson()['CountryName'],
                                                style: const TextStyle(
                                                    color: Color(0xFFB2A9A9),
                                                    fontFamily: 'Montserrat',
                                                    fontSize: 12.0,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ],
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    }),
              );
            }));
  }
}
