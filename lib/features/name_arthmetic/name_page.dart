import 'package:arithmetic_app/common/bases/base_widget.dart';
import 'package:arithmetic_app/common/widgets/loading_widget.dart';
import 'package:arithmetic_app/data/datasources/remote/api_request.dart';
import 'package:arithmetic_app/data/model/number_model.dart';
import 'package:arithmetic_app/data/repositories/name_repository.dart';
import 'package:arithmetic_app/features/name_arthmetic/name_bloc.dart';
import 'package:arithmetic_app/features/name_arthmetic/name_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';

class NamePage extends StatefulWidget {
  const NamePage({Key? key}) : super(key: key);

  @override
  State<NamePage> createState() => _NamePageState();
}

class _NamePageState extends State<NamePage> {
  @override
  Widget build(BuildContext context) {
    return PageContainer(
      appBar: AppBar(
        title: Text("Name Page"),
      ),
      child: _NameContainer(),
        providers: [
          Provider<ApiRequest>(create: (context)=>ApiRequest()),
          ProxyProvider<ApiRequest,NameRepository>(
              create: (context)=>NameRepository(),
              update: (context, apiRequest, nameRepository){
                nameRepository?.updateApiRequest(apiRequest);
                return nameRepository!;
              }),
          ProxyProvider<NameRepository, NameBloc>(
              create: (context)=>NameBloc(),
              update: (context,nameRepository,nameBloc){
                nameBloc?.updateNameRepository(nameRepository);
                return nameBloc!;
              })
        ],
    );
  }
}

class _NameContainer extends StatefulWidget {
  const _NameContainer({Key? key}) : super(key: key);

  @override
  State<_NameContainer> createState() => _NameContainerState();
}

class _NameContainerState extends State<_NameContainer> {
  late NameBloc _bloc;
  late TextEditingController _firstNameController;
  late TextEditingController _middleNameController;
  late TextEditingController _lastNameController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc = context.read();
    _firstNameController = TextEditingController();
    _middleNameController = TextEditingController();
    _lastNameController = TextEditingController();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Stack(
      children: [
        LoadingWidget(bloc: _bloc,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
             margin: EdgeInsets.symmetric(horizontal: 10),
              alignment: Alignment.center,
              child: Column(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextField(
                        controller: _firstNameController,
                        decoration: InputDecoration(
                          labelText: 'First Name',
                        ),
                      ),

                      TextField(controller: _middleNameController,
                        decoration: InputDecoration(
                          labelText: 'Middle Name',
                        ),
                      ),

                      TextField(controller: _lastNameController,
                        decoration: InputDecoration(
                          labelText: 'Last Name',
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton(onPressed: (){
                    print("confirm!!");
                    String firstName = _firstNameController.text;
                    String middleName = _middleNameController.text;
                    String lastName = _lastNameController.text;
                    if(!(firstName.isEmpty == true ||lastName.isEmpty == true)){
                      _bloc.eventSink.add(ClickNameBtnEvent(firstName.trim().toUpperCase(), middleName.trim().toUpperCase(), lastName.trim().toUpperCase()));
                      _firstNameController.text = "";
                      _middleNameController.text = "";
                      _lastNameController.text = "";
                    }
                  }, child: Text("Confirm"))
                ],
              ),
            ),
            SingleChildScrollView(
              child: StreamBuilder<NumberModel>(
                stream: _bloc.streamController.stream,
                builder: (context,snapshot){
                  if(snapshot.hasError || snapshot.data == null){
                    return Container();
                  }
                  return Html(data: snapshot.data?.content);
                },
              ),
            )
          ],
        ),)
      ],
    ));
  }
}

