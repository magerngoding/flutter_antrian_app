// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_antrian_app/core/constants/colors.dart';
import 'package:flutter_antrian_app/data/models/antrian.dart';
import 'package:flutter_antrian_app/pages/printer_page.dart';

class AntrianPage extends StatefulWidget {
  const AntrianPage({super.key});

  @override
  State<AntrianPage> createState() => _AntrianPageState();
}

class _AntrianPageState extends State<AntrianPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Kelola Antrian',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PrinterPage()),
              );
            },
            icon: const Icon(
              Icons.print,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body:
          // Listview Builder,
          ListView.builder(
        itemCount: 3,
        physics: const ScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.grey[200],
                backgroundImage: const NetworkImage(
                  "https://res.cloudinary.com/dotz74j1p/raw/upload/v1716045088/aqwqm57kunudfs2y5swr.png",
                ),
              ),
              title: Text(
                dataAntrian[index].nama,
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                dataAntrian[index].noAntrian,
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              trailing: IconButton(
                onPressed: () {
                  // Show dialog detail antrian
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Ubah Antrian'),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextField(
                                //          controller: _namaController,
                                decoration: const InputDecoration(
                                  labelText: 'Nama Antrian',
                                ),
                              ),
                              TextField(
                                //  controller: _noAntrianController,
                                decoration: const InputDecoration(
                                  labelText: 'Nomor Antrian',
                                ),
                              ),
                            ],
                          ),
                        );
                      });
                },
                icon: const Icon(
                  Icons.keyboard_arrow_right_rounded,
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Show dialog add antrian
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Tambah Antrian'),
                content: Column(
                  // jika colum kepanjangan nanti menyesuaikan jadi pendek sesuai banyaknya text field.
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Nama Antrian',
                      ),
                    ),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Nomor Antrian',
                      ),
                    )
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Batal',
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        dataAntrian.add(
                          Antrian(
                            id: dataAntrian.length + 1,
                            nama: 'Antrian Baru',
                            noAntrian: 'D-${dataAntrian.length + 1}',
                            isActive: true,
                          ),
                        );
                      });
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Simpan',
                    ),
                  ),
                ],
              );
            },
          );
        },
        backgroundColor: AppColors.primary,
        child: const Icon(
          Icons.add,
          size: 24.0,
          color: Colors.white,
        ),
      ),
    );
  }
}
