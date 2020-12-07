import 'package:calendarro/calendarro.dart';
import 'package:calendarro/date_utils.dart';
import 'package:flutter/material.dart';

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  @override
  Widget build(BuildContext context) {
    var startDate = DateUtils.getFirstDayOfCurrentMonth();
    var endDate = DateUtils.getLastDayOfNextMonth();
    var monthCalendarro = Calendarro(
        startDate: startDate,
        endDate: endDate,
        displayMode: DisplayMode.MONTHS,
        selectionMode: SelectionMode.MULTI,
        weekdayLabelsRow: CustomWeekdayLabelsRow(),
        onTap: (date) {
          print("onTap: $date");
        });

    return Column(
      children: <Widget>[
        SizedBox(
          height: 10.0,
        ),
        Text("CALENDAR",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 24.0,
            )),
        SizedBox(
          height: 10.0,
        ),
        Container(
          color: Colors.deepOrangeAccent,
          child: Calendarro(),
        ),
        Container(height: 40.0),
        monthCalendarro
      ],
    );
  }
}

class CustomWeekdayLabelsRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(child: Text("M", textAlign: TextAlign.center)),
        Expanded(child: Text("T", textAlign: TextAlign.center)),
        Expanded(child: Text("W", textAlign: TextAlign.center)),
        Expanded(child: Text("T", textAlign: TextAlign.center)),
        Expanded(child: Text("F", textAlign: TextAlign.center)),
        Expanded(child: Text("S", textAlign: TextAlign.center)),
        Expanded(child: Text("S", textAlign: TextAlign.center)),
      ],
    );
  }
}
