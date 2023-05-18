abstract class AppEvent {}

// use it to get symobles data
class GetSymoblesEvent extends AppEvent {}

// use it to get rates  data
class GetRetasEvent extends AppEvent {
  bool firstTime;
  GetRetasEvent(this.firstTime);
}

class ChangeStartData extends AppEvent {
  DateTime? newTime;
  ChangeStartData(this.newTime);
}

class ChangeEndData extends AppEvent {
  DateTime? newTime;
  ChangeEndData(this.newTime);
}

class ChangeBaseCode extends AppEvent {
  String? newCode;
  ChangeBaseCode(this.newCode);
}

class ChangeToCode extends AppEvent {
  String? newCode;
  ChangeToCode(this.newCode);
}
