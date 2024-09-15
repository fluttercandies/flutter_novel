// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class SliderNovel extends StatefulWidget {
  SliderNovel(
      {super.key,
      this.min = 10.0,
      this.max = 40.0,
      required this.value,
      required this.onChanged,
      required this.color});
  late double min;
  late double max;
  late double value;
  late Color color;
  late Function(dynamic)? onChanged;
  @override
  State<SliderNovel> createState() => _SliderNovelState();
}

class _SliderNovelState extends State<SliderNovel> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              primary: widget.color, seedColor: widget.color)),
      child: SfSlider(
        min: widget.min,
        max: widget.max,
        value: widget.value,
        interval: 20,
        stepSize: 1,
        showTicks: true,
        showLabels: true,
        enableTooltip: true,
        activeColor: widget.color,
        inactiveColor: Colors.grey.shade300,
        minorTicksPerInterval: 5,
        onChanged: (dynamic value) {
          if (widget.onChanged != null) {
            widget.onChanged!(value);
          }
          widget.value = value;
          setState(() {});
        },
      ),
    );
  }
}
