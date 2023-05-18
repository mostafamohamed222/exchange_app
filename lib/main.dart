import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/appbloc/appbloc.dart';
import 'core/bloc_obsver.dart';
import 'core/repositories/dioHelper.dart';
import 'features/pages/selectData.dart';

void main() {
  DioHelper.init();
  Bloc.observer = BlocObserverManager();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            body: SelectData(),
          ),
        ),
      ),
    );
  }
}
