import 'package:flutter/material.dart';

Stream<DateTime>? _tickStream;
DateTime now = DateTime.now();
bool advance = true;
bool forceUpdate = false;

Stream<DateTime> testStream()
{
    if (_tickStream == null)
    {
        _tickStream = Stream.periodic(
            Duration(seconds: 5),
            (computationCount) {
                if (forceUpdate || advance)
                {
                    now = now.add(Duration(minutes: 1));
                    advance = false;
                    forceUpdate = false;
                }
                else
                {
                    advance = true;
                }
                return now;
            }).asBroadcastStream();
    }

    return _tickStream!;
}

class TestUiView extends StatefulWidget 
{
    @override
    _TestUiViewState createState() => _TestUiViewState();
}

class _TestUiViewState extends State<TestUiView>// with TickerProviderStateMixin 
{
    _TestUiViewState();

    @override
    Widget build(BuildContext context) 
    {        
        return Theme(
            data: ThemeData.dark(useMaterial3: true),
            child: Scaffold(
                backgroundColor: Colors.black,
                body: StreamBuilder<DateTime>(
                    initialData: now,
                    stream: testStream(),
                    builder: (BuildContext context, AsyncSnapshot<DateTime> snapshot)
                    {
                        return DigitsWidget(now: snapshot.data!);
                    },
                )
            )
        );
    }
}

class DigitsWidget extends StatelessWidget
{
    final double _topPos = 20;
    final double _textSize = 450;
    final String _fontFamily = 'RobotoMono';

    final DateTime now;

    const DigitsWidget({super.key, required this.now});

    @override
    Widget build(BuildContext context) 
    {
        var hour = now.hour;
        var minute = now.minute;
       
        final digitColor = hour > 12 
            ? Color.fromARGB(255, 255, 0, 0) 
            : Color.fromARGB(255, 0, 255, 0);

        hour = hour >= 13
            ? hour - 12
            : hour;
        if (hour == 0)
        {
            hour = 12;
        }

        final hourHigh = hour ~/ 10;
        final hourLow = hour % 10;
        final minuteHigh = minute ~/ 10;
        final minuteLow = minute % 10;

        print("now: $now");

        return Stack(children: 
            <Widget>[
                Positioned(
                    left: 0,
                    top: _topPos,
                    child: Text(
                        '$hourHigh',
                        style: TextStyle(
                            color: digitColor,
                            fontFamily: _fontFamily,
                            fontSize: _textSize)
                    )
                ),
                Positioned(
                    left: 230,
                    top: _topPos,
                    child: Text(
                        '$hourLow',
                        style: TextStyle(
                            color: digitColor,
                            fontFamily: _fontFamily,
                            fontSize: _textSize)
                    )
                ),
                Positioned(
                    left: 370,
                    top: _topPos + 25,
                    child: Text(":",
                        style: TextStyle(
                            color: digitColor,// Colors.red,
                            fontFamily: _fontFamily,
                            fontSize: _textSize - 50)
                        )
                ),
                Positioned(
                    left: 520,
                    top: _topPos,
                    child: Text(
                        '$minuteHigh',
                        style: TextStyle(
                            color: digitColor,
                            fontFamily: _fontFamily,
                            fontSize: _textSize)
                        )
                ),
                Positioned(
                    left: 750,
                    top: _topPos,
                    child: Text(
                        '$minuteLow',
                        style: TextStyle(
                            color: digitColor,
                            fontFamily: _fontFamily,
                            fontSize: _textSize)
                    )
                ),
                Positioned(
                    left:40,
                    top: 20,
                    child: TextButton(
                        child: const Text("Update", style: TextStyle(fontSize: 40)),
                        onPressed:() {
                            forceUpdate = true;
                        }
                    )
                ),
            ]
        );
    }
}
