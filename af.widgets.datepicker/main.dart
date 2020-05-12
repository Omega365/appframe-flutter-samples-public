import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

void main() => runApp(MyApp());

/// This Widget is the main application widget.
class MyApp extends StatelessWidget {
  static const String _title = 'Date Picker Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(_title),
        ),
        body: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // NOTE: DateFormatting is included when using the widget natively.
              // Due to current DartPad limitations, it's not possible to showcase 
              // the formatting functionality here.

              // NOTE: We cannot showcase iOS platform date picker via DartPad at the moment.

              // Default date selection
              AFDatePicker(
                title: 'Date Sample',
                hintText: 'Select a date'
              ),

              // DateTime selection
              AFDatePicker(
                title: 'DateTime Sample',
                type: AFDatePickerType.DateTime,
                hintText: 'Select date and time'
              ),

              // Time selection
              AFDatePicker(
                title: 'Time Sample',
                type: AFDatePickerType.Time,
                hintText: 'Select time'
              ),

              // Time error showcase
              AFDatePicker(
                title: 'Time Sample - error text',
                type: AFDatePickerType.Time,
                hintText: 'Select time',
                errorText: 'Your selected period is not valid.',
                isInputValid: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------
// Ignore the code below, it's required to showcase the sample.
// -----------------------------------------------------------------

/// Appframe Date Picker widget, respects native date input controls.
class AFDatePicker extends StatefulWidget {
  /// String to be placed above the Icon and Input widgets.
  final String title;

  /// TextEditingController instance to use.
  final TextEditingController controller;

  /// Callback function that accepts [DateTime] as it's single argument.
  /// Will be called once the user picks a new Date and/or Time.
  final Function(DateTime selectedDateTime) onSelected;

  /// The type of selector the user should be presented with. Defaults
  /// to [AFDatePickerType.Date] value.
  /// 
  /// - [AFDatePickerType.Date] will allow user to select Year, Month
  /// and Day values only.
  /// - [AFDatePickerType.Time] will allow user to select Hour and
  /// Minute values only.
  /// - [AFDatePickerType.DateTime] will aloow user to select Year,
  /// Month, Day, Hour and Minute values.
  final AFDatePickerType type;

  /// Hint text to use when the input is empty.
  final String hintText;

  /// Error text to use when the [isInputValid] value is false.
  final String errorText;

  /// Toggle this value in your validation checks for the returned
  /// value in [onSelected] callback.
  /// 
  /// [isInputValid] when true, input will highlight in red and display
  /// [errorText] if available.
  final bool isInputValid;

  /// Maximum width the widget should occupy.
  /// 
  /// Defaults to [MediaQuery.of(context).size.width * 0.35].
  final double maxWidth;

  /// Initial date to be passed when constructing the widget.
  /// 
  /// Defaults to [DateTime.now()].
  final DateTime initialDate;

  /// Minimum [DateTime] value to be allowed for selection.
  /// 
  /// Defaults to [DateTime(2000)].
  final DateTime firstDate;

  /// Maximum [DateTime] value to be allowed for selection.
  /// 
  /// Defaults to [DateTime(2030)].
  final DateTime lastDate;

  /// DateTime format string to be used to format the input text.
  /// 
  /// Based on the [type] the defaults are as follows:
  /// - [AFDatePickerType.Date] defaults to ['MMM d, y']
  /// - [AFDatePickerType.Time] defaults to ['HH:mm']
  /// - [AFDatePickerType.DateTime] defaults to ['MMM d, y HH:mm'] 
  /// To find available formating options refer to https://pub.dev/documentation/intl/latest/intl/DateFormat-class.html
  final String inputDateTimeFormat;

  const AFDatePicker({
    Key key,
    this.title,
    this.controller,
    this.onSelected(DateTime selectedDateTime),
    this.type = AFDatePickerType.Date,
    this.hintText = 'Select a value',
    this.errorText,
    this.isInputValid = true,
    this.maxWidth,
    this.initialDate,
    this.firstDate,
    this.lastDate,
    this.inputDateTimeFormat,
  }) : super(key: key);

  @override
  _AFDatePickerState createState() => _AFDatePickerState();
}

class _AFDatePickerState extends State<AFDatePicker> {
  DateTime _selectedDateTime;
  DateTime _firstDate;
  DateTime _lastDate;
  TextEditingController _controller;
  //String _dateFormat;
  IconData _icon;

  @override
  void initState() {
    super.initState();

    _selectedDateTime = widget.initialDate ?? DateTime.now();
    _controller = widget.controller ?? TextEditingController(text: widget.initialDate != null ? widget.initialDate.toString() : '');
    _firstDate = widget.firstDate ?? DateTime(2000);
    _lastDate = widget.lastDate ?? DateTime(2030);

    switch (widget.type) {
      case AFDatePickerType.Date:
        //_dateFormat = 'MMM d, y';
        _icon = Icons.calendar_today;
        break;
      case AFDatePickerType.DateTime:
        //_dateFormat = 'MMM d, y HH:mm';
        _icon = Icons.calendar_today;
        break;
      case AFDatePickerType.Time:
        //_dateFormat = 'HH:mm';
        _icon = Icons.access_time;
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (widget.title != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 6.0),
            child: Text(widget.title),
          ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Icon(_icon, color: Theme.of(context).primaryColor, size: 28),
            UIHelper.horizontalSpaceSmall,
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: widget.maxWidth ?? MediaQuery.of(context).size.width * 0.35),
              child: TextField(
                readOnly: true,
                controller: _controller,
                onTap: () async {
                  DateTime value = await onDateInputTap(context, _selectedDateTime, _controller);
                  if (widget.onSelected != null) widget.onSelected(value);
                },
                decoration: InputDecoration(
                  isDense: true,
                  hintText: widget.hintText,
                  errorText: widget.isInputValid ? null : widget.errorText,
                  hintStyle: TextStyle(fontStyle: FontStyle.italic),
                  contentPadding: EdgeInsets.symmetric(vertical: 3),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// Handles DateInputs onTap event and displays platform appropriate date picker.
  Future<DateTime> onDateInputTap(BuildContext context, DateTime dateProperty, TextEditingController textController) async {
    if (true) {
      if ([AFDatePickerType.Date, AFDatePickerType.DateTime].contains(widget.type)) {
        dateProperty = await showDatePicker(
          context: context,
          initialDate: dateProperty,
          firstDate: _firstDate, 
          lastDate: _lastDate,
        );
      }

      if ([AFDatePickerType.Time, AFDatePickerType.DateTime].contains(widget.type)) {
        TimeOfDay _time = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.fromDateTime(dateProperty),
        );

        if (_time != null) {
          dateProperty = DateTime(dateProperty.year, dateProperty.month, dateProperty.day, _time.hour, _time.minute);
        }
      }
    } 
//     else {
//       await showCupertinoModalPopup(
//           context: context,
//           builder: (_) {
//             return Container(
//               height: MediaQuery.of(_).size.height * 0.35,
//               child: CupertinoDatePicker(
//                 mode: CupertinoDatePickerMode.date,
//                 initialDateTime: dateProperty,
//                 maximumDate: _firstDate,
//                 minimumDate: _lastDate,
//                 onDateTimeChanged: (selectedDate) {
//                   dateProperty = selectedDate;
//                 },
//               ),
//             );
//           });
//     }

    if (dateProperty != null) {
      String inputValue = dateProperty.toString();
      _controller.value = TextEditingValue(
        text: inputValue,
        selection: TextSelection(baseOffset: inputValue.length, extentOffset: inputValue.length),
      );
    }

    return dateProperty;
  }
}

enum AFDatePickerType {
  Date,
  Time,
  DateTime,
}

class UIHelper {
  // Vertical spacing constants. Adjust to your liking.
  static const double _VerticalSpaceSmall = 10.0;
  static const double _VerticalSpaceMedium = 20.0;
  static const double _VerticalSpaceLarge = 60.0;

  // Vertical spacing constants. Adjust to your liking.
  static const double _HorizontalSpaceSmall = 10.0;
  static const double _HorizontalSpaceMedium = 20.0;
  static const double _HorizontalSpaceLarge = 60.0;

  static const Widget verticalSpaceSmall = SizedBox(height: _VerticalSpaceSmall);
  static const Widget verticalSpaceMedium = SizedBox(height: _VerticalSpaceMedium);
  static const Widget verticalSpaceLarge = SizedBox(height: _VerticalSpaceLarge);

  static const Widget horizontalSpaceSmall = SizedBox(width: _HorizontalSpaceSmall);
  static const Widget horizontalSpaceMedium = SizedBox(width: _HorizontalSpaceMedium);
  static const Widget horizontalSpaceLarge = SizedBox(width: _HorizontalSpaceLarge);
}