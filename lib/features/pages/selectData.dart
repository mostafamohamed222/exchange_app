import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interviewtask/core/appbloc/appState.dart';
import 'package:interviewtask/core/appbloc/appbloc.dart';
import 'package:interviewtask/features/pages/showDate.dart';
import 'package:interviewtask/features/widgets/currency_widget.dart';
import 'package:intl/intl.dart';

import '../../core/appbloc/appevent.dart';



class SelectData extends StatefulWidget {
  const SelectData({super.key});

  @override
  State<SelectData> createState() => _SelectDataState();
}

class _SelectDataState extends State<SelectData> {
  @override
  void initState() {
    BlocProvider.of<AppBloc>(context).add(GetSymoblesEvent());
    super.initState();
  }

  final baseCodeCtrl = TextEditingController();
  final toCodeCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * .7,
                decoration: const BoxDecoration(
                  color: Colors.cyan,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text(
                      "select the data to get rates",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        state is LoadingSymobles
                            ? const SizedBox()
                            : CurrencyWidget(
                                showText: "base  currency",
                                code: AppBloc.get(context).codes,
                                search: baseCodeCtrl,
                              ),
                        const SizedBox(
                          height: 50,
                        ),
                        state is LoadingSymobles
                            ? const SizedBox()
                            : CurrencyWidget(
                                showText: "to currency",
                                code: AppBloc.get(context).codes,
                                search: toCodeCtrl,
                              ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Text(
                          "from",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        InkWell(
                          child: Text(
                            DateFormat("dd-MM-yyyy")
                                .format(AppBloc.get(context).startDate),
                            style: const TextStyle(fontSize: 20),
                          ),
                          onTap: () {
                            showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2020),
                              lastDate: DateTime.now(),
                              confirmText: "select date",
                            ).then((value) {
                              AppBloc.get(context).add(ChangeStartData(value));
                            });
                          },
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Text(
                          "to  ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        InkWell(
                          child: Text(
                            DateFormat("dd-MM-yyyy")
                                .format(AppBloc.get(context).endDate),
                            style: const TextStyle(fontSize: 20),
                          ),
                          onTap: () {
                            showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2020),
                              lastDate: DateTime.now(),
                              confirmText: "select date",
                            ).then((value) {
                              AppBloc.get(context).add(ChangeEndData(value));
                            });
                          },
                        )
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 100),
              ElevatedButton(
                onPressed: () async {
                  if (baseCodeCtrl.text == "" || toCodeCtrl.text == "") {
                    const snackBar = SnackBar(
                      content: Text('you must select two currency'),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    return;
                  } else if (baseCodeCtrl.text == toCodeCtrl.text) {
                    const snackBar = SnackBar(
                      content: Text('you must select two diffrance currency'),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    return;
                  } else {
                    AppBloc.get(context).add(ChangeBaseCode(baseCodeCtrl.text));
                    AppBloc.get(context).add(ChangeToCode(toCodeCtrl.text));
                  }
                  if (AppBloc.get(context)
                          .startDate
                          .compareTo(AppBloc.get(context).endDate) ==
                      1) {
                    const snackBar = SnackBar(
                      content:
                          Text('you must select end date before first date'),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    return;
                  }

                  await AppBloc.get(context).add(GetRetasEvent(true));
                  // ignore: use_build_context_synchronously
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ShowDate()),
                  );
                },
                child: const Text("Excahnge rate"),
              ),
            ],
          ),
        );
      },
    );
  }
}
