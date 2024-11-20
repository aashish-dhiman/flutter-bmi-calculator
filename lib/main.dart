// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "BMI Calculator",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController weightController = TextEditingController();

  final TextEditingController ftHeightController = TextEditingController();

  final TextEditingController inHeightController = TextEditingController();

  String result = "";
  var bgColor = Colors.white12;

  handleBMICalculator() {
    var wt = weightController.text.toString();
    var ft = ftHeightController.text.toString();
    var inch = inHeightController.text.toString();

    if (wt != "" && ft != "" && inch != "") {
      try {
        var iWt = int.parse(wt); // Weight in kilograms
        var iFt = int.parse(ft); // Feet
        var iIn = int.parse(inch); // Inches
        var msg = "";

        // Convert height to meters
        double hMeter = (iFt * 0.3048) + (iIn * 0.0254);

        // Calculate BMI
        double BMI = iWt / pow(hMeter, 2);
        if (BMI > 25) {
          msg = "You are overweight!";
          bgColor = Colors.red.shade500;
        } else if (BMI > 18 && BMI < 25) {
          msg = "You are perfectly fit!";
          bgColor = Colors.green.shade400;
        } else {
          msg = "You are underweight!";
          bgColor = Colors.red.shade500;
        }

        setState(() {
          result =
              "$msg \nYour BMI is: ${BMI.toStringAsFixed(2)}"; // Round to 2 decimals
        });
      } catch (e) {
        setState(() {
          result = "Please enter valid numeric values.";
        });
      }
    } else {
      setState(() {
        result = "Please fill all the required fields";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text("BMI Calculator"),
        ),
        body: Center(
          child: Container(
            color: bgColor,
            width: double.infinity,
            height: double.infinity,
            child: Padding(
              padding: EdgeInsets.only(left: 50, right: 50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Calculate Your BMI",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: weightController,
                    decoration: InputDecoration(
                        label: Text("Enter your weight (in kgs)"),
                        prefixIcon: Icon(Icons.line_weight_outlined),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(width: 2.0),
                        )),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  TextField(
                    controller: ftHeightController,
                    decoration: InputDecoration(
                        label: Text("Enter your height (in feet)"),
                        prefixIcon: Icon(Icons.height),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(width: 2.0),
                        )),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  TextField(
                    controller: inHeightController,
                    decoration: InputDecoration(
                        label: Text("Enter your height (in inch)"),
                        prefixIcon: Icon(Icons.height),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(width: 2.0),
                        )),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  OutlinedButton(
                    onPressed: handleBMICalculator,
                    child: Text("Calculate"),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                          width: 2.0,
                          color: Colors.blue), // Border color and width
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(5), // Rounded corners
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text("$result")
                ],
              ),
            ),
          ),
        ));
  }
}
