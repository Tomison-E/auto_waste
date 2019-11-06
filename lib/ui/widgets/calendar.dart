import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart' show CalendarCarousel;

class Calendar extends StatelessWidget{

  Calendar ( this.current_date ,{this.marked_date, this.selected_date}):
  assert(current_date!=null);

  final DateTime current_date;
  final List<DateTime> marked_date;
  final List<DateTime> selected_date;

  @override
  Widget build(BuildContext context){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      child: CalendarCarousel(
        onDayPressed: (DateTime date) {
          // this.setState(() => _currentDate = date);
        },
        weekendTextStyle: TextStyle(
          color: Colors.red,
        ),
        thisMonthDayBorderColor: Colors.transparent,
//          weekDays: null, /// for pass null when you do not want to render weekDays
      //  headerText: Container( /// Example for rendering custom header
        //  child: Text('PICKUP DAYS'),
        //),
        markedDates: marked_date,
        height: 420.0,
        selectedDateTime: current_date,
        daysHaveCircularBorder: false,
        markedDateWidget: Container(color: Colors.blue,child: Icon(Icons.drive_eta),),
        selectedDayButtonColor: Colors.pink,
        selectedDayBorderColor: Colors.blueGrey,
        

        /// null for not rendering any border, true for circular border, false for rectangular border
      ),
    );
  }

}