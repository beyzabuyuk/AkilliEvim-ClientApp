import 'package:flutter/material.dart';

import '../starting.dart';

class AlarmModel {
  final String name;
  final String image;
  final Operation operation;
  final Device device;

  AlarmModel({
    @required this.name,
    @required this.image,
    @required this.operation,
    @required this.device,
  });
}
