import 'package:flutter/material.dart';

class ShowDetails extends StatefulWidget {
  @override
  _ShowDetailsState createState() => _ShowDetailsState();
}

class _ShowDetailsState extends State<ShowDetails> {
  List list = [];
  @override
  Widget build(BuildContext context) {
    Map totalData = ModalRoute.of(context).settings.arguments as Map;
    totalData.forEach((key, value) {
      list.add(value);
    });
    return Padding(
      padding: EdgeInsets.all(0.0),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
        ),
        body: Container(
          child: Column(
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Take Measurement again"),
                  style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: Colors.blue,
                      padding: EdgeInsets.fromLTRB(30, 15, 30, 15))),
              new Expanded(
                child: ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (BuildContext context, int index) {
                      if (index != 0) {
                        String key = totalData.keys.elementAt(index);
                        return Card(
                          child: ListTile(
                            title: Text(
                              key,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            trailing: Text(
                              totalData[key],
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        );
                      } else {
                        return ListTile();
                      }
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
