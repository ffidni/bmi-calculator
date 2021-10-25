import 'package:flutter/material.dart';

class ResultScreen extends StatefulWidget {
  final data;
  ResultScreen(this.data);

  @override
  _ResultScreenState createState() => _ResultScreenState(data);
}

class _ResultScreenState extends State<ResultScreen> {
  final data;
  List bmiRanges1 = ["Underweight", "Ideal Weight", "Overweight", "Obese"];
  List bmiRanges2 = [];
  String result = "";
  bool isUnderTwenty = false;

  _ResultScreenState(this.data);

  void calculateResult(List ranges) {
    if (data[0] < ranges[0]) {
      result = "Underweight";
    } else if (data[0] > ranges[0] && data[0] < ranges[1]) {
      result = "Ideal Weight";
    } else if (data[0] > ranges[1] && data[0] < ranges[2]) {
      result = "Overweight";
    } else {
      result = "Obese";
    }
    bmiRanges2.add("less than ${ranges[0]}");
    bmiRanges2.add("${ranges[0]} - ${ranges[1]}");
    bmiRanges2.add("${ranges[1]} - ${ranges[2]}");
    bmiRanges2.add("${ranges[2]}+");
  }

  @override
  void initState() {
    super.initState();
    if (data[1] >= 0 && data[1] <= 20) {
      isUnderTwenty = true;
      switch (data[1]) {
        case 2:
          calculateResult(
              data[2] == "Male" ? [14.8, 18.2, 19.4] : [14.4, 18, 19.2]);
          break;
        case 3:
          calculateResult(
              data[2] == "Male" ? [14.4, 17.4, 18.4] : [14, 17.6, 18.4]);
          break;
        case 4:
          calculateResult(
              data[2] == "Male" ? [14, 17, 17.8] : [13.8, 16.8, 18]);
          break;
        case 5:
          calculateResult(
              data[2] == "Male" ? [13.8, 16.8, 18] : [13.6, 17.8, 18.4]);
          break;
        case 6:
          calculateResult(
              data[2] == "Male" ? [13.8, 17, 18.6] : [13.8, 17.2, 18.8]);
          break;
        case 7:
          calculateResult(
              data[2] == "Male" ? [13.8, 17.6, 19.2] : [13.6, 17.6, 19.6]);
          break;
        case 8:
          calculateResult(
              data[2] == "Male" ? [13.8, 18, 20] : [13.6, 18.6, 20.6]);
          break;
        case 9:
          calculateResult(
              data[2] == "Male" ? [14, 18.8, 21] : [13.8, 19.2, 21.8]);
          break;
        case 10:
          calculateResult(data[2] == "Male" ? [14.2, 19.6, 22] : [14, 20, 23]);
          break;
        case 11:
          calculateResult(
              data[2] == "Male" ? [14.8, 20, 23] : [14.4, 20.8, 24.2]);
          break;
        case 12:
          calculateResult(
              data[2] == "Male" ? [15, 21, 24] : [14.8, 21.8, 25.4]);
          break;
        case 13:
          calculateResult(
              data[2] == "Male" ? [13.6, 22, 25] : [15.8, 22.6, 26.4]);
          break;
        case 14:
          calculateResult(
              data[2] == "Male" ? [16, 22.6, 26] : [15.8, 23.8, 27.2]);
          break;
        case 15:
          calculateResult(
              data[2] == "Male" ? [16.6, 21.6, 25] : [16.4, 24, 28.2]);
          break;
        case 16:
          calculateResult(
              data[2] == "Male" ? [17, 24, 25.6] : [16.8, 24.6, 28.8]);
          break;
        case 17:
          calculateResult(
              data[2] == "Male" ? [17.6, 25, 28] : [17.2, 25.2, 29.6]);
          break;
        case 18:
          calculateResult(
              data[2] == "Male" ? [18.4, 25.6, 29] : [19.6, 25.6, 30.2]);
          break;
        case 19:
          calculateResult(
              data[2] == "Male" ? [18.6, 26.6, 30] : [17.8, 25.8, 30.2]);
          break;
        case 20:
          calculateResult(
              data[2] == "Male" ? [19, 26.6, 30.6] : [17.8, 26.4, 31.8]);
          break;
      }
    } else {
      calculateResult([18.5, 24.9, 31]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffC6CCCC),
      appBar: null,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
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
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xffC3C5C5),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.6),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Your BMI is:\n${data[0]}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: "Roboto",
                        fontSize: 24,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 30),
                    Text(
                      "BMI Ranges for ${isUnderTwenty ? 'Age ${data[1]}' : 'Adult'}",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                      ),
                    ),
                    Divider(
                      color: Colors.black,
                      height: 20,
                      thickness: 1,
                      indent: 25,
                      endIndent: 25,
                    ),
                    Flexible(
                      child: Row(
                        children: <Widget>[
                          Flexible(
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: bmiRanges1.length,
                              itemBuilder: (context, index) {
                                var item = bmiRanges1[index];
                                return Center(
                                  child: Column(
                                    children: [
                                      Text(
                                        item,
                                        style: TextStyle(
                                          fontWeight:
                                              result == bmiRanges1[index]
                                                  ? FontWeight.w600
                                                  : FontWeight.normal,
                                          color: Colors.black,
                                          fontSize: 22,
                                        ),
                                      ),
                                      SizedBox(height: 6),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                          Flexible(
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: bmiRanges2.length,
                              itemBuilder: (context, index) {
                                var item = bmiRanges2[index];
                                return Center(
                                  child: Column(
                                    children: [
                                      Text(
                                        item,
                                        style: TextStyle(
                                          fontWeight:
                                              result == bmiRanges1[index]
                                                  ? FontWeight.w600
                                                  : FontWeight.normal,
                                          color: Colors.black,
                                          fontSize: 22,
                                        ),
                                      ),
                                      SizedBox(height: 6),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 30),
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
                            "Back",
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Roboto",
                              fontSize: 16,
                            ),
                          ),
                          onPressed: () => Navigator.pop(context),
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
