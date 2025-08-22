import 'dart:async';

import 'package:hospital/models/reception.dart';

import '../main.dart';

final receptionsRepository = ReceptionsRepository();

class ReceptionsRepository extends EventController<ReceptionsEvents> {
  final receptions = mapSignal(<String, Reception>{});

  @override
  void listen(ReceptionsEvents event) {
    if (event is ChitIssue) {
      receptions[event.chit.mr] = event.chit;
    } else {
      throw UnimplementedError();
    }
  }
}

class ReceptionsEvents {}

class ChitIssue extends ReceptionsEvents {
  final Reception chit;
  ChitIssue(this.chit);
}

abstract class EventController<E> {
  final controller = StreamController<E>.broadcast();
  EventController() {
    controller.stream.listen(listen);
  }

  void listen(E event);
}
