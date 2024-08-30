import 'dart:async';
import 'package:flutter/material.dart';

class StopWatchPage extends StatefulWidget {
  const StopWatchPage({super.key});

  @override
  State<StopWatchPage> createState() => _StopWatchPageState();
}

class _StopWatchPageState extends State<StopWatchPage> {

  int _milliseconds = 0;
  bool _isRunning = false;
  late Timer _timer;
  final List<int> _savedTimes = [];

  void _startTimer() {
    _isRunning = true;
    _timer = Timer.periodic(const Duration(milliseconds: 10), (t) {
      setState(() {
        _milliseconds += 10;
      });
    });
  }

  void _stopTimer() {
    setState(() {
      _isRunning = false;
      _timer.cancel();
    });
  }

  void _resetTimer() {
    setState(() {
      _milliseconds = 0;
    });
  }

  void _saveTimer() {
    setState(() {
      _savedTimes.add(_milliseconds);
    });
  }

  void _clearTimer() {
    setState(() {
      _savedTimes.clear();
    });
  }

  @override
  Widget build(BuildContext context) {

    int seconds = (_milliseconds / 1000).floor();
    int milliseconds = (_milliseconds % 1000) ~/ 10;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey,
          title: const Text('Stop Watch'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('$seconds.${milliseconds.toString().padLeft(2, '0')}',
                  style: const TextStyle(fontSize: 70)
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                      onPressed: _isRunning ? null : _startTimer,
                      child: const Text('Start')
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                      onPressed: _isRunning ? _stopTimer : null,
                      child: const Text('Stop')
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                      onPressed: _resetTimer,
                      child: const Text('Reset')
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment(0.8, 0.8),
                child: ElevatedButton(
                    onPressed: _saveTimer,
                    child: const Text('Save')
                ),
              ),
              Align(
                alignment: Alignment(0.8, 0.8),
                child: ElevatedButton(
                    onPressed: _clearTimer,
                    child: const Text('Clear')
                ),
              ),
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: _savedTimes.length,
                  itemBuilder: (context, index) {
                    int savedSeconds = (_savedTimes[index] / 1000).floor();
                    int savedMilliseconds = (_savedTimes[index] % 1000) ~/ 10;
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 16),
                      elevation: 3,
                      child: ListTile(
                        leading: const Icon(Icons.timer, color: Colors.black),
                        title: Text(
                          'Saved Time: $savedSeconds.${savedMilliseconds.toString().padLeft(2, '0')} seconds',
                          style: const TextStyle(fontSize: 18),
                        ),
                        tileColor: Colors.grey[200],
                        contentPadding: const EdgeInsets.all(5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}