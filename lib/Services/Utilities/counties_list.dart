import 'package:covid19_app/Services/Utilities/Detail_screen.dart';
import 'package:covid19_app/Services/Utilities/States_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountiesListScreen extends StatefulWidget {
  const CountiesListScreen({super.key});

  @override
  State<CountiesListScreen> createState() => _CountiesListScreenState();
}

class _CountiesListScreenState extends State<CountiesListScreen> {

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
     StateServices stateServices = StateServices();
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: controller,
                onChanged: (value){
                  setState(() {

                  });
                },
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  hintText: 'Search with country name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  )
                ),
              ),
            ),
            Expanded(
                child: FutureBuilder(
                  future: stateServices.countiesListApi(),
                  builder:
                  (context, AsyncSnapshot<List<dynamic>> snapshot){
                    if(!snapshot.hasData){
                         return ListView.builder(
                             itemCount: 7,
                             itemBuilder: (context, index){
                               return Shimmer.fromColors(
                                   baseColor: Colors.green.shade700,
                                   highlightColor: Colors.grey.shade700,
                                 child: Column(
                                       children: [
                                         ListTile(
                                           title : Container(height: 10, width: 89, color: Colors.white,),
                                           subtitle: Container(height: 10, width: 89, color: Colors.white,),
                                           leading: Container(height: 50, width: 50, color: Colors.white,),
                                         )
                                       ],
                                     )

                               );
                             }


                         );
                    }else {
                      return ListView.builder(
                          itemCount: snapshot.data?.length,
                          itemBuilder: (context, index) {
                            String name = snapshot.data?[index]['country'];
                            if(controller.text.isEmpty){
                              return Column(
                                children: [
                                  InkWell(
                                    onTap : (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context)
                                      => DetailScreen(
                                        image: snapshot.data![index]['countryInfo']['flag'],
                                        name: snapshot.data![index]['country'] ,
                                        totalcases: snapshot.data![index]['cases'],
                                        todayRecovred: snapshot.data![index]['recovered'] ,
                                        totalDeaths: snapshot.data![index]['deaths'],
                                        active: snapshot.data![index]['active'],
                                        test: snapshot.data![index]['tests'],
                                        totalRecovred: snapshot.data![index]['todayRecovered'],
                                        critical: snapshot.data![index]['critical'] ,
                                      )));
                                      },
                                    child: ListTile(
                                      leading: Image(
                                        height : 50,
                                        width: 50,
                                        image: NetworkImage(
                                            snapshot.data?[index]['countryInfo']['flag']
                                        ),
                                      ),

                                    ),
                                  ),
                                  Divider()
                                ],
                              );
                            }else if(name.toLowerCase().contains(controller.text.toString())){
                              return Column(
                                children: [
                                  InkWell(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context)
                                      => DetailScreen(
                                        image: snapshot.data![index]['countryInfo']['flag'],
                                        name: snapshot.data![index]['country'] ,
                                        totalcases: snapshot.data![index]['cases'],
                                        todayRecovred: snapshot.data![index]['recovered'] ,
                                        totalDeaths: snapshot.data![index]['deaths'],
                                        active: snapshot.data![index]['active'],
                                        test: snapshot.data![index]['tests'],
                                        totalRecovred: snapshot.data![index]['todayRecovered'],
                                        critical: snapshot.data![index]['critical'] ,
                                      )));
                                    },
                                    child: ListTile(
                                      title : Text(snapshot.data?[index]['country']),
                                      subtitle: Text(snapshot.data![index]['cases'].toString()),
                                      leading: Image(
                                        height : 50,
                                        width: 50,
                                        image: NetworkImage(
                                            snapshot.data?[index]['countryInfo']['flag']
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              );
                            }else{
                                    return Container();
                            }


                      }
                      );
                    }
                  }

            ))
          ],
        ),
      ),
    );
  }
}
