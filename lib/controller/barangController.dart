import 'package:http/http.dart' as http;

class BarangController {
  Future<String> fecthData(String cariBarang) async{
   final response = await http.post(
    Uri.parse("http://10.202.0.119/api_toko_hmif/getBarang.php"),
    body:{
      "cari": cariBarang
    });
    if (response.statusCode == 200) {
      return response.body;
    }else{
      return "Data gagal diambil";
    }

  }
}