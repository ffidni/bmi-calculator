import 'package:bmi/result.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Home extends StatefulWidget {
  _HomeState createState() => _HomeState();
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

class _HomeState extends State<Home> {
  List<String> measurements = ["Metric", "Imperial"];
  List<String> genders = ["Male", "Female"];
  String currMeasurement = "Metric";
  bool _isError = false;
  String currGender = "Male";
  TextEditingController weight = TextEditingController();
  TextEditingController height = TextEditingController();
  TextEditingController feet = TextEditingController();
  TextEditingController inches = TextEditingController();
  TextEditingController age = TextEditingController();

  createDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            backgroundColor: Color(0xffC4C4C4),
            title: Center(
              child: Text(
                "Measurement system",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            content: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                ),
                color: Colors.white,
              ),
              child: StatefulBuilder(
                  builder: (BuildContext context, StateSetter dropDownState) {
                return DropdownButton(
                  isExpanded: true,
                  underline: SizedBox(),
                  value: currMeasurement,
                  icon: Icon(Icons.keyboard_arrow_down),
                  iconSize: 16,
                  onChanged: (String? newValue) {
                    setState(() {
                      currMeasurement = newValue!;
                      _isError = false;
                      weight.clear();
                      height.clear();
                      feet.clear();
                      inches.clear();
                      age.clear();
                      if (newValue == "Metric") {
                        measurements[0] = "Metric";
                        measurements[1] = "Imperial";
                      } else {
                        measurements[0] = "Imperial";
                        measurements[1] = "Metric";
                      }
                      Navigator.of(context, rootNavigator: true).pop('dialog');
                    });
                  },
                  items: measurements
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: Text(value),
                      ),
                    );
                  }).toList(),
                );
              }),
            ),
          );
        });
  }

  List calculateScore() {
    dynamic result;
    if (weight.text.isNotEmpty &&
        height.text.isNotEmpty &&
        age.text.isNotEmpty) {
      result = ((double.parse(weight.text) /
                  double.parse(height.text) /
                  double.parse(height.text)) *
              10000)
          .toString();
    } else if (weight.text.isNotEmpty &&
        feet.text.isNotEmpty &&
        age.text.isNotEmpty) {
      double heightValue =
          (double.parse(feet.text) * 12) + double.parse(inches.text);
      result = ((double.parse(weight.text) / heightValue / heightValue) * 703)
          .toString();
    }

    if (result.contains(".")) {
      result = result.split(".");
    } else {
      result = [result];
    }
    return result;
  }

  void goToResult(BuildContext context, List result) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ResultScreen([
                double.parse(
                    "${result[0]}.${result[1].length > 1 ? result[1][1] : result[1]}"),
                int.parse(age.text),
                currGender
              ])),
    );
  }

  void showResult(BuildContext context) {
    resetBorder();
    if (weight.text.isNotEmpty && age.text.isNotEmpty ||
        (height.text.isNotEmpty ||
            (feet.text.isNotEmpty && inches.text.isNotEmpty))) {
      var result = calculateScore();
      goToResult(context, result);
    } else {
      setState(() {
        _isError = true;
      });
    }
  }

  void resetBorder([String newValue = ""]) {
    setState(() {
      weight = weight;
      height = height;
      feet = feet;
      inches = inches;
      age = age;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffC6CCCC),
      appBar: null,
      body: SafeArea(
        child: Center(
          child: ScrollConfiguration(
            behavior: MyBehavior(),
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.all(20.0),
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: Text(
                        "Body Mass Index\nCalculator",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.w500,
                          fontSize: 32,
                          color: Color(0xff322E2E),
                          shadows: [
                            Shadow(
                              color: Colors.black.withOpacity(0.3),
                              offset: Offset(0, 4),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 60),
                    Container(
                      width: 302,
                      height: 320,
                      decoration: BoxDecoration(
                          color: Color(0xffC3C5C5),
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 4,
                              offset: Offset(0, 4),
                            ),
                          ]),
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              IconButton(
                                onPressed: () {
                                  createDialog(context);
                                },
                                icon: Icon(
                                  Icons.settings,
                                  color: Color(0xffEEEEEE),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "Weight",
                            style: TextStyle(
                              fontFamily: "Roboto",
                              fontSize: 20,
                              color: Color(0xff322E2E),
                            ),
                          ),
                          SizedBox(height: 5),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: _isError && weight.text.isEmpty
                                    ? Colors.red
                                    : Colors.black,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  blurRadius: 4,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            width: 200,
                            height: 40,
                            child: TextField(
                              controller: weight,
                              onChanged: resetBorder,
                              keyboardType: TextInputType.numberWithOptions(
                                  decimal: true),
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'(^\d*\.?\d*)'))
                              ],
                              decoration: InputDecoration(
                                fillColor: Color(0xffF1F1F1),
                                filled: true,
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                contentPadding: EdgeInsets.only(
                                  left: 10,
                                  top: 5,
                                ),
                                suffixIcon: Padding(
                                  padding: EdgeInsets.only(
                                    top: 10,
                                    left: 25,
                                  ),
                                  child: Text(currMeasurement == "Metric"
                                      ? "kg"
                                      : "lb"),
                                ),
                                hintText: "Enter your weight",
                              ),
                              autofocus: false,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Height",
                            style: TextStyle(
                              fontFamily: "Roboto",
                              fontSize: 20,
                              color: Color(0xff322E2E),
                            ),
                          ),
                          SizedBox(height: 5),
                          currMeasurement == "Metric"
                              ? Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: _isError && height.text.isEmpty
                                          ? Colors.red
                                          : Colors.black,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.3),
                                        blurRadius: 4,
                                        offset: Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  width: 200,
                                  height: 40,
                                  child: TextField(
                                    controller: height,
                                    onChanged: resetBorder,
                                    keyboardType:
                                        TextInputType.numberWithOptions(
                                            decimal: true),
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r'(^\d*\.?\d*)'))
                                    ],
                                    decoration: InputDecoration(
                                      fillColor: Color(0xffF1F1F1),
                                      filled: true,
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                      contentPadding: EdgeInsets.only(
                                        left: 10,
                                        top: 5,
                                      ),
                                      suffixIcon: Padding(
                                        padding: EdgeInsets.only(
                                          top: 10,
                                          left: 20,
                                        ),
                                        child: Text("cm"),
                                      ),
                                      hintText: "Enter your height",
                                    ),
                                    autofocus: false,
                                  ),
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: _isError && feet.text.isEmpty
                                              ? Colors.red
                                              : Colors.black,
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.3),
                                            blurRadius: 4,
                                            offset: Offset(0, 4),
                                          ),
                                        ],
                                      ),
                                      width: 90,
                                      height: 40,
                                      child: TextField(
                                        controller: feet,
                                        onChanged: resetBorder,
                                        keyboardType:
                                            TextInputType.numberWithOptions(
                                                decimal: true),
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(
                                              RegExp(r'(^\d*\.?\d*)'))
                                        ],
                                        decoration: InputDecoration(
                                          fillColor: Color(0xffF1F1F1),
                                          filled: true,
                                          border: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                          errorBorder: InputBorder.none,
                                          disabledBorder: InputBorder.none,
                                          contentPadding: EdgeInsets.only(
                                            left: 10,
                                            top: 5,
                                          ),
                                          suffixIcon: Padding(
                                            padding: EdgeInsets.only(
                                              top: 10,
                                              left: 20,
                                            ),
                                            child: Text("ft"),
                                          ),
                                          hintText: "feet",
                                        ),
                                        autofocus: false,
                                      ),
                                    ),
                                    SizedBox(width: 20),
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: _isError && inches.text.isEmpty
                                              ? Colors.red
                                              : Colors.black,
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.3),
                                            blurRadius: 4,
                                            offset: Offset(0, 4),
                                          ),
                                        ],
                                      ),
                                      width: 90,
                                      height: 40,
                                      child: TextField(
                                        controller: inches,
                                        onChanged: resetBorder,
                                        keyboardType:
                                            TextInputType.numberWithOptions(
                                                decimal: true),
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(
                                              RegExp(r'(^\d*\.?\d*)'))
                                        ],
                                        decoration: InputDecoration(
                                          fillColor: Color(0xffF1F1F1),
                                          filled: true,
                                          border: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                          errorBorder: InputBorder.none,
                                          disabledBorder: InputBorder.none,
                                          contentPadding: EdgeInsets.only(
                                            left: 10,
                                            top: 5,
                                          ),
                                          suffixIcon: Padding(
                                            padding: EdgeInsets.only(
                                              top: 10,
                                              left: 20,
                                            ),
                                            child: Text("in"),
                                          ),
                                          hintText: "inch",
                                        ),
                                        autofocus: false,
                                      ),
                                    )
                                  ],
                                ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Text(
                                    "Age",
                                    style: TextStyle(
                                      fontFamily: "Roboto",
                                      fontSize: 20,
                                      color: Color(0xff322E2E),
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: _isError && age.text.isEmpty
                                            ? Colors.red
                                            : Colors.black,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.3),
                                          blurRadius: 4,
                                          offset: Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                    width: 90,
                                    height: 40,
                                    child: TextField(
                                      controller: age,
                                      onChanged: resetBorder,
                                      keyboardType:
                                          TextInputType.numberWithOptions(
                                              decimal: true),
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                            RegExp(r'(^\d*\.?\d*)'))
                                      ],
                                      decoration: InputDecoration(
                                        fillColor: Color(0xffF1F1F1),
                                        filled: true,
                                        border: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        errorBorder: InputBorder.none,
                                        disabledBorder: InputBorder.none,
                                        contentPadding: EdgeInsets.only(
                                          left: 10,
                                          top: 5,
                                        ),
                                        suffixIcon: Padding(
                                          padding: EdgeInsets.only(
                                            top: 10,
                                            left: 15,
                                          ),
                                          child: Text("year"),
                                        ),
                                        hintText: "age",
                                      ),
                                      autofocus: false,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(width: 20),
                              Column(
                                children: [
                                  Text(
                                    "Gender",
                                    style: TextStyle(
                                      fontFamily: "Roboto",
                                      fontSize: 20,
                                      color: Color(0xff322E2E),
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Color(0xffF1F1F1),
                                      border: Border.all(color: Colors.black),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.3),
                                          blurRadius: 4,
                                          offset: Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                    width: 90,
                                    height: 40,
                                    child: DropdownButton(
                                      isExpanded: true,
                                      underline: SizedBox(),
                                      value: currGender,
                                      icon: Icon(Icons.keyboard_arrow_down),
                                      iconSize: 16,
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          currGender = newValue!;
                                          if (newValue == "Male") {
                                            genders[1] = "Female";
                                            genders[0] = "Male";
                                          } else {
                                            genders[1] = "Male";
                                            genders[0] = "Female";
                                          }
                                        });
                                      },
                                      items: genders
                                          .map<DropdownMenuItem<String>>(
                                              (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                10, 0, 0, 0),
                                            child: Text(value),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 40),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 4,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: SizedBox(
                        width: 120,
                        height: 45,
                        child: TextButton(
                          child: Text(
                            "Calculate",
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Roboto",
                              fontSize: 16,
                            ),
                          ),
                          onPressed: () => showResult(context),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              Color(0xffECECEC),
                            ),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: BorderSide(color: Color(0xff322E2E)),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
