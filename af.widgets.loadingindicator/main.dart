import 'package:flutter/material.dart';

void main() => runApp(MyApp());

/// This Widget is the main application widget.
class MyApp extends StatelessWidget {
  static const String _title = 'Loading Indicator Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(_title),
        ),
        body: Center(child: 
          // Construct the building indicator widget
          AFLoadingIndicator(
            // Pass your message using the text parameter
            text: 'Loading...',
          ),
        ),
      ),
    );
  }
}

// ------------------------------------------------------------------
// Ignore the code below, it's required for the example above
// ------------------------------------------------------------------
class AFLoadingIndicator extends StatelessWidget {
  final String _text;

  AFLoadingIndicator({@required text}) : assert(text != null), _text = text;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: FractionalOffset.center,
      child: new Container(
        decoration: new BoxDecoration(
            color: Color(0xFF004A98),
            borderRadius: new BorderRadius.all(const Radius.circular(40.0))),
        width: 200,
        height: 200,
        child: new Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Color(0xFFF18A00),
                      ),
                    ),
                  ),
                  SizedBox(height: 25),
                  Text("$_text",
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .subtitle2
                          .apply(color: Colors.white))
                ])),
      ),
    );
  }
}
