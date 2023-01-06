import 'package:arithmetic_app/common/bases/base_widget.dart';
import 'package:arithmetic_app/data/datasources/remote/api_request.dart';
import 'package:arithmetic_app/data/repositories/home_repository.dart';
import 'package:arithmetic_app/features/home/home_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class DateArthmeticPage extends StatefulWidget {
  const DateArthmeticPage({Key? key}) : super(key: key);

  @override
  State<DateArthmeticPage> createState() => _DateArthmeticPageState();
}

class _DateArthmeticPageState extends State<DateArthmeticPage> {
  @override
  Widget build(BuildContext context) {
    return PageContainer(
        appBar: AppBar(title: Text("Date page"),),
        child: _DateArthmeticContainer(),
        providers: [
          Provider<ApiRequest>(create: (context)=>ApiRequest(),),
          ProxyProvider<ApiRequest,HomeRepository>(
              create: (context)=>HomeRepository(),
              update: (context,apiRequest,homeRepository){
                homeRepository?.updateApiRequest(apiRequest);
                return homeRepository!;
              }),
          ProxyProvider<HomeRepository,HomeBloc>(
              create: (context)=>HomeBloc(),
              update: (context,homeRepository,homeBloc){
                homeBloc?.updateHomeRepository(homeRepository);
                return homeBloc!;
              })
        ]);
  }
}

class _DateArthmeticContainer extends StatefulWidget {
  const _DateArthmeticContainer({Key? key}) : super(key: key);
  @override
  State<_DateArthmeticContainer> createState() => _DateArthmeticContainerState();
}

class _DateArthmeticContainerState extends State<_DateArthmeticContainer> {
  late HomeBloc _bloc;

  final days = List.generate(31, (i) => i + 1);
  final months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];
  final years = List.generate(100, (i) => 2022 - i);

  late int _selectedDay;
  late String _selectedMonth;
  late int _selectedYear;

  bool isDateValid(int selectedDay, String selectedMonth, int selectedYear) {
    if (selectedMonth == 'February') {
      // Check if the selected year is a leap year
      if (selectedYear % 4 == 0) {
        // Leap year
        return selectedDay <= 29;
      } else {
        // Non-leap year
        return selectedDay <= 28;
      }
    } else if (selectedMonth == 'April' ||
        selectedMonth == 'June' ||
        selectedMonth == 'September' ||
        selectedMonth == 'November') {
      return selectedDay <= 30;
    } else {
      return selectedDay <= 31;
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc = context.read();
  _selectedDay = 1;
  _selectedMonth = 'January';
  _selectedYear = 2022;
  }
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Text("Vui long chon ngay sinh cua ban : "),
          Container(
            width: MediaQuery.of(context).size.width*0.8,
            height: 70,
            child: Row(
              children: [
                Expanded(
                  child: CupertinoPicker(
                    itemExtent: 32,
                    onSelectedItemChanged: (index) {
                      setState(() {
                        _selectedDay = days[index];
                      });
                    },
                    children: days.map((day) => Text(day.toString(),style: TextStyle(fontSize: 16),)).toList(),
                  ),
                ),
                Expanded(
                  child: CupertinoPicker(

                    itemExtent: 32,
                    onSelectedItemChanged: (index) {
                      setState(() {
                        _selectedMonth = months[index];
                      });
                    },
                    children: months.map((month) => Text(month,style: TextStyle(fontSize: 16))).toList(),
                  ),
                ),
                Expanded(
                  child: CupertinoPicker(
                    itemExtent: 32,
                    onSelectedItemChanged: (index) {
                      setState(() {
                        _selectedYear = years[index];
                      });
                    },
                    children: years.map((year) => Text(year.toString(),style: TextStyle(fontSize: 16))).toList(),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );;
  }
}





