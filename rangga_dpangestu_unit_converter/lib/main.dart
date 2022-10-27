import 'dart:developer';

import 'package:flutter/material.dart';

void main(List<String> args) => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late double _numberFrom;

  static const String weight = 'Weight';
  static const String lenght = 'Lenght';
  static const String temp = 'Temp';

  final List<String> _measuresCategory = [
    weight,
    lenght,
    temp,
  ];

  late Map<String, int> _measuresMap = {};

  final Map<String, int> _measuresMapLenght = {
    'meters': 0,
    'kilometers': 1,
    'feet': 2,
    'miles': 3,
  };
  final Map<String, int> _measuresMapWeight = {
    'grams': 0,
    'kilograms': 1,
    'pound (lbs)': 2,
    'ounces': 3,
  };

  final Map<String, int> _measuresMapTemp = {
    'Celcius': 0,
    'Reamur': 1,
  };

  late dynamic _formulas;

  final dynamic _formulasWeight = {
    '0': [1, 0.0001, 0.0022, 0.03527], //grams
    '1': [1000, 1, 2.20462, 35.274], //kilograms
    '2': [453.592, 0.45359, 1, 16], //pound
    '3': [28.3495, 0.02835, 0.625, 1], // ounces
  };
  final dynamic _formulasLenght = {
    '0': [1, 0.0001, 3.28084, 0.00062], //meters
    '1': [1000, 1, 3280.84, 0.62137], //kilometers
    '2': [0.3048, 0.0003, 1, 0.00019], //feet
    '3': [1609.34, 1.60934, 5280, 1], //miles
  };
  final dynamic _formulasTemp = {
    '0': [1, 0.8],
    '1': [1.25, 1],
  };

  late String _resultMessage;

  final TextStyle inputStyle =
      const TextStyle(fontSize: 16, color: Colors.blueAccent);
  final TextStyle labelStyle =
      const TextStyle(fontSize: 20, color: Colors.black);
  final TextStyle buttonStyle = const TextStyle(
      fontSize: 20, color: Colors.black, backgroundColor: Colors.blueAccent);

  late List<String> _measures = [];

  final List<String> _measuresWeight = [
    'Grams',
    'Kilograms',
    'Pound (lbs)',
    'Ounces',
  ];

  final List<String> _measuresLenght = [
    'Meters',
    'Kilometers',
    'Feet',
    'Miles',
  ];

  final List<String> _measuresTemp = [
    'Celcius',
    'Reamur',
  ];

  late String _startMeasures;
  late String _convertMeasures;
  late String _selectedMeasuresCategory;

  @override
  void initState() {
    _numberFrom = 0;
    _measures = _measuresLenght;
    _startMeasures = _measures[0];
    _convertMeasures = _measures[0];
    _selectedMeasuresCategory = _measuresCategory[1];
    _measuresMap = _measuresMapLenght;
    _formulas = _formulasLenght;
    _resultMessage = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Measures Converter Title',
      home: Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: const Text(
              'Measures Converter',
            )),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                //const Spacer()
                const SizedBox(height: 20),
                Text('Value', style: labelStyle),
                const SizedBox(height: 10),
                //const Spacer(),
                TextField(
                  style: inputStyle,
                  decoration: const InputDecoration(
                      hintText: 'Insert the value you want to convert',
                      hintStyle: TextStyle(fontSize: 16, color: Colors.grey)),
                  onChanged: (text) {
                    var rv = double.tryParse(text);
                    if (rv != null) {
                      log(_numberFrom.toString());
                      setState(() {
                        _numberFrom = rv;
                      });
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Categories',
                  style: labelStyle,
                ),

                DropdownButton(
                    style: inputStyle,
                    items: _measuresCategory.map((String value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    value: _selectedMeasuresCategory,
                    onChanged: (value) {
                      setState(() {
                        _selectedMeasuresCategory = value.toString();
                        switch (value.toString()) {
                          case weight:
                            _measures = _measuresWeight;
                            _measuresMap = _measuresMapWeight;
                            _formulas = _formulasWeight;

                            break;
                          case lenght:
                            _measures = _measuresLenght;
                            _measuresMap = _measuresMapLenght;
                            _formulas = _formulasLenght;

                            break;
                          case temp:
                            _measures = _measuresTemp;
                            _measuresMap = _measuresMapTemp;
                            _formulas = _formulasTemp;

                            break;
                          default:
                        }
                        _startMeasures = _measures[0];
                        _convertMeasures = _measures[0];
                      });
                    }),

                const SizedBox(
                  height: 20,
                ),
                Text(
                  'From',
                  style: labelStyle,
                ),
                DropdownButton(
                    style: inputStyle,
                    items: _measures.map((String value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    value: _startMeasures,
                    onChanged: (value) {
                      setState(() {
                        _startMeasures = value.toString();
                      });
                    }),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () => switchSatuan(), child: const Text('↕️')),
                const SizedBox(
                  height: 20,
                ),

                Text(
                  'To',
                  style: labelStyle,
                ),
                DropdownButton(
                    style: inputStyle,
                    items: _measures.map((String value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    value: _convertMeasures,
                    onChanged: (value) {
                      setState(() {
                        _convertMeasures = value.toString();
                      });
                    }),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: TextButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 211, 211, 211),
                      primary: Colors.blueAccent),
                  child: const Text('Convert🗂️'),
                  onPressed: () {
                    if (_startMeasures.isEmpty ||
                        _convertMeasures.isEmpty ||
                        _numberFrom == 0) {
                      return;
                    } else {
                      convert(_numberFrom, _startMeasures, _convertMeasures);
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  _resultMessage.toString(),
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //value = nilai yang dimasukkan user
  // tahapan logic
  void convert(double value, String from, String to) {
    int? nFrom = _measuresMap[from];
    int? nTo = _measuresMap[to];
    var multiplier = _formulas[nFrom.toString()][nTo];
    var result = value * multiplier;

    if (result == 0) {
      //operasi tidak dapat dilakukan
      _resultMessage = 'This action cannot be perfomed';
    } else {
      _resultMessage = '$value  $from are $result $to';
    }
    setState(() {
      _resultMessage = _resultMessage;
    });
  }

  //logika switch list array
  void switchSatuan() {
    String temp = _startMeasures;
    setState(() {
      _startMeasures = _convertMeasures;
      _convertMeasures = temp;
    });
    if (_startMeasures.isEmpty ||
        _convertMeasures.isEmpty ||
        _numberFrom == 0) {
      return;
    } else {
      convert(_numberFrom, _startMeasures, _convertMeasures);
    }
  }
}
