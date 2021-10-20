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
  String currMeasurement = "Metric";

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
                    dropDownState(() {
                      currMeasurement = newValue!;
                      if (newValue == "Metric") {
                        measurements[0] = "Metric";
                        measurements[1] = "Imperial";
                      } else {
                        measurements[0] = "Imperial";
                        measurements[1] = "Metric";
                      }
                    });
                    setState(() {
                      currMeasurement = newValue!;
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
                        ],
                      ),
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
                              keyboardType: TextInputType.numberWithOptions(
                                  decimal: true),
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'(^\d*\.?\d*)'))
                              ],
                              decoration: InputDecoration(
                                fillColor: Color(0xffF1F1F1),
                                filled: true,
                                contentPadding: EdgeInsets.only(
                                  left: 10,
                                  bottom: 40 / 2,
                                ),
                                suffixIcon: Padding(
                                  padding: EdgeInsets.only(
                                    top: 10,
                                    left: 25,
                                  ),
                                  child: Text("kg"),
                                ),
                                border: OutlineInputBorder(),
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
                          Container(
                            decoration: BoxDecoration(
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
                              keyboardType: TextInputType.numberWithOptions(
                                  decimal: true),
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'(^\d*\.?\d*)'))
                              ],
                              decoration: InputDecoration(
                                fillColor: Color(0xffF1F1F1),
                                filled: true,
                                contentPadding: EdgeInsets.only(
                                  left: 10,
                                  bottom: 40 / 2,
                                ),
                                suffixIcon: Padding(
                                  padding: EdgeInsets.only(
                                    top: 10,
                                    left: 20,
                                  ),
                                  child: Text("cm"),
                                ),
                                border: OutlineInputBorder(),
                                hintText: "Enter your height",
                              ),
                              autofocus: false,
                            ),
                          ),
                          SizedBox(height: 10),
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
                              keyboardType: TextInputType.numberWithOptions(
                                  decimal: true),
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'(^\d*\.?\d*)'))
                              ],
                              decoration: InputDecoration(
                                fillColor: Color(0xffF1F1F1),
                                filled: true,
                                contentPadding: EdgeInsets.only(
                                  left: 10,
                                  bottom: 40 / 2,
                                ),
                                suffixIcon: Padding(
                                  padding: EdgeInsets.only(
                                    top: 10,
                                    left: 15,
                                  ),
                                  child: Text("year"),
                                ),
                                border: OutlineInputBorder(),
                                hintText: "Enter your age",
                              ),
                              autofocus: false,
                            ),
                          )
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
                          onPressed: () {},
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
