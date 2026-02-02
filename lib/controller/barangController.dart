import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class BarangController {
  Future<String> fecthData(String cariBarang) async{
   final response = await http.post(
    Uri.parse("http://10.202.0.211/api_toko_hmif/getBarang.php"),
    body:{
      "cari": cariBarang
    });
    if (response.statusCode == 200) {
      return response.body;
    }else{
      return "Data gagal diambil";
    }

  }

  Future<String> tambahBarang(
    String namaBarang,
    double harga,
    int stok,
    String deskripsi,
    String imagePath
  ) async{
    List<int> imageBytes = File(imagePath).readAsBytesSync();
    String base64Image = base64Encode(imageBytes);

    final response = await http.post(
      Uri.parse("http://10.202.0.211/api_toko_hmif/addBarang.php"),
      body: {
        "nama_barang": namaBarang,
        "harga": harga.toString(),
        "stok": stok.toString(),
        "deskripsi": deskripsi,
        "image": base64Image
      }
      
    );
    
    if (response.statusCode == 200){
      return response.body;
    } else {
      return "Gagal menambah barang";
    }


  }
}