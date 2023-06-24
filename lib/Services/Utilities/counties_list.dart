import 'package:covid19_app/Services/Utilities/States_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
                         return Text('Lodaing');
                    }else {
                      return ListView.builder(
                          itemCount: snapshot.data?.length,
                          itemBuilder: (context, index) {
                        return Column(
                          children: [
                            ListTile(
                                    leading: Image(
                                      height : 50,
                                      width: 50,
                                      image: NetworkImage(
                                        snapshot.data?[index]['countryInfo']['flag']
                                      ),
                                    ),
                            )
                          ],
                        );
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
