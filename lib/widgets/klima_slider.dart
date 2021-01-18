import 'package:flutter/material.dart';
import 'package:my_smart_home/modeller/klima_model.dart';

class KlimaSlider extends StatefulWidget {
  @override
  _KlimaSliderState createState() => _KlimaSliderState();
}

class _KlimaSliderState extends State<KlimaSlider> {
  int value = 10;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            valueIndicatorColor: Colors.transparent,
            activeTrackColor: Colors.black87,
            inactiveTrackColor: Colors.grey[200],
            //showValueIndicator: ShowValueIndicator.onlyForDiscrete,
            valueIndicatorTextStyle: TextStyle(color: Colors.green),
            trackShape: RectangularSliderTrackShape(),
            trackHeight: 4.0,
            thumbColor: Colors.white,
            thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.0),
            overlayColor: Colors.white38,
            overlayShape: RoundSliderOverlayShape(overlayRadius: 20.0),
          ),
          child: Slider(
              value: value.toDouble(),
              min: 10,
              max: 30,
              label: '${value.toInt()}°',
              divisions: 30,
              onChanged: (val) {
                value = val.toInt();
                setState(() {
                  value = value;
                  KlimaModel.degree = value;
                });
              }),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '10°',
                style: TextStyle(color: Colors.grey),
              ),
              Text(
                '30°',
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
