import 'dart:math';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Guess Slider Game',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Guess Slider Game'),
        ),
        body: Center(
          child: Container(
            child: MainActivity(),
          ),
        ),
      ),
    );
  }
}

class MainActivity extends StatefulWidget {
  MainActivity({Key key}) : super(key: key);

  @override
  _MainActivityState createState() => _MainActivityState();
}

class _MainActivityState extends State<MainActivity> {
  Random _random = Random();

  double _value =Random().nextInt(99).toDouble();
  var userAns = '';
  var _mTx = '';
  var _Wtext = 0;
  var _Rtext = 0;
  final btns = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '0',
    '⟲Re',
    'enter'
  ];

  _SldChange(double value) {
    setState(() {
      _value = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Expanded(
            child: Column(children: [
              Container(
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text("M"),
                        Text(_mTx)
                        // Text(_value.toStringAsFixed(50).toString()),
                      ],
                    ),
                    Column(
                      children: [
                        Text("W"),
                        Text('$_Wtext'),
                      ],
                    ),
                    Column(
                      children: [
                        Text("R"),
                        Text('$_Rtext'),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Slider(
                    max: 99,
                    min: 0,
                    value: _value,
                    onChanged: _SldChange,

                    // value: _value, onChanged: _setvalue
                  )),
              Container(
                margin: EdgeInsets.only(top: 10),
                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(_value.round().toString()),
                    Text(
                      userAns,
                    ),
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(color: Colors.blueAccent, width: 3)),
                      textColor: Colors.white,
                      color: Colors.blueGrey,
                      onPressed: () {
                        setState(() {
                          userAns = userAns.substring(0, userAns.length - 1);
                        });
                      },
                      child: const Text(
                        '⫷ delete',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ],
                ),
              )
            ]),
          ),
          Expanded(
            flex: 2,
            child: Container(
              child: GridView.builder(
                itemCount: btns.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4),
                itemBuilder: (BuildContext context, int index) {
                  if (index == 11) {
                    return NumBtn(
                      btn_clck: () {
                        var userStr = num.parse(userAns);
                        var _userSlid = _value.round().toInt();

                        if (_userSlid == userStr) {
                          _mTx = '2';
                          _Wtext++;
                        } else {
                          _Rtext--;
                        }

                        setState(() {});
                      },
                      btntxt: btns[index],
                      color: Colors.blueGrey,
                      txtcolor: Colors.green,
                    );
                  } else if (index == 10) {
                    return NumBtn(
                      btntxt: btns[index],
                      color: Colors.blueGrey,
                      txtcolor: Colors.green,
                      btn_clck: () {
                        _mTx = '';
                        setState(() {});
                      },
                    );
                  } else {
                    return NumBtn(
                      btn_clck: () {
                        setState(() {
                          userAns += btns[index];
                        });
                      },
                      btntxt: btns[index],
                      color: Colors.blueGrey,
                      txtcolor: Colors.white,
                    );
                  }
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

class NumBtn extends StatelessWidget {
  final txtcolor;
  final color;
  final String btntxt;
  final btn_clck;
  NumBtn({this.btntxt, this.txtcolor, this.color, this.btn_clck});
  @override
  Widget build(BuildContext context) {
    return Container(
        child: GestureDetector(
      onTap: btn_clck,
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Container(
            color: color,
            child: Center(
              child: Text(
                btntxt,
                style: TextStyle(color: txtcolor),
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
