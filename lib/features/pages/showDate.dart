import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interviewtask/core/appbloc/appState.dart';
import 'package:interviewtask/core/appbloc/appbloc.dart';
import 'package:interviewtask/core/appbloc/appevent.dart';

import '../widgets/rate_widget.dart';

class ShowDate extends StatefulWidget {
  ShowDate({super.key});

  @override
  State<ShowDate> createState() => _ShowDateState();
}

class _ShowDateState extends State<ShowDate> {
  @override
  void initState() {
    scrollCon.addListener(_onScroll);

    super.initState();
  }

  void _onScroll() {
    var current = scrollCon.offset;
    var max = scrollCon.position.maxScrollExtent;

    if (current >= max * .9) {
      AppBloc.get(context).add(GetRetasEvent(false));
    }
  }

  var scrollCon = ScrollController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text("Excahnges rate"),
          centerTitle: true,
          backgroundColor: Colors.cyan[400],
        ),
        backgroundColor: Colors.cyan[400],
        body: BlocBuilder<AppBloc, AppState>(
          builder: (context, state) {
            return AppBloc.get(context).rates.length == 0
                ? const Center(child: CircularProgressIndicator())
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.separated(
                      controller: scrollCon,
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: 25,
                        );
                      },
                      itemCount: AppBloc.get(context)
                                  .startDate
                                  .compareTo(AppBloc.get(context).endDate) ==
                              1
                          ? AppBloc.get(context).rates.length
                          : AppBloc.get(context).rates.length + 1,
                      itemBuilder: (context, index) {
                        return index >= AppBloc.get(context).rates.length
                            ? const Center(
                                child: CircularProgressIndicator(
                                color: Colors.black,
                              ))
                            : RateWidget(
                                rateModel: AppBloc.get(context).rates[index],
                              );
                      },
                    ),
                  );
          },
        ),
      ),
    );
  }
}
