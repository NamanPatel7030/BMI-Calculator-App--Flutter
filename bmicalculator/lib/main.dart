import 'package:flutter/material.dart';

void main() {
  runApp(BMICalculatorApp());
}

class BMICalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BMI Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BMICalculator(),
    );
  }
}

class BMICalculator extends StatefulWidget {
  @override
  _BMICalculatorState createState() => _BMICalculatorState();
}

class _BMICalculatorState extends State<BMICalculator> {
  double _height = 1.7; // in meters
  double _weight = 60; // in kg
  String _result = "";

  void calculateBMI() {
    final bmi = _weight / (_height * _height);
    String category;
    if (bmi < 18.5) {
      category = "Underweight";
    } else if (bmi < 24.9) {
      category = "Normal weight";
    } else if (bmi < 29.9) {
      category = "Overweight";
    } else {
      category = "Obesity";
    }
    setState(() {
      _result = "Your BMI is ${bmi.toStringAsFixed(1)}\nCategory: $category";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI Calculator'),
        centerTitle: true,
        elevation: 5,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade200, Colors.blue.shade700],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "BMI Calculator",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 20),
                _buildSlider("Height (m)", _height, 1.0, 2.5, (value) {
                  setState(() => _height = value);
                }),
                SizedBox(height: 20),
                _buildSlider("Weight (kg)", _weight, 30, 150, (value) {
                  setState(() => _weight = value);
                }),
                SizedBox(height: 30),
                ElevatedButton(
  style: ElevatedButton.styleFrom(
    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30),
    ),
    backgroundColor: Colors.white, // Use backgroundColor instead of primary
  ),
  onPressed: calculateBMI,
  child: Text(
    "Calculate BMI",
    style: TextStyle(fontSize: 18, color: Colors.blue),
  ),
),
                SizedBox(height: 20),
                if (_result.isNotEmpty)
                  Card(
                    margin: EdgeInsets.all(16),
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        _result,
                        style: TextStyle(fontSize: 20, color: Colors.blue),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSlider(
    String label,
    double value,
    double min,
    double max,
    ValueChanged<double> onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$label: ${value.toStringAsFixed(2)}",
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
        Slider(
          value: value,
          min: min,
          max: max,
          divisions: (max - min) ~/ 0.1,
          label: value.toStringAsFixed(2),
          activeColor: Colors.white,
          inactiveColor: Colors.white54,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
