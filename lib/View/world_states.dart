import 'dart:async';

import 'package:covid19_app/Services/Utilities/States_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

import '../Model/WorldStatesModel.dart';
import '../Services/Utilities/counties_list.dart';

class WroldStates extends StatefulWidget {
  const WroldStates({super.key});

  @override
  State<WroldStates> createState() => _WroldStatesState();
}

class _WroldStatesState extends State<WroldStates> with TickerProviderStateMixin{
  late final AnimationController _controller = AnimationController(
      duration: Duration(milliseconds: 1000),
      vsync: this)..repeat();

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }



  final colorList =<Color> [
    const Color(0xff4285F4),
    const Color(0xff1aa260),
    const Color(0xffde5246)
  ];

  @override

  @override
  Widget build(BuildContext context) {
    StateServices stateServices = StateServices();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * .01,),
            FutureBuilder(
                future: stateServices.fetchWorledStatesRecords(),
                builder: (context, AsyncSnapshot<WorldStatesModel> snapshot) {

              if(!snapshot.hasData){
                      return Expanded(
                        flex: 1,
                          child: SpinKitFadingCircle(
                            color: Colors.white,
                            controller: _controller,
                          )
                      );
              }
              else{
                return Column(
                  children: [
                    PieChart(dataMap: {
                      "Total": double.parse(snapshot.data!.cases!.toString()),
                      "Recovered": double.parse(snapshot.data!.recovered.toString()),
                      "Deaths": double.parse(snapshot.data!.deaths.toString()),
                    },
                      chartRadius: MediaQuery.of(context).size.width/1.2,
                      legendOptions: const LegendOptions(
                          legendPosition: LegendPosition.left
                      ),
                      animationDuration: const Duration(milliseconds: 1200),
                      chartType: ChartType.ring,
                      colorList: colorList,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * .06),
                      child: Card(
                        child: Column(
                          children: [
                           Reuseablerow(value: snapshot.data!.cases.toString(), title: "Total"),
                            Reuseablerow(value: snapshot.data!.deaths.toString(), title: "Deaths"),
                            Reuseablerow(value: snapshot.data!.recovered.toString(), title: "Recovered"),
                            Reuseablerow(value: snapshot.data!.active.toString(), title: "Active"),
                            Reuseablerow(value: snapshot.data!.critical.toString(), title: "Critical"),
                            Reuseablerow(value: snapshot.data!.todayCases.toString(), title: "Total Death's"),
                            Reuseablerow(value: snapshot.data!.todayCases.toString(), title: "Total Recovered"),

                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap : (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)
                      =>const CountiesListScreen()));
                    },
                      child: Container(
                          height: 50,
                          width: 250,
                          decoration: BoxDecoration(
                              color: Color(0xff1aa260),
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child:const Align(
                            alignment: Alignment.center,
                            child: Text('Track Countires', textAlign: TextAlign.center,),
                          )

                      ),
                    )
                  ],
                );
              }

            }),


          ],
        ),
      ),
    );
  }
}

class Reuseablerow extends StatelessWidget {
  String title, value;
   Reuseablerow({super.key, required this.value, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 5, top: 10),
      child: Column(
        children: [
             Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title),
                Text(value),
              ],
            ),
            SizedBox(
               height: 5,
            ),
          Divider()
        ],
      ),
    );
  }
}

