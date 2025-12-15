import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:toko_merchandise/controller/barangController.dart';
import 'package:toko_merchandise/models/barang.dart';

class HalamanBarang extends StatefulWidget {
  const HalamanBarang({super.key});

  @override
  State<HalamanBarang> createState() => _HalamanBarangState();
}



class _HalamanBarangState extends State<HalamanBarang> {

  BarangController barangController = BarangController();
  String _temp = "waiting response...";
  List<Barang> listBarang = [];
  String cariBarang = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bacaData("");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Daftar Barang"),
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextFormField(
              decoration: InputDecoration(
                label: Text("Cari Barang"),
                icon: Icon(Icons.search)
              ),
              onFieldSubmitted: (value) {
                setState(() {
                  cariBarang = value;
                });

                bacaData(cariBarang);



              },
            ),
            SizedBox(height: 50,),
            Expanded(
              child: DaftarBarang()
            ),
          ],
        )
      )
    );
  }

  bacaData(String cariBarang) async {

    Future<String> data = barangController.fecthData(cariBarang);

    data.then((value){
      listBarang.clear();
      Map json = jsonDecode(value);
      for (var item in json['data']){
        listBarang.add(Barang.fromJson(item));
      }

      setState(() {
        // _temp = listBarang[2].deskripsi;
      });
    });
  }

  Widget DaftarBarang(){
    if(listBarang.isEmpty || listBarang == null){
      return Center(child: CircularProgressIndicator());
    }else{
      return ListView.builder(
        itemCount: listBarang.length,
        itemBuilder: (BuildContext context, int index){
          return Card(
            child: ListTile(
              title: Text(listBarang[index].nama),
              subtitle: Text(listBarang[index].deskripsi),
            ),
          );
        }
      );
    }
  }
}