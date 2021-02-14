import 'package:flutter/material.dart';

class Valentine extends StatelessWidget {
  const Valentine({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Valentine Day'),
        centerTitle: true,
        backgroundColor: Colors.pinkAccent[100],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Image.asset('assets/love.png'),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(20.0),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.pink[50],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50.0),
                    topRight: Radius.circular(50.0),
                  ),
                ),
                child: Column(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        "Happy Valentine Day!",
                        style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 60.0),
                      child: Text(
                        "some text here some text here some text here some text here some text here some text here some text here some text here some text here some text here",
                        style: TextStyle(
                            fontStyle: FontStyle.normal,
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        "From Your beloved One",
                        style: TextStyle(
                            fontStyle: FontStyle.normal,
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
