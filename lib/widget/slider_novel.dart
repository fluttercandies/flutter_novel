import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class SliderNovel extends StatefulWidget {
  SliderNovel(
      {super.key,
      this.min = 10.0,
      this.max = 30.0,
      required this.value,
      required this.onChanged});
  late double min;
  late double max;
  late double value;
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
              primary: Colors.red,
              seedColor: const Color.fromARGB(255, 0, 140, 255))),
      child: SfSlider(
        min: widget.min,
        max: widget.max,
        value: widget.value,
        interval: 20,
        stepSize: 1,
        showTicks: true,
        showLabels: true,
        enableTooltip: true,
        activeColor: Colors.red,
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
