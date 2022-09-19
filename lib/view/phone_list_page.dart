import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone_number_app/model/bean/phone_info.dart';
import 'package:phone_number_app/view/phone_list_bloc.dart';

class PhoneListPage extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (BuildContext context) => PhoneListBloc()..add(PhoneListInitEvent()),
        child: Builder(builder: (context) => MyPhoneListPage()),
      ),
    );
  }
}

class MyPhoneListPage extends StatefulWidget {

  @override
  _MyPhoneListPage createState() {
    return _MyPhoneListPage();
  }
}

class _MyPhoneListPage extends State<MyPhoneListPage> {

  late final bloc;
  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<PhoneListBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(30.0),
          child: MediaQuery.removePadding(
            removeTop: true,
            context: context, child: AppBar(
            title:const Text(
              "PhoneList",
              style: TextStyle(color: Color(0xff444444),fontSize: 20.0),
            ),
            centerTitle: false,
            backgroundColor: Colors.white,
          ),)
      ),
      body:
      BlocBuilder<PhoneListBloc, PhoneListState>(builder: (context,state) {
        return Container(
                  color: Colors.white,
                  width: double.infinity,
                  child: ListView.builder(
                      itemCount: state.phoneList.length,
                      itemBuilder: (context, index) {
                    return this.buildItem(state.phoneList[index]);
                  }),
                );
      })
    );
  }

  Widget buildItem(PhoneInfo info){
    return Text(
      info.areaCode +'-'+ info.number,
      style: TextStyle(
          fontSize: 16, fontWeight: FontWeight.w800,color: Colors.black),
    );
  }
}
