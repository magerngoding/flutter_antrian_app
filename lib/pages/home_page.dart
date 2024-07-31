// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter_antrian_app/core/constants/colors.dart';
import 'package:flutter_antrian_app/data/models/antrian.dart';
import 'package:flutter_antrian_app/pages/antrian_page.dart';

import '../data/datasource/antrian_local_datasource.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Antrian> listAntrian = [];

  Future<void> getAntrian() async {
    //get all antrian
    final result = await AntrianLocalDatasource.instance.getAllAntrian();
    setState(() {
      listAntrian = result;
    });
  }

// Menjalankan getAntrian setelah app di run
  @override
  void initState() {
    getAntrian();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Home Page",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(16),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 1.0,
          crossAxisCount: 2,
          mainAxisSpacing: 6,
          crossAxisSpacing: 6,
        ),
        itemCount: listAntrian.length,
        shrinkWrap: true,
        physics: ScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            color: AppColors.card,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Text nama antrian
                Text(
                  listAntrian[index].nama,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(
                  height: 12.0,
                ),

                // No antrian
                Text(
                  listAntrian[index].noAntrian,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: AppColors.subtitle,
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AntrianPage()),
          );
          getAntrian();
        },
        child: Icon(
          Icons.settings,
          size: 24.0,
          color: Colors.white,
        ),
        backgroundColor: AppColors.primary,
      ),
    );
  }
}
