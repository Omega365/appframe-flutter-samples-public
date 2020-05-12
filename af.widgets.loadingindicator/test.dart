import 'package:flutter/material.dart';

class AFLoadingIndicator extends StatelessWidget {
  final String text;

  AFLoadingIndicator(this.text);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: FractionalOffset.center,
      child: new Container(
        decoration: new BoxDecoration(
            color: Colors.blue,
            borderRadius: new BorderRadius.all(const Radius.circular(40.0))),
        width: 250,
        height: 250,
        child: new Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.orange,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text("$text",
                      style: Theme.of(context)
                          .textTheme
                          .subtitle
                          .apply(color: Colors.white))
                ])),
      ),
    );
  }
}
