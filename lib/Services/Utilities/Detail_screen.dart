import 'package:covid19_app/View/world_states.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {

  String name;
  String image;
  int totalcases, totalDeaths, totalRecovred, active, critical, todayRecovred,test;
   DetailScreen({
    required this.name,
    required this.image,
    required this.totalcases,
    required this.totalDeaths,
    required this.totalRecovred,
    required this.active,
    required this.critical,
    required this.todayRecovred,
    required this.test,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.name),
          centerTitle: true,
        ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * .06),
                child: Card(
                  child: Column(
                    children: [
                      Reuseablerow(value: widget.totalcases.toString(), title: 'Cases'),
                      Reuseablerow(value: widget.totalRecovred.toString(), title: 'Totl Recovered'),
                      Reuseablerow(value: widget.totalDeaths.toString(), title: 'Death'),
                      Reuseablerow(value: widget.critical.toString(), title: 'Critical'),

                    ],
                  ),
                ),
              ),
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                  widget.image
                ),
              )

            ],
          )
        ],
      ),

    );
  }
}
