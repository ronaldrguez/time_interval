import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:time_interval/model/time_interval.dart';
import 'package:time_interval/model/user.dart';

import '../model/station.dart';

class StationRepository {
  late User? _currentUser;
  late Station _station;

  static final StationRepository _repository = StationRepository._internal();

  factory StationRepository() {
    return _repository;
  }

  StationRepository._internal();

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/data.txt');
  }

  Future<File> writeFile(Station station) async {
    final file = await _localFile;
    final data = json.encode(station.toJson());
    return file.writeAsString(data);
  }

  Future<void> readFile() async {
    try {
      final file = await _localFile;
      final contents = await file.readAsString();
      final data = await json.decode(contents);
      _station = Station.fromJson(data);
    } catch (e) {
      _station = const Station();
    }
  }

  bool signIn(String userName) {
    if (_station.users.map((user) => user.userName).contains(userName)) {
      _currentUser =
          _station.users.firstWhere((user) => user.userName == userName);
    } else {
      _currentUser = User(userName: userName,);
      List<User> users = [];
      users.addAll(_station.users);
      users.add(_currentUser!);
      _station.copyWith(users: users);
    }
    return true;
  }

  Future<void> loadData() async {
    await readFile();
    if (_station.intervals.isEmpty) {
      var initialDate = DateTime.now().copyWith(hour: 8, minute: 0, second: 0);
      const Duration step = Duration(minutes: 30);
      List<TimeInterval> list = [];
      for (int i = 0; i < 24; i++) {
        DateTime endDate = initialDate.add(step);
        list.add(TimeInterval(id: i, start: initialDate, end: endDate, motoDrivers: 2));
        initialDate = endDate;
      }
      _station = _station.copyWith(intervals: list);
      await writeFile(_station);
    }
  }

  Future<List<TimeInterval>> get intervals  {
    return Future.value(_station.intervals);
  }

  void signOut () {
    List<User> usersList = [];
    usersList.addAll(_station.users);
    int index = usersList.map((user) => user.userName).toList().indexOf(_currentUser!.userName);
    if(index >= 0) {
      usersList[index] = _currentUser!;
    } else {
      usersList.add(_currentUser!);
    }
    _station = _station.copyWith(users: usersList);
    writeFile(_station);
    _currentUser = null;
  }

  onCheckChange (TimeInterval interval, bool check) {
    List<int> userIntervalList = [];
    userIntervalList.addAll(_currentUser!.intervals);
    List<TimeInterval> stationIntervalList = [];
    stationIntervalList.addAll(_station.intervals);
    int index = stationIntervalList.indexOf(interval);
    if(check) {
      userIntervalList.add(interval.id);
      stationIntervalList[index] = interval.copyWith(motoDrivers: interval.motoDrivers-1);
    } else {
      userIntervalList.remove(interval.id);
      stationIntervalList[index]= interval.copyWith(motoDrivers: interval.motoDrivers+1);
    }
    _currentUser = _currentUser!.copyWith(intervals: userIntervalList);
    _station = _station.copyWith(intervals: stationIntervalList);
  }

  bool isIntervalSelected(int id) {
    return _currentUser?.intervals.contains(id) ?? false;
  }
}
