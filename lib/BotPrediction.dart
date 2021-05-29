import 'package:flutter/material.dart';

enum SoilType { loam, grovel, fraible, clay, red, grey, sandy, yellow }

class CameraDiseasePredictionTab extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController temperatureController = TextEditingController();
  TextEditingController rainfallController = TextEditingController();
  TextEditingController altitudeController = TextEditingController();
  TextEditingController humidityController = TextEditingController();
  SoilType _soilType = SoilType.loam;

  @override
  void dispose() {
    temperatureController.dispose();
    rainfallController.dispose();
    altitudeController.dispose();
    humidityController.dispose();
  }

  Widget TemperatureField() {
    return TextFormField(
      maxLength: 40,
      autofocus: false,
      controller: component1Controller,
      decoration: InputDecoration(
          filled: true,
          icon: Icon(
            Icons.person,
            color: Color(0xFF6F35A5),
          ),
          fillColor: Color(0xFFF1E6FF),
          hintText: 'Enter The Temperature Value :',
          hintStyle: TextStyle(fontSize: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),
          )),
      validator: (String value) {
        if (value
            .trim()
            .isEmpty) {
          return 'Temperature is required';
        }
        return null;
      },
    );
  }

  Widget RainfallField() {
    return TextFormField(
      maxLength: 40,
      autofocus: false,
      controller: rainfallController,
      decoration: InputDecoration(
          filled: true,
          icon: Icon(
            Icons.person,
            color: Color(0xFF6F35A5),
          ),
          fillColor: Color(0xFFF1E6FF),
          hintText: 'Enter The Rainfall Value :',
          hintStyle: TextStyle(fontSize: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),
          )),
      validator: (String value) {
        if (value
            .trim()
            .isEmpty) {
          return 'Rainfall is required';
        }
        return null;
      },
    );
  }

  Widget AltitudeField() {
    return TextFormField(
      maxLength: 40,
      autofocus: false,
      controller: altitudeController,
      decoration: InputDecoration(
          filled: true,
          icon: Icon(
            Icons.person,
            color: Color(0xFF6F35A5),
          ),
          fillColor: Color(0xFFF1E6FF),
          hintText: 'Enter The Altitude Value :',
          hintStyle: TextStyle(fontSize: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),
          )),
      validator: (String value) {
        if (value
            .trim()
            .isEmpty) {
          return 'Altitude is required';
        }
        return null;
      },
    );
  }

  Widget AltitudeField() {
    return TextFormField(
      maxLength: 40,
      autofocus: false,
      controller: altitudeController,
      decoration: InputDecoration(
          filled: true,
          icon: Icon(
            Icons.person,
            color: Color(0xFF6F35A5),
          ),
          fillColor: Color(0xFFF1E6FF),
          hintText: 'Enter The Altitude Value :',
          hintStyle: TextStyle(fontSize: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),
          )),
      validator: (String value) {
        if (value
            .trim()
            .isEmpty) {
          return 'Altitude is required';
        }
        return null;
      },
    );
  }

  Widget HumidityField() {
    return TextFormField(
      maxLength: 40,
      autofocus: false,
      controller: humidityController,
      decoration: InputDecoration(
          filled: true,
          icon: Icon(
            Icons.person,
            color: Color(0xFF6F35A5),
          ),
          fillColor: Color(0xFFF1E6FF),
          hintText: 'Enter The Humidity Value :',
          hintStyle: TextStyle(fontSize: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),
          )),
      validator: (String value) {
        if (value
            .trim()
            .isEmpty) {
          return 'Humidity is required';
        }
        return null;
      },
    );
  }

  Widget SoilTypeRadioField() {
    return Column(
      children: <Widget>[
        ListTile(
          title: const Text(SoilType.grovel),
          leading: Radio(
            value: SoilType.grovel,
            groupValue: _soilType,
            onChanged: (SoilType value) {
              setState(() {
                _soilType = value;
              });
            },
          ),
        ),
        ListTile(
          title: const Text(SoilType.fraible),
          leading: Radio(
            value: SoilType.fraible,
            groupValue: _soilType,
            onChanged: (SoilType value) {
              setState(() {
                _soilType = value;
              });
            },
          ),
        ),
        ListTile(
          title: const Text(SoilType.clay),
          leading: Radio(
            value: SoilType.clay,
            groupValue: _soilType,
            onChanged: (SoilType value) {
              setState(() {
                _soilType = value;
              });
            },
          ),
        )
      ],
    )
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Bot Predict'),
          backgroundColor: Colors.pinkAccent,
        )
        body:Column(
    children: <Widget>[
    TemperatureField(),
    RainfallField(),
    AltitudeField(),
    HumidityField(),
    SoilTypeRadioField()
    ]
    ));
    }
}