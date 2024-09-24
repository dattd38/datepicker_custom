import 'package:datepicker_custom/datepicker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

void main() {
  return runApp(const App());
}


class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: Locale('vi'),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [Locale('vi')],
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: Color(0xFFA531DC),
          onPrimary: Color(0xFF0037AF),
          secondary: Color(0xFF5346E0),
          onSecondary: Color(0xFF5346E0),
          error: Color(0xFFE2483D),
          onError: Color(0xFFAE2E24),
          surface: Colors.white,
          onSurface: Colors.white,
        ),
      ),
      builder: (context,_){
        return  MyApp();
      },
    );
  }
}

/// My app class to display the date range picker
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

/// State for MyApp
class MyAppState extends State<MyApp> {
  String _selectedDate = '';
  String _dateCount = '';
  String _range = '';
  String _rangeCount = '';

  /// The method for [DateRangePickerSelectionChanged] callback, which will be
  /// called whenever a selection changed on the date picker widget.
  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    /// The argument value will return the changed date as [DateTime] when the
    /// widget [SfDateRangeSelectionMode] set as single.
    ///
    /// The argument value will return the changed dates as [List<DateTime>]
    /// when the widget [SfDateRangeSelectionMode] set as multiple.
    ///
    /// The argument value will return the changed range as [PickerDateRange]
    /// when the widget [SfDateRangeSelectionMode] set as range.
    ///
    /// The argument value will return the changed ranges as
    /// [List<PickerDateRange] when the widget [SfDateRangeSelectionMode] set as
    /// multi range.
    setState(() {
      if (args.value is PickerDateRange) {
        _range = '${DateFormat('dd/MM/yyyy').format(args.value.startDate)} -'
            // ignore: lines_longer_than_80_chars
            ' ${DateFormat('dd/MM/yyyy').format(args.value.endDate ?? args.value.startDate)}';
      } else if (args.value is DateTime) {
        _selectedDate = args.value.toString();
      } else if (args.value is List<DateTime>) {
        _dateCount = args.value.length.toString();
      } else {
        _rangeCount = args.value.length.toString();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: const Text('DatePicker demo'),
            ),
            body: Stack(
              children: <Widget>[
                Positioned(
                  left: 0,
                  right: 0,
                  top: 0,
                  height: 80,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Selected date: $_selectedDate'),
                      Text('Selected date count: $_dateCount'),
                      Text('Selected range: $_range'),
                      Text('Selected ranges count: $_rangeCount')
                    ],
                  ),
                ),
                Positioned(
                  left: 0,
                  top: 80,
                  right: 0,
                  bottom: 0,
                  child: SfDateRangePicker(
                    backgroundColor: Colors.white,
                    onSelectionChanged: _onSelectionChanged,
                    selectionMode: DateRangePickerSelectionMode.range,
                    navigationMode: DateRangePickerNavigationMode.scroll,
                    navigationDirection:
                        DateRangePickerNavigationDirection.vertical,
                    headerStyle: DateRangePickerHeaderStyle(
                      backgroundColor: Colors.white,
                    ),
                    initialSelectedRange: PickerDateRange(
                        DateTime.now().subtract(const Duration(days: 4)),
                        DateTime.now().add(const Duration(days: 3))),
                  ),
                )
              ],
            )));
  }
}
