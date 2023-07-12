import 'dart:ui';

import 'package:flutter/material.dart';

class DisplaySize{

  static Size getSize(BuildContext context){
    return MediaQuery.of(context).size;
  }
}