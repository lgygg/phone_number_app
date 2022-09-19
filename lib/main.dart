import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone_number_app/main_bloc.dart';
import 'package:phone_number_app/model/bean/area_info.dart';
import 'package:phone_number_app/model/bean/phone_info.dart';
import 'package:phone_number_app/view/phone_list_page.dart';
import 'package:uuid/uuid.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (BuildContext context) => MainBloc()..add(InitEvent()),
    child: Builder(builder: (context) => MyHomePage(title: 'Flutter Demo Home Page')),
    ),
    );
  }
}

//

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);


  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();

}

class _MyHomePageState extends State<MyHomePage> {
  late final bloc;
  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<MainBloc>(context);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(children: [
              BlocBuilder<MainBloc, MainPageState>(builder: (context,state) {
                return state.areaCodeInfo.info.isEmpty? Text('${state.areaCode}',style:const TextStyle(color: Colors.black)) : DropdownButton<String>(
                    underline: Container(
                      height: 0,
                    ),
                    value: state.areaCode,
                    items: _initDropButton(state.areaCodeInfo),
                    onChanged: (value) {
                      bloc.add(AreaSelectedEvent(selectedAreaCode: value?? ''));
                    });
              }),
              Expanded(child: TextField(
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp('[0-9]'))
                ],
                keyboardType: TextInputType.number,
                onChanged: (text){
                  // 需要优化，不需要每次新增输入都修改值
                  bloc.add(InputEvent(inputText: text));
                },
              )),
            ],),
            SizedBox(height: 20,),
            BlocBuilder<MainBloc, MainPageState>(builder: (context,state) {
              return TextButton(onPressed: (){
                bloc.add(SaveNumberEvent(phoneInfo: this._dealData(state.inputText, state.areaCode)));
              }, child: Text('confirm'));
            }),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context)
              .push(MaterialPageRoute(
              builder: (context) => PhoneListPage()));
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  PhoneInfo _dealData(String number,String areaCode){
    PhoneInfo phoneInfo = PhoneInfo();
    phoneInfo.id = Uuid().v4().replaceAll('-', "");
    phoneInfo.number = number;
    phoneInfo.areaCode = areaCode;
    return phoneInfo;
  }

  List<DropdownMenuItem<String>> _initDropButton(AreaCodeInfo info) {
    List<DropdownMenuItem<String>> dropList = [];
    Map temp = info.info;
      temp.forEach((key, value) {
        dropList.add(DropdownMenuItem(
            child: new Container(
              color: Colors.white,
              child:  Text(
                value.toString(),
                style:const TextStyle(color: Colors.black),
              ),
            ),
            value: value.toString()));
      });
   return dropList;
  }
}


