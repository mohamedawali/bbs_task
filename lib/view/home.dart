
import 'package:bbs_task/localDatabase/dbHelper.dart';
import 'package:flutter/material.dart';

import 'inventory.dart';
import 'newDocument.dart';

class Home extends StatefulWidget {
  const Home({super.key});


  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DbHelper dbHelper=DbHelper();
@override
  void initState() {
  dbHelper.getMyDatabaseInstance();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
  Size size=  MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const NewDocument()));
                },style: ElevatedButton.styleFrom(minimumSize: Size(size.width,50,)),
                child: const Text('New Stocktaking Document')),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Inventory()));
                },style: ElevatedButton.styleFrom(minimumSize: Size(size.width,50,)),
                child: const Text('Check Inventory'))
          ],
        ),
      ),
    );
  }


}
