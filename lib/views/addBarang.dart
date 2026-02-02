import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:numberpicker/numberpicker.dart';

class HalamanTambahBarang extends StatefulWidget {
  const HalamanTambahBarang({super.key});

  @override
  State<HalamanTambahBarang> createState() => _HalamanTambahBarangState();
}

class _HalamanTambahBarangState extends State<HalamanTambahBarang> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController namaBarangController = TextEditingController();
  final TextEditingController deskripsiController = TextEditingController();

  int stok = 1;
  double harga = 10000.0;
  String selectedImage = "";

  File? _image;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tambah Barang"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: namaBarangController,
                  decoration: InputDecoration(
                    label: Text("Nama Barang"),
                    border: OutlineInputBorder()
                  ),                
                  validator: (value){
                    if (value == null || value.isEmpty) {
                      return "Nama barang tidak boleh kosong";
                    }
                  },
                ),
              ),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Text("Harga Barang: Rp $harga",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                    NumberPicker(
                      minValue: 10000, 
                      step: 5000,
                      maxValue: 100000000000, 
                      value: harga.toInt(), 
                      onChanged: (int value){
                        setState(() {
                          harga = value.toDouble();
                        });
                    
                      }),
                  ],
                ),
              ),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Text("Stok: $stok",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                    NumberPicker(
                      minValue: 1, 
                      step: 1,
                      maxValue: 100000000000, 
                      value: stok, 
                      onChanged: (int value){
                        setState(() {
                          stok = value;
                        });
                    
                      }),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Text("Pilih Gambar Barang",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500
                      ),),
                    GestureDetector(
                      onTap: () {
                        pilihGambar(context);
                      },
                      child: Container(
                        height: 150,
                        child: _image == null ? 
                               Image.asset("assets/default-img.jpg") :
                               Image.file(_image!),
                    
                      ) ,
                    ),
                    SizedBox(height: 10,),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: TextFormField(
                        controller: deskripsiController,
                        maxLines: 5,
                        decoration: InputDecoration(
                          label: Text("Deskripsi Barang"),
                          border: OutlineInputBorder()
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    ElevatedButton(
                      onPressed: (){
                        if (_formKey.currentState!.validate() == true) {
                          
                        }
                      }, 
                      child: Text("Simpan Barang")
                    )
                  ],
                )
          
              )
            ],
        
          )
        ),
      ),
      
    );

    
  }

  void pilihGambar(context){
      showModalBottomSheet(
      context: context, 
      builder: (BuildContext bc){
        return SafeArea(
          child: 
            Wrap(
              children: [
                ListTile(
                  leading: Icon(Icons.photo_library),
                  title: Text("Pilih dari galeri"),
                  onTap: () async {
                    final filePicker =  ImagePicker();
                    final image = await filePicker.pickImage(
                      source: ImageSource.gallery,
                      imageQuality: 50,
                      maxHeight: 200,
                      maxWidth: 200
                      );

                      setState(() {
                        if(image != null){
                          _image = File(image.path);
                        }
                      });
                      Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  leading: Icon(Icons.photo_camera),
                  title: Text("Ambil foto dari kamera"),
                  onTap: () async{
                    final filePicker =  ImagePicker();
                    final image = await filePicker.pickImage(
                      source: ImageSource.camera,
                      imageQuality: 50,
                      );

                      setState(() {
                        if(image != null){
                          _image = File(image.path);
                        }
                      });
                      Navigator.of(context).pop();
                  },
                )
              ],
            )
          );
      });
  }
}