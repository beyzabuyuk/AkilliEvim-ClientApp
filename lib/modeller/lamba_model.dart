import 'package:flutter/material.dart';

import '../starting.dart';

class LambaModel {
  final String name;
  final String image;
  final Operation operation;
  final Device device;

  LambaModel({
    @required this.name,
    @required this.image,
    @required this.operation,
    @required this.device,
  });
}
