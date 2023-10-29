import 'package:bbs_task/cubit/inventoryCubit/inventory_cubit.dart';
import 'package:bbs_task/cubit/newDocumentCubit/new_document_cubit.dart';
import 'package:bbs_task/localDatabase/dbHelper.dart';
import 'package:bbs_task/view/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


void main() async{


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(create: (context)=>NewDocumentCubit()),
      BlocProvider(create: (context)=>InventoryCubit())
    ],
      child: MaterialApp(

        theme: ThemeData(

          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const Home(),
      ),
    );
  }
}
