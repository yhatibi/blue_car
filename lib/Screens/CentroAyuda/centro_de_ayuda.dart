import 'package:blue_car/Screens/Perfil/profile_screen.dart';
import 'package:flutter/material.dart';

class MyData {
  String _title, _body;
  bool _expanded;

  MyData(this._title, this._body, this._expanded);

  @override
  String toString() {
    return 'MyData{_title: $_title, _body: $_body, _expanded: $_expanded}';
  }

  bool get expanded => _expanded;

  set expanded(bool value) {
    _expanded = value;
  }

  get body => _body;

  set body(value) {
    _body = value;
  }

  String get title => _title;

  set title(String value) {
    _title = value;
  }
}

class CentroAyuda extends StatefulWidget{

  @override
  _CentroAyudaState createState() => _CentroAyudaState();
}

class _CentroAyudaState extends State<CentroAyuda>{
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: "Centro de Ayuda",
        theme: new ThemeData.light(),
        home: new HomeWidget()
    );
  }
}
class HomeWidget extends StatefulWidget{
  @override
  _HomeWidgetState createState() => new _HomeWidgetState([
    MyData("Terminos y condiciones", "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem IpsumIt is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).", false),
    MyData("Ayuda", "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).", false),
  ]);
}

class _HomeWidgetState extends State<HomeWidget>{
  List<MyData> _list;
  _HomeWidgetState(this._list);
  _onExpansion(int index, bool isExpanded)
  {
    setState(() {
      _list[index].expanded = !(_list[index].expanded);
    });
  }
  @override
  Widget build(BuildContext context) {
    List<ExpansionPanel> myList = [];
    for (int i=0, ii = _list.length; i < ii;i++){
      var expansionData = _list[i];
      myList.add(ExpansionPanel(headerBuilder: (BuildContext context, bool isExpanded){
        return  Padding(
            padding: EdgeInsets.all((20.0)),
            child: Text(expansionData._title,
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)));
      },
          body: Padding(padding: EdgeInsets.all(20.0),
              child: Text(expansionData._body,
                  style: TextStyle(fontSize: 15.0, fontStyle: FontStyle.italic))),
          isExpanded: expansionData._expanded));
    }
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Centro de Ayuda"),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.all(8.0),
              child: new ExpansionPanelList(
                  children: myList, expansionCallback: _onExpansion),
            )
        )
    );
  }
}
