import 'package:flutter/material.dart';
import 'dart:async';

enum FilterEvent { tahun, ganti_tahun }

class FilterBloc {
  int _tahun = 20211;

  StreamController<FilterEvent> _eventController =
      StreamController<FilterEvent>();
  StreamSink<FilterEvent> get EventSink => _eventController.sink;

  StreamController<int> _stateController = StreamController<int>();
  StreamSink<int> get _stateSink => _stateController.sink;

  Stream<int> get stateStream => _stateController.stream;

  void _mapEventToState(FilterEvent filterEvent) {
    if (filterEvent == FilterEvent.tahun)
      _tahun = 20211;
    else
      _tahun = 20212;

    _stateSink.add(_tahun);
  }

  FilterBloc() {
    _eventController.stream.listen(_mapEventToState);
  }

  void dispose() {
    _eventController.close();
    _stateController.close();
  }
}
