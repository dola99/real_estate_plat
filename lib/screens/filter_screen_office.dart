import 'package:flutter/material.dart';
import 'package:real_estate/models/list_of_Governorates.dart';
import 'package:real_estate/screens/Result_filter_office.dart';

class FilterScreenOffice extends StatefulWidget {
  static const routeName = '/Filter_Screen_Office';
  @override
  _FilterScreenOfficeState createState() => _FilterScreenOfficeState();
}

class _FilterScreenOfficeState extends State<FilterScreenOffice> {
  List<String> places = [];
  String _drowdownvalue = 'Cairo';
  String _drowdownvalue2;
  String _drowdownvalue3 = 'Buy';
  String _drowdownvalue4 = 'Cash';
  FocusNode _priceformFocusNode = FocusNode();
  FocusNode _pricetoFocusNode = FocusNode();
  FocusNode _areafromFocusNode = FocusNode();
  FocusNode _areatoFocusNode = FocusNode();
  FocusNode _floorfromFocusNode = FocusNode();
  FocusNode _floortoFocusNode = FocusNode();
  FocusNode _roomfromFocusNode = FocusNode();
  FocusNode _roomtoFocusNode = FocusNode();
  FocusNode _tablefromFocusNode = FocusNode();
  FocusNode _tabletoFocusNode = FocusNode();
  TextEditingController _pricefrom = TextEditingController();
  TextEditingController _priceto = TextEditingController();
  TextEditingController _areafrom = TextEditingController();
  TextEditingController _areato = TextEditingController();
  TextEditingController _floorfrom = TextEditingController();
  TextEditingController _floorto = TextEditingController();
  TextEditingController _roomfrom = TextEditingController();
  TextEditingController _roomto = TextEditingController();
  TextEditingController _tablesfrom = TextEditingController();
  TextEditingController _tablesto = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final hight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          "Filter Your Result",
          style: TextStyle(
            fontSize: 17,
            fontFamily: "Lora",
          ),
        ),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.filter_alt))],
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: width,
              height: hight * .1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  DropdownButton<String>(
                      value: _drowdownvalue,
                      iconSize: 24,
                      elevation: 16,
                      style: TextStyle(color: Colors.black),
                      items: Egypt.governorates
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem(
                          child: Text(value),
                          value: value,
                        );
                      }).toList(),
                      onChanged: (String newvalue) {
                        setState(() {
                          returnlist();
                          if (newvalue.isNotEmpty) {
                            _drowdownvalue = newvalue;
                          }
                          returnlist();
                        });
                      }),
                  DropdownButton<String>(
                      value: _drowdownvalue2,
                      iconSize: 24,
                      elevation: 16,
                      style: TextStyle(color: Colors.black),
                      items:
                          places.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem(
                          child: Text(value),
                          value: value,
                        );
                      }).toList(),
                      onChanged: (String newvalue) {
                        setState(() {
                          if (newvalue.isNotEmpty) {
                            _drowdownvalue2 = newvalue;
                          }
                        });
                      }),
                ],
              ),
            ),
            Container(
              width: width,
              height: hight * .1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  DropdownButton<String>(
                      value: _drowdownvalue3,
                      iconSize: 24,
                      elevation: 16,
                      style: TextStyle(color: Colors.black),
                      items: ['Buy', 'Rent']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem(
                          child: Text(value),
                          value: value,
                        );
                      }).toList(),
                      onChanged: (String newvalue) {
                        setState(() {
                          if (newvalue.isNotEmpty) {
                            _drowdownvalue3 = newvalue;
                          }
                        });
                      }),
                  DropdownButton<String>(
                      value: _drowdownvalue4,
                      iconSize: 24,
                      elevation: 16,
                      style: TextStyle(color: Colors.black),
                      items: ['Cash', 'Deposit']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem(
                          child: Text(value),
                          value: value,
                        );
                      }).toList(),
                      onChanged: (String newvalue) {
                        setState(() {
                          if (newvalue.isNotEmpty) {
                            _drowdownvalue4 = newvalue;
                          }
                        });
                      }),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: width,
                height: hight * .1,
                child: Row(
                  children: [
                    Text("Price : "),
                    SizedBox(
                      width: width * .04,
                    ),
                    Expanded(
                      child: TextField(
                        focusNode: _priceformFocusNode,
                        controller: _pricefrom,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        onSubmitted: (_) {
                          FocusScope.of(context)
                              .requestFocus(_pricetoFocusNode);
                        },
                        decoration: InputDecoration(hintText: "From"),
                      ),
                    ),
                    SizedBox(
                      width: width * .06,
                    ),
                    Expanded(
                      child: TextField(
                        focusNode: _pricetoFocusNode,
                        controller: _priceto,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        onSubmitted: (_) {
                          FocusScope.of(context)
                              .requestFocus(_areafromFocusNode);
                        },
                        decoration: InputDecoration(hintText: "To"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: width,
                height: hight * .1,
                child: Row(
                  children: [
                    Text("Area : "),
                    SizedBox(
                      width: width * .04,
                    ),
                    Expanded(
                      child: TextField(
                        focusNode: _areafromFocusNode,
                        controller: _areafrom,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        onSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_areatoFocusNode);
                        },
                        decoration: InputDecoration(hintText: "From"),
                      ),
                    ),
                    SizedBox(
                      width: width * .06,
                    ),
                    Expanded(
                      child: TextField(
                        focusNode: _areatoFocusNode,
                        controller: _areato,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        onSubmitted: (_) {
                          FocusScope.of(context)
                              .requestFocus(_floorfromFocusNode);
                        },
                        decoration: InputDecoration(hintText: "To"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: width,
                height: hight * .1,
                child: Row(
                  children: [
                    Text("Floor : "),
                    SizedBox(
                      width: width * .04,
                    ),
                    Expanded(
                      child: TextField(
                        focusNode: _floorfromFocusNode,
                        controller: _floorfrom,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        onSubmitted: (_) {
                          FocusScope.of(context)
                              .requestFocus(_floortoFocusNode);
                        },
                        decoration: InputDecoration(hintText: "From"),
                      ),
                    ),
                    SizedBox(
                      width: width * .06,
                    ),
                    Expanded(
                      child: TextField(
                        focusNode: _floortoFocusNode,
                        controller: _floorto,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        onSubmitted: (_) {
                          FocusScope.of(context)
                              .requestFocus(_roomfromFocusNode);
                        },
                        decoration: InputDecoration(hintText: "To"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: width,
                height: hight * .1,
                child: Row(
                  children: [
                    Text("Room : "),
                    SizedBox(
                      width: width * .04,
                    ),
                    Expanded(
                      child: TextField(
                        focusNode: _roomfromFocusNode,
                        controller: _roomfrom,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        onSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_roomtoFocusNode);
                        },
                        decoration: InputDecoration(hintText: "From"),
                      ),
                    ),
                    SizedBox(
                      width: width * .06,
                    ),
                    Expanded(
                      child: TextField(
                        focusNode: _roomtoFocusNode,
                        controller: _roomto,
                        onSubmitted: (_) {
                          FocusScope.of(context)
                              .requestFocus(_tablefromFocusNode);
                        },
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(hintText: "To"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: width,
                height: hight * .1,
                child: Row(
                  children: [
                    Text("Tables : "),
                    SizedBox(
                      width: width * .04,
                    ),
                    Expanded(
                      child: TextField(
                        focusNode: _tablefromFocusNode,
                        controller: _tablesfrom,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        onSubmitted: (_) {
                          FocusScope.of(context)
                              .requestFocus(_tabletoFocusNode);
                        },
                        decoration: InputDecoration(hintText: "From"),
                      ),
                    ),
                    SizedBox(
                      width: width * .06,
                    ),
                    Expanded(
                      child: TextField(
                        focusNode: _tabletoFocusNode,
                        controller: _tablesto,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(hintText: "To"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ResultFilterOffice(
                            areafrom: int.tryParse(_areafrom.text) ?? 0,
                            areato: int.tryParse(_areato.text) ?? 500,
                            buyorsell: _drowdownvalue3,
                            floorfrom: int.tryParse(_floorfrom.text) ?? 0,
                            floorto: int.tryParse(_floorto.text) ?? 50,
                            goverment: _drowdownvalue,
                            pay: _drowdownvalue4,
                            place: _drowdownvalue2,
                            priceform: int.tryParse(_pricefrom.text) ?? 0,
                            priceto: int.tryParse(_priceto.text) ?? 200000000,
                            roomfrom: int.tryParse(_roomfrom.text) ?? 0,
                            roomto: int.tryParse(_roomto.text) ?? 10,
                            tablefrom: int.tryParse(_tablesfrom.text) ?? 0,
                            tableto: int.tryParse(_tablesto.text ?? 500),
                          )));
                },
                child: Text("Filter"))
          ],
        ),
      ),
    );
  }

  void returnlist() {
    if (_drowdownvalue == 'Cairo') {
      setState(() {
        places = Egypt.cairo;
        _drowdownvalue2 = Egypt.cairo.first.toString();
        return;
      });
    } else if (_drowdownvalue == 'Giza') {
      setState(() {
        places = Egypt.giza;
        _drowdownvalue2 = Egypt.giza.first.toString();
        return;
      });
    } else if (_drowdownvalue == 'Alexandria') {
      setState(() {
        places = Egypt.alexandria;
        _drowdownvalue2 = Egypt.alexandria.first.toString();
        return;
      });
    } else if (_drowdownvalue == 'Qalyubia') {
      setState(() {
        places = Egypt.qalyubia;
        _drowdownvalue2 = Egypt.qalyubia.first.toString();
        return;
      });
    } else if (_drowdownvalue == 'Monufia') {
      setState(() {
        places = Egypt.mounofia;
        _drowdownvalue2 = Egypt.mounofia.first.toString();
        return;
      });
    } else if (_drowdownvalue == 'Beni Suef') {
      setState(() {
        places = Egypt.baniswief;
        _drowdownvalue2 = Egypt.baniswief.first.toString();
        return;
      });
    } else if (_drowdownvalue == 'Gharbia') {
      setState(() {
        places = Egypt.garbiea;
        _drowdownvalue2 = Egypt.garbiea.first.toString();
        return;
      });
    } else if (_drowdownvalue == 'Sharqia') {
      setState(() {
        places = Egypt.sharqia;
        _drowdownvalue2 = Egypt.sharqia.first.toString();
        return;
      });
    } else if (_drowdownvalue == 'Suez') {
      setState(() {
        places = Egypt.suez;
        _drowdownvalue2 = Egypt.suez.first.toString();
        return;
      });
    } else {
      setState(() {
        places = Egypt.cairo;
        _drowdownvalue2 = Egypt.cairo.first.toString();
      });
    }
  }
}
