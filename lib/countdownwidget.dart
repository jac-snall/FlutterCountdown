import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CountdownWidget extends StatefulWidget {
  CountdownWidget({Key? key, required this.eventTime, required this.eventName})
      : super(key: key);

  final DateTime eventTime;
  final String eventName;

  @override
  _CountdownWidgetState createState() => _CountdownWidgetState();
}

class _CountdownWidgetState extends State<CountdownWidget> {
  late Timer _timer;
  int days = 0, hours = 0, minutes = 0, seconds = 0;

  //Overrides init state for adding a timer
  @override
  void initState() {
    _timer = Timer.periodic(Duration(microseconds: 100), (timer) {
      _updateCountdown();
    });

    super.initState();
  }

  //Dispose timer
  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _updateCountdown() {
    setState(() {
      var secondsBetween =
          widget.eventTime.difference(DateTime.now()).inSeconds;
      if (secondsBetween > 0) {
        days = secondsBetween ~/ (60 * 60 * 24);
        hours = secondsBetween ~/ (60 * 60) - 24 * days;
        minutes = secondsBetween ~/ 60 - 24 * 60 * days - 60 * hours;
        seconds = secondsBetween -
            24 * 60 * 60 * days -
            60 * 60 * hours -
            60 * minutes;
      } else {
        days = hours = minutes = seconds = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(
      fontSize: 38,
      color: Colors.blueGrey,
    );

    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).primaryColorLight,
        boxShadow: [
          BoxShadow(
            color: Color(0x9904589A),
            offset: Offset(7, 7),
            blurRadius: 6,
          )
        ],
      ),
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            width: 0.8 * MediaQuery.of(context).size.width,
            child: Text(
              widget.eventName,
              style: textStyle,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text(
                      '$days',
                      style: textStyle,
                    ),
                    Text('days'),
                  ],
                ),
                VerticalDivider(
                  thickness: 1,
                  color: Colors.black,
                ),
                Column(
                  children: [
                    Text(
                      '$hours',
                      style: textStyle,
                    ),
                    Text('hours'),
                  ],
                ),
                VerticalDivider(
                  thickness: 1,
                  color: Colors.black,
                ),
                Column(
                  children: [
                    Text(
                      '$minutes',
                      style: textStyle,
                    ),
                    Text('minutes'),
                  ],
                ),
                VerticalDivider(
                  thickness: 1,
                  color: Colors.black,
                ),
                Column(
                  children: [
                    Text(
                      '$seconds',
                      style: textStyle,
                    ),
                    Text('seconds'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
