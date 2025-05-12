import 'package:pedulitht/screens/data/data.dart';

class HasilDiagnosa {
  final List<int> kemungkinan;
  final List<int> akurat;

  HasilDiagnosa({required this.kemungkinan, required this.akurat});
}

class DiagnosaService {
  static HasilDiagnosa diagnosa(List<int> gejalaTerpilih) {
    final inputSet = gejalaTerpilih.toSet(); // Ubah gejala yang dipilih menjadi Set untuk pencarian lebih cepat.
    final kemungkinan = <int>[]; // Daftar penyakit yang memiliki minimal 1 gejala cocok.
    final akurat = <int>[]; // Daftar penyakit yang memiliki kecocokan gejala yang tepat (exact match).

    // Iterasi melalui semua penyakit untuk mencari yang sesuai dengan gejalaTerpilih
    for (var penyakit in semuaPenyakit) {
      final rule = penyakit.gejalaIds; // Daftar gejala yang terkait dengan penyakit ini.
      final cocok = rule.where((g) => inputSet.contains(g)).length; // Hitung berapa gejala yang cocok.

      // Jika ada minimal 1 kecocokan gejala, masukkan penyakit ke dalam daftar kemungkinan.
      if (cocok > 0) {
        kemungkinan.add(penyakit.id);
      }

      // Jika gejala input persis cocok dengan gejala penyakit (exact match), masukkan ke dalam daftar akurat.
      if (cocok == rule.length && inputSet.length == rule.length) {
        akurat.add(penyakit.id);
      }
    }

    return HasilDiagnosa(
      kemungkinan: kemungkinan,
      akurat: akurat,
    );
  }
}
