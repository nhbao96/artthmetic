import 'package:arithmetic_app/common/bases/base_widget.dart';
import 'package:arithmetic_app/common/utils/extension.dart';
import 'package:arithmetic_app/data/datasources/remote/api_request.dart';
import 'package:arithmetic_app/data/repositories/date_repository.dart';
import 'package:arithmetic_app/data/repositories/home_repository.dart';
import 'package:arithmetic_app/features/date_arthmetic/date_bloc.dart';
import 'package:arithmetic_app/features/date_arthmetic/date_event.dart';
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
          ProxyProvider<ApiRequest,DateRepository>(
              create: (context)=>DateRepository(),
              update: (context,apiRequest,dateRepository){
                dateRepository?.updateApiRequest(apiRequest);
                return dateRepository!;
              }),
          ProxyProvider<DateRepository,DateBloc>(
              create: (context)=>DateBloc(),
              update: (context,dateRepository,dateBloc){
                dateBloc?.updateDateRepository(dateRepository);
                return dateBloc!;
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
  late DateBloc _bloc;

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
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(margin: EdgeInsets.symmetric(horizontal: 5,vertical:5), child: Text("Vui lòng lựa chọn ngày sinh của bạn : ",style: TextStyle(fontSize: 18),)),
                  Container(
                    width: MediaQuery.of(context).size.width*0.95,
                    height: 70,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Flexible(
                          child: Container(
                            width: 70,

                            alignment: Alignment.center,
                            child: CupertinoPicker(
                              itemExtent: 20,
                              onSelectedItemChanged: (index) {
                                setState(() {
                                  _selectedDay = days[index];
                                });
                              },
                              children: days.map((day) => Text(day.toString(),textAlign: TextAlign.center, style: TextStyle(fontSize: 16),)).toList(),

                            ),
                          ),
                        ),
                        Flexible(
                          child: Container(
                            width: 100,
                            child: CupertinoPicker(
                              itemExtent: 25,
                              onSelectedItemChanged: (index) {
                                setState(() {
                                  _selectedMonth = months[index];
                                });
                              },
                              children: months.map((month) => Text(month,textAlign: TextAlign.center,style: TextStyle(fontSize: 16))).toList(),
                            ),
                          ),
                        ),
                        Flexible(
                          child: Container(
                            width: 80,
                            child: CupertinoPicker(
                              itemExtent: 25,
                              onSelectedItemChanged: (index) {
                                setState(() {
                                  _selectedYear = years[index];
                                });
                              },
                              children: years.map((year) => Text(year.toString(),textAlign: TextAlign.center,style: TextStyle(fontSize: 16))).toList(),
                            ),
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.only(top: 20),
                            child: ElevatedButton(onPressed: (){
                              int day = _selectedDay;
                              int month = convertMonthStringToNum(_selectedMonth);
                              int year = _selectedYear;
                              if(isDateValid(day, month, year) == true){
                                _bloc.eventSink.add(ClickConfirmBtnEvent(day, month, year));
                              }else{
                                showMessage(context, "Ngày sinh của bạn chưa hợp lệ!, vui lòng thực hiện lại");
                              }
                            }, child: Text("Confirm")))
                      ],
                    ),
                  ),
                  Container(
                      margin : EdgeInsets.only(top: 20),
                      child: StreamBuilder<int>(
                    stream: _bloc.streamController.stream,
                    builder: (context,snapshot){
                      if(snapshot.hasError || snapshot.data == null){
                        return Container();
                      }
                      return Text("Con số chủ đạo của bạn là : ${snapshot.data}", style: TextStyle(fontSize: 20));
                    },
                  ))
                ],
              ),
            )
          ],
        ),
      ),
    );;
  }
}





