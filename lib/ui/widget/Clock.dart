import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Clock extends StatefulWidget {
  final String landFormat;
  final String portFormat;
  DateFormat landDataFormat;
  DateFormat portDataFormat;

  Clock({this.landFormat = "yyyy-MM-dd kk:mm", this.portFormat = "kk:mm"})
      : super() {
    landDataFormat = DateFormat(landFormat);
    portDataFormat = DateFormat(portFormat);
  }

  @override
  State<Clock> createState() => _ClockState(landDataFormat, portDataFormat);
}

class _ClockState extends State<Clock> {
  final DateFormat landDateFormatter;
  final DateFormat portDateFormatter;
  DateFormat dateformatter;
  Timer clockTimer;
  String timeStr = "";

  _ClockState(this.landDateFormatter, this.portDateFormatter) : super();

  @override
  void initState() {
    super.initState();
    dateformatter = portDateFormatter;
    timeStr = dateformatter.format(DateTime.now());
    clockTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() => timeStr = dateformatter.format(DateTime.now()));
    });
  }

  @override
  void dispose() {
    clockTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    dateformatter = MediaQuery.of(context).orientation == Orientation.landscape
        ? landDateFormatter
        : portDateFormatter;
    return Text(this.timeStr);
  }
}
