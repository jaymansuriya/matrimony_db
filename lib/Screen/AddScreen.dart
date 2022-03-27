import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:matrimony_db/db/db_service.dart';
import 'package:matrimony_db/main.dart';
import 'package:matrimony_db/models/user_model.dart';
import 'package:snippet_coder_utils/FormHelper.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({Key? key, this.model, this.isEditMode = false})
      : super(key: key);
  final UserModel? model;
  final bool isEditMode;

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  TextEditingController _DateOfBirthController = TextEditingController();
  DateTime? _dateOfBirth;
  bool isDisableButton = true;
  late DateTime initialDate;
  late UserModel user;
  late int a;
  late DbService dbService;
  List<dynamic> gen = [
    {"id": "1", "name": "Male"},
    {"id": "2", "name": "Female"},
    {"id": "3", "name": "Others"}
  ];
  List<dynamic> fav = [
    {"id": "0", "name": "Yes"},
    {"id": "1", "name": "No"},
  ];

  String countryValue = '';
  String stateValue = '';
  String cityValue = '';

  String address = "";
  @override
  void initState() {
    dbService = DbService();
    super.initState();
    user = UserModel(
      UserName: "",
      DOB: "",
      Age: 0,
      Gender: 0,
      IsFavorite: 0,
      CityName: '',
      CountryName: '',
      StateName: '',
    );

    if (user.MobileNumber == null) {
      user.MobileNumber = "";
    }
    if (user.Email == null) {
      user.Email = "";
    }

    if (widget.isEditMode) {
      user = widget.model!;
      List<String> n = user.DOB.split("/");
      initialDate = DateTime.parse(n[2] + '-' + n[1] + '-' + n[0]);
    } else {
      initialDate = DateTime.now();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9EFEB),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFE8A7E),
        title: Text(
          widget.isEditMode ? 'Edit Details' : "Add Details",
          style: const TextStyle(fontSize: 23.0, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(30.0, 70.0, 30, 0),
            child: Column(
              children: [
                Form(
                  key: globalKey,
                  child: _formUI(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _formUI() {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              blurRadius: 2.0,
              spreadRadius: 0.0,
              offset: Offset(4.0, 6.0), // shadow direction: bottom right
            )
          ],
        ),
        padding: EdgeInsets.all(7.0),
        child: Column(
          children: [
            FormHelper.inputFieldWidgetWithLabel(
              context,
              "UserName",
              "Name",
              "",
              (onValidate) {
                if (onValidate.isEmpty) {
                  return "* Required";
                }
                return null;
              },
              (onSaved) {
                user.UserName = onSaved.toString().trim();
              },
              focusedBorderWidth: 1,
              borderWidth: 1,
              borderColor: const Color.fromRGBO(34, 33, 91, 1),
              labelFontSize: 15,
              labelBold: true,
              paddingLeft: 0,
              borderRadius: 10,
              prefixIcon: const Icon(Icons.account_circle_rounded),
              showPrefixIcon: true,
              prefixIconPaddingLeft: 10,
              prefixIconColor: const Color.fromRGBO(34, 33, 91, .5),
              textColor: const Color.fromRGBO(34, 33, 91, 1),
              borderFocusColor: const Color.fromRGBO(34, 33, 91, 1),
              contentPadding: 15,
              fontSize: 15,
              paddingRight: 0,
              initialValue: user.UserName,
            ),
            FormHelper.dropDownWidgetWithLabel(
              context,
              "Gender",
              "--Select--",
              user.Gender,
              gen,
              (onChanged) {
                user.Gender = int.parse(onChanged);
              },
              (onValidate) {
                if (onValidate == null) {
                  return "* Required";
                }
                return null;
              },
              borderRadius: 10,
              paddingRight: 0,
              paddingLeft: 0,
              labelFontSize: 15,
              borderFocusColor: const Color.fromRGBO(34, 33, 91, 1),
              borderColor: const Color.fromRGBO(34, 33, 91, 1),
              prefixIcon: const Icon(Icons.male),
              showPrefixIcon: true,
              prefixIconPaddingLeft: 10,
              prefixIconColor: const Color.fromRGBO(34, 33, 91, .5),
              focusedBorderWidth: 1,
            ),
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  alignment: Alignment.topLeft,
                  margin: const EdgeInsets.only(top: 15),
                  child: const Text(
                    "Date of Birth",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  margin: const EdgeInsets.only(top: 10, bottom: 10),
                  child: TextFormField(
                    onSaved: (d) async {
                      user.DOB = d.toString();
                      user.Age = await a;
                    },
                    decoration: InputDecoration(
                      labelStyle: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                        color: Color.fromRGBO(34, 33, 91, 1),
                      ),
                      contentPadding: const EdgeInsets.all(15),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color.fromRGBO(34, 33, 91, 1),
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color.fromRGBO(34, 33, 91, 1),
                          ),
                          borderRadius: BorderRadius.circular(10)),
                      prefixIcon: const Icon(
                        Icons.date_range_rounded,
                        color: Color.fromRGBO(34, 33, 91, .5),
                      ),
                    ),
                    controller: _DateOfBirthController,
                    keyboardType: TextInputType.name,
                    onTap: () => pickDateOfBirth(context),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Select Date';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            FormHelper.inputFieldWidgetWithLabel(
                context, "MobileNumber", "Mobile Number", "", (onValidate) {},
                (onSaved) {
              user.MobileNumber = onSaved;
            },
                focusedBorderWidth: 1,
                borderWidth: 1,
                borderColor: const Color.fromRGBO(34, 33, 91, 1),
                labelFontSize: 15,
                labelBold: true,
                paddingLeft: 0,
                borderRadius: 10,
                prefixIcon: const Icon(Icons.call),
                showPrefixIcon: true,
                prefixIconPaddingLeft: 10,
                prefixIconColor: const Color.fromRGBO(34, 33, 91, .5),
                textColor: const Color.fromRGBO(34, 33, 91, 1),
                borderFocusColor: const Color.fromRGBO(34, 33, 91, 1),
                contentPadding: 10,
                fontSize: 15,
                paddingRight: 0,
                isNumeric: true,
                initialValue: user.MobileNumber.toString()),
            FormHelper.inputFieldWidgetWithLabel(
              context,
              "Email",
              "Email",
              "",
              (onValidate) {},
              (onSaved) {
                user.Email = onSaved.toString().trim();
              },
              initialValue: user.Email.toString(),
              focusedBorderWidth: 1,
              borderWidth: 1,
              borderColor: const Color.fromRGBO(34, 33, 91, 1),
              labelFontSize: 15,
              labelBold: true,
              paddingLeft: 0,
              borderRadius: 10,
              prefixIcon: const Icon(Icons.email),
              showPrefixIcon: true,
              prefixIconPaddingLeft: 10,
              prefixIconColor: const Color.fromRGBO(34, 33, 91, .5),
              textColor: const Color.fromRGBO(34, 33, 91, 1),
              borderFocusColor: const Color.fromRGBO(34, 33, 91, 1),
              contentPadding: 15,
              fontSize: 15,
              paddingRight: 0,
            ),
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  alignment: Alignment.topLeft,
                  margin: const EdgeInsets.only(top: 15),
                  child: const Text(
                    "Location",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: CSCPicker(
                    currentCountry: user.CountryName.isNotEmpty
                        ? user.CountryName
                        : '*Country',
                    currentState:
                        user.StateName.isNotEmpty ? user.StateName : '*State',
                    currentCity:
                        user.CityName.isNotEmpty ? user.CityName : '*City',
                    showStates: true,
                    showCities: true,
                    flagState: CountryFlag.ENABLE,
                    dropdownDecoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      color: Colors.white,
                      border: Border.all(
                          color: const Color.fromRGBO(34, 33, 91, 1), width: 1),
                    ),
                    disabledDropdownDecoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      color: Colors.grey.shade300,
                      border: Border.all(
                          color: const Color.fromRGBO(34, 33, 91, .5),
                          width: 1),
                    ),
                    countrySearchPlaceholder: "Country",
                    stateSearchPlaceholder: "State",
                    citySearchPlaceholder: "City",
                    countryDropdownLabel: "*Country",
                    stateDropdownLabel: "*State",
                    cityDropdownLabel: "*City",
                    selectedItemStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                    dropdownHeadingStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontWeight: FontWeight.bold),
                    dropdownItemStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                    dropdownDialogRadius: 10.0,
                    searchBarRadius: 10.0,
                    onCountryChanged: (value) {
                      setState(() {
                        countryValue = value;
                        user.CountryName = countryValue;
                      });
                    },
                    onStateChanged: (value) {
                      setState(() {
                        stateValue = value.toString();
                        user.StateName = stateValue;
                      });
                    },
                    onCityChanged: (value) {
                      setState(
                        () {
                          cityValue = value.toString();
                          user.CityName = cityValue;
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: isDisableButton
                      ? null
                      : () {
                          if (validateAndSave()) {
                            if (widget.isEditMode) {
                              dbService.updateUser(user).then((value) {
                                FormHelper.showSimpleAlertDialog(
                                    context,
                                    "SQFlite",
                                    "Data Modified Successfully ",
                                    "Ok", () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const MyHomePage()),
                                  );
                                });
                              });
                              globalKey.currentState!.save();
                            } else {
                              dbService.addUser(user).then((value) {
                                FormHelper.showSimpleAlertDialog(
                                    context,
                                    "SQFlite",
                                    "Data added successfully ",
                                    "Ok", () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const MyHomePage()),
                                  );
                                });
                              });
                              globalKey.currentState!.save();
                            }
                          }
                        },
                  child: const Text('Submit'),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.lightGreen,
                      elevation: 5,
                      shadowColor: Colors.black),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> pickDateOfBirth(BuildContext context) async {
    final newDate = await showDatePicker(
        context: context,
        initialDate: _dateOfBirth ?? initialDate,
        firstDate: DateTime(DateTime.now().year - 100),
        lastDate: DateTime(DateTime.now().year + 1),
        builder: (context, child) => Theme(
              data: ThemeData().copyWith(
                  colorScheme: const ColorScheme.light(
                primary: Color(0xFFFE8A7E),
              )),
              child: child ?? const Text(''),
            ));
    if (newDate == null) {
      return;
    }
    setState(() {
      _dateOfBirth = newDate;
      String dob = DateFormat('dd/MM/yyyy').format(newDate);
      _DateOfBirthController.text = dob;
      a = calculateAge(newDate);
    });
  }

  calculateAge(DateTime birthDate) {
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;
    int month1 = currentDate.month;
    int month2 = birthDate.month;
    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      int day1 = currentDate.day;
      int day2 = birthDate.day;
      if (day2 > day1) {
        age--;
      }
    }
    if (user.Gender == 1 && age >= 21) {
      isDisableButton = false;
    } else if (user.Gender == 2 && age >= 18) {
      isDisableButton = false;
    } else if (user.Gender == 3 && age >= 18) {
      isDisableButton = false;
    } else {
      isDisableButton = true;
    }
    return age;
  }

  bool validateAndSave() {
    final form = globalKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
