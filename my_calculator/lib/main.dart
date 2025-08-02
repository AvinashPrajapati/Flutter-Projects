//main.dart
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:window_manager/window_manager.dart';

const operatorColor = Color(0xff272727);
const buttonColor = Color(0xff191919);
const orangeColor = Color(0xffD9802E);

const double x = 500.0;
const double y = 650.0;



void main() async {
  // Ensure Flutter is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize window manager
  await windowManager.ensureInitialized();

  // Define window options
  WindowOptions windowOptions = const WindowOptions(

    size: Size(x, y),      // Initial window size
    maximumSize: Size(x, y),
    minimumSize: Size(x, y),
    center: true,               // Center the window
  );

  // Apply window settings
  await windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

  // Run the app
  runApp(const MaterialApp(home: CalculatorApp()));
}

String formatOutput(String value) {
  // If the output is a decimal number
  if (value.contains('.')) {
    double numValue = double.parse(value);
    // Check if the decimal is repeating or very long
    String decimalPart = value.split('.')[1];
    if (decimalPart.length > 5) {  // If more than 5 decimal places
      // Round to 5 decimal places
      return numValue.toStringAsFixed(5);
    }
  }
  return value;
}
  
class CalculatorApp extends StatefulWidget {
  const CalculatorApp({super.key});

  @override
  State<CalculatorApp> createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
  //variables
  double firstNum = 0.0;
  double secondNum = 0.0;
  var input = "";
  var output = "";
  var operation = "";
  var hideInput = false;
  var outputSize = 3.0;

  onButtonClick(value){
    // print({input, output});
    if (output.contains("nfinit")) {
        input = "0";
        output = "0";
    }
    if(value == "AC"){
      input = "";
      output = "";
    }else if (value == "<"){
      if (input.isNotEmpty){
        input = input.substring(0,input.length-1);
      }
    }else if (value == "="){
      if (input.isNotEmpty){
        var userInput = input.replaceAll("x", "*");

        ExpressionParser p = GrammarParser();
        Expression expression = p.parse(userInput);

        ContextModel cm = ContextModel();
        var evaluator = RealEvaluator(cm);
        var finalValue = evaluator.evaluate(expression);

        output = finalValue.toString();
        output = formatOutput(output);
        if(output.endsWith(".0")){
          output = output.substring(0,output.length-2);
        }

        // if (!output.contains("nfinit")) {
          input = output;
          hideInput = true;
          outputSize = 52;
        // }
        
      }
    }else{
      // if (!output.contains("nfinit")) {
        input = input + value;
        hideInput = false;
        outputSize = 34;
      // }
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
        //input output area
        Expanded(child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                hideInput ? "" : input,
                style: TextStyle(
                  fontSize: 48,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                output,
                style: TextStyle(
                  fontSize: outputSize,
                  color: Colors.white.withValues(alpha: 0.7),
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
            ),
          )),
        //buttons area
        Row(
          children: [
            button(text: "AC", buttonBgColor: operatorColor, tColor: orangeColor),
            button(text: "<", buttonBgColor: operatorColor, tColor: orangeColor),
            button(text: "^", buttonBgColor: operatorColor, tColor: orangeColor),
            button(text: "/", buttonBgColor: operatorColor, tColor: orangeColor),
          ],
        ),
        Row(
          children: [
            button(text: "7"),
            button(text: "8"),
            button(text: "9"),
            button(text: "x", tColor: orangeColor, buttonBgColor: operatorColor),
          ],
        ),
        Row(
          children: [
            button(text: "4"),
            button(text: "5"),
            button(text: "6"),
            button(text: "-", tColor: orangeColor, buttonBgColor: operatorColor),
          ],
        ),
        Row(
          children: [
            button(text: "1"),
            button(text: "2"),
            button(text: "3"),
            button(text: "+", tColor: orangeColor, buttonBgColor: operatorColor),
          ],
        ),
        Row(
          children: [
            button(text: "%", tColor: orangeColor, buttonBgColor: operatorColor),
            button(text: "0"),
            button(text: "."),
            button(text: "=", buttonBgColor: orangeColor),
          ],
        ),
      ]),
    );
  }

  Widget button({
    text, tColor = Colors.white, buttonBgColor = buttonColor
  }){
    return Expanded(
              child: Container(
                margin: const EdgeInsets.all(8),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    backgroundColor: buttonColor,
                  ),
                  onPressed: () => onButtonClick(text),
                  child: Text(
                    text,
                    style: TextStyle(
                      fontSize: 35,
                      color: tColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ),
              ),
            );
  }

}