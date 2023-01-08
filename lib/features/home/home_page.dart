import 'package:arithmetic_app/common/bases/base_widget.dart';
import 'package:arithmetic_app/data/datasources/remote/api_request.dart';
import 'package:arithmetic_app/data/repositories/home_repository.dart';
import 'package:arithmetic_app/features/home/home_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home_event.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return PageContainer(

        child: _HomeContainer(),
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

class _HomeContainer extends StatefulWidget {
  const _HomeContainer({Key? key}) : super(key: key);
  @override
  State<_HomeContainer> createState() => _HomeContainerState();
}

class _HomeContainerState extends State<_HomeContainer> {
  late HomeBloc _bloc;
  late DateTime _birthday;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc = context.read();
    _birthday =DateTime(1990);
  }
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/home-background.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child:  Container(
          width: MediaQuery.of(context).size.width*0.8,
          height: MediaQuery.of(context).size.height*0.4,
          decoration: BoxDecoration(
            border: Border.all(
              color:Colors.grey,
              width: 2,
            ),
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Colors.grey[300],
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(child: Center(child: Text("Title",
                textAlign: TextAlign.center,style: TextStyle(fontSize: 20),maxLines: 2,),)),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(onPressed: (){
                        _bloc.eventSink.add(ChoosingDateTypeEvent());
                        Navigator.pushNamed(context, "date-page");
                      }, child: Text("Date")),
                      ElevatedButton(onPressed: (){
                        _bloc.eventSink.add(ChoosingNameTypeEvent());
                        Navigator.pushNamed(context, "name-page");
                      }, child: Text("Name")),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget DatePicker(){
    final days = List.generate(31, (i) => i + 1);
    final months = [      'January',      'February',      'March',      'April',      'May',      'June',      'July',      'August',      'September',      'October',      'November',      'December',    ];
    final years = List.generate(100, (i) => 2020 - i);

    return Column(
      children: [
        Expanded(
          child: CupertinoPicker(
            backgroundColor: CupertinoColors.white,
            itemExtent: 32,
            onSelectedItemChanged: (index) {
              print(days[index]);
            },
            children: days.map((day) => Text(day.toString())).toList(),
          ),
        ),
        Expanded(
          child: CupertinoPicker(
            backgroundColor: CupertinoColors.white,
            itemExtent: 32,
            onSelectedItemChanged: (index) {
              print(months[index]);
            },
            children: months.map((month) => Text(month)).toList(),
          ),
        ),
        Expanded(
          child: CupertinoPicker(
            backgroundColor: CupertinoColors.white,
            itemExtent: 32,
            onSelectedItemChanged: (index) {
              print(years[index]);
            },
            children: years.map((year) => Text(year.toString())).toList(),
          ),
        ),
      ],
    );
  }
}





