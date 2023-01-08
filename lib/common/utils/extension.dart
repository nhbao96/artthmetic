import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/single_child_widget.dart';

void showMessage(
    [BuildContext? context,
    String? title,
    String? message,
    List<Widget>? actionsAlert]) {
  if (context == null) return;
  var actionAlignment = (actionsAlert?.length == 1)
      ? MainAxisAlignment.end
      : MainAxisAlignment.center;
  showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: (title == null || title.isEmpty) ? null : Text(title),
        content: (message == null || message.isEmpty) ? null : Text(message),
        actions: actionsAlert,
        actionsAlignment: actionAlignment,
      );
    },
  );
}

void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
}

bool isNotEmpty(List<String> data) {
  for (int i = 0; i < data.length; i++) {
    if (data[i].isEmpty) {
      return false;
    }
  }
  return true;
}

String convertToMoney(int value) {
  String result =
      NumberFormat.currency(locale: 'eu', symbol: 'VND', decimalDigits: 0)
          .format(value);
  return result;
}

int sumOfDigits(int number) {
  int sum = 0;
  int num = number;
  while (num > 0) {
    sum += num % 10;
    num = num ~/ 10;
  }
  return sum;
}

bool isDateValid(int selectedDay, int selectedMonth, int selectedYear) {
  if (selectedMonth == 2) {
    // Check if the selected year is a leap year
    if (selectedYear % 4 == 0) {
      // Leap year
      return selectedDay <= 29;
    } else {
      // Non-leap year
      return selectedDay <= 28;
    }
  } else if (selectedMonth == 4 ||
      selectedMonth == 6 ||
      selectedMonth == 9 ||
      selectedMonth == 11) {
    return selectedDay <= 30;
  } else {
    return selectedDay <= 31;
  }
}

int convertMonthStringToNum(String month) {
  int result = 0;
  if (month == 'January') {
    result = 1;
  } else if (month == 'February') {
    result = 2;
  } else if (month == 'March') {
    result = 3;
  } else if (month == 'April') {
    result = 4;
  } else if (month == 'May') {
    result = 5;
  } else if (month == 'June') {
    result = 6;
  } else if (month == 'July') {
    result = 7;
  } else if (month == 'August') {
    result = 8;
  } else if (month == 'September') {
    result = 9;
  } else if (month == 'October') {
    result = 10;
  } else if (month == 'November') {
    result = 11;
  } else if (month == 'December') {
    result = 12;
  }
  return result;
}

int getLetterValueInMap(String letter) {
  int result = 0;
  switch (letter) {
    case 'A':
      result = 1;
      break;
    case 'J':
      result = 1;
      break;
    case 'S':
      result = 1;
      break;
    case 'B':
      result = 2;
      break;
    case 'K':
      result = 2;
      break;
    case 'T':
      result = 2;
      break;
    case 'C':
      result = 3;
      break;
    case 'L':
      result = 3;
      break;
    case 'U':
      result = 3;
      break;
    case 'D':
      result = 4;
      break;
    case 'M':
      result = 4;
      break;
    case 'V':
      result = 4;
      break;
    case 'E':
      result = 5;
      break;
    case 'N':
      result = 5;
      break;
    case 'W':
      result = 5;
      break;
    case 'F':
      result = 6;
      break;
    case 'O':
      result = 6;
      break;
    case 'X':
      result = 6;
      break;
    case 'G':
      result = 7;
      break;
    case 'P':
      result = 7;
      break;
    case 'Y':
      result = 7;
      break;
    case 'H':
      result = 8;
      break;
    case 'Q':
      result = 8;
      break;
    case 'Z':
      result = 8;
      break;
    case 'I':
      result = 9;
      break;
    case 'R':
      result = 9;
      break;
    default:
      break;
  }
  print("getLetterValueInMap letter : $letter , value : $result");
  return result;
}

int converNameToInt(String name) {
  int result = 0;
  for (int i = 0; i < name.length; i++) {
    result += getLetterValueInMap((name[i]));
  }
  return result;
}
