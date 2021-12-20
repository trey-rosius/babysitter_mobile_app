import 'package:intl/intl.dart';
class DateManipulations{

  bool checkLeapYear(int year){
    if(year%4==0)
    {
      if(year%100==0)
      {
        if(year%400==0)
        {
         return true;
        }
        else
        {
          return false;
        }
      }
      else
      {
        return true;
      }
    }
    else
    {
      return false;
    }
  }

String calculateDob(String date,bool leapYear){

    DateTime selectedDate = DateTime.now();
    String datePattern = "yyyy-MM-dd";

    DateTime birthDateObject = DateFormat(datePattern).parse(date);
    print("Birthday "+birthDateObject.toString());

    int birthDate = selectedDate.difference(birthDateObject).inDays;
    print("birth date is "+(birthDate/365).floor().toString());
    if(leapYear)
      {
        return (birthDate/366).floor().toString();
      }else{
      return (birthDate/365).floor().toString();
    }

  }
  DateTime calculateSubscriptionDifference(String date,int subscriptionMonths){

    DateTime selectedDate = DateTime.now();
    String datePattern = "yyyy-MM-dd";

    DateTime endDateObject = DateFormat(datePattern).parse(date);
    print("end date object"+endDateObject.toString());

    int endDate = endDateObject.difference(selectedDate).inDays;
    DateTime newEndDate = DateTime(selectedDate.year,selectedDate.month+subscriptionMonths,selectedDate.day+endDate);
    print("new End date is "+(endDate.toString()));
        return newEndDate;

    }

}

