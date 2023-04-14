import 'package:app_navigator/app_navigator.dart';
import 'package:flutter/material.dart';
import 'package:time_interval/main.dart';
import 'package:time_interval/repository/station_repository.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _key = GlobalKey<FormState>();
  late StationRepository repo = StationRepository();
  late TextEditingController controller;

  @override
  void initState() {
    loadData();
    super.initState();
  }

  void loadData() async {
    repo = StationRepository();
    controller = TextEditingController(text: '');
    await repo.loadData();
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 300,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(30)),
            gradient: LinearGradient(colors: [Colors.green.shade200, Colors.green.shade400, Colors.green.shade800])
          ),
          padding: const EdgeInsets.all(15.0),
          margin: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Form(
            key: _key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Login', style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.w700, color: Colors.green.shade900),),
                TextFormField(
                  controller: controller,
                  style: TextStyle(color: Colors.green.shade900),
                  validator: (value) {
                    if (value == null || value == '') {
                      return 'Field required';
                    }
                    return null;
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.green.shade500),
                        onPressed: () {
                          if (_key.currentState?.validate() ?? false) {
                            if(repo.signIn(controller.text)) {
                              AppNavigator().push(
                                  const MyHomePage(title: 'Station of moto drivers',),
                                  name: 'home');
                            }
                          }
                        },
                        child: const Text('Submit'))
                  ],
                ),
              ],
            ),
          ),
        )
      )
    );
  }
}
