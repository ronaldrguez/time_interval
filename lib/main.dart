import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:time_interval/model/time_interval.dart';
import 'package:time_interval/repository/station_repository.dart';
import 'package:time_interval/ui/login.dart';
import 'package:time_interval/utils/navigation_widget.dart';


void main() {
  runApp(const MyApp());
}

class AppPage extends Page {
  const AppPage({required String name}) : super(name: name);

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (context) => const MyApp(),
    );
  }
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const LoginScreen();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Station of MotoDrivers',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const NavigationWidget(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage(
      {super.key,
      required this.title,
      });

  final String title;

  @override
  State<StatefulWidget> createState() => _MyHomePageState();
}

class _MyHomePageState extends State <MyHomePage> {
  late StationRepository _repo;
  @override
  void initState() {
    _repo = StationRepository();
    super.initState();
  }

  @override
  void dispose() {
    _repo.signOut();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.green.shade600,
      ),
      body: FutureBuilder(
        future: _repo.intervals,
        initialData: const [],
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if(snapshot.hasData) {
          return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return IntervalItemList(
                  interval: snapshot.data.elementAt(index), onCheckChange: (value ) {
                    _repo.onCheckChange(snapshot.data.elementAt(index), value);
                    setState(() {});
                  },
                );
              }
            );
        } else if(snapshot.hasError) {
          return const Center(child: Text('There is an error'),);
        }
        return const Center(child: CircularProgressIndicator(),);
      },)
    );
  }

}

class IntervalItemList extends StatelessWidget {
  final TimeInterval interval;
  final Function(bool value) onCheckChange;

  final StationRepository _repo = StationRepository();
  final DateFormat _formatter = DateFormat.Hm();

  IntervalItemList(
      {super.key,
      required this.interval, required this.onCheckChange});

  @override
  Widget build(BuildContext context) {
    bool selected = _repo.isIntervalSelected(interval.id);
    return ListTile(
      tileColor: selected ? Colors.green.shade200 : interval.motoDrivers == 0 ? Colors.red.shade200: null,
      leading: Checkbox(
        value: selected,
        activeColor: Colors.green,
        onChanged: (bool? value) {
          if(value == false && interval.motoDrivers == 0 ) {
            onCheckChange.call(value ?? false);
          } else if(interval.motoDrivers > 0) {
            onCheckChange.call(value ?? false);
          }
        },
      ),
      title: Text(
          '${_formatter.format(interval.start)} - ${_formatter.format(interval.end)}',
        style: TextStyle(color: selected || interval.motoDrivers == 0 ? Colors.white : null),
      ),
    );
  }
}

