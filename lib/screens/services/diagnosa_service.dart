import '../models/penyakit.dart';
import '../data/data.dart';

/// Hasil keluaran diagnosa:
/// - [kemungkinan]: daftar ID penyakit yang memiliki minimal 1 gejala cocok
/// - [akurat]: daftar ID penyakit yang exact match (gejala rule == input)
class HasilDiagnosa {
  final List<int> kemungkinan;
  final List<int> akurat;

  HasilDiagnosa({
    required this.kemungkinan,
    required this.akurat,
  });
}

/// Service untuk menjalankan inferensi diagnostik
class DiagnosaService {
  /// Melakukan diagnosa berdasarkan [inputGejala] (list ID gejala yang dipilih user)
  /// Mengembalikan [HasilDiagnosa] berisi kemungkinan & akurat.
  static HasilDiagnosa diagnosa(List<int> inputGejala) {
    final inputSet = inputGejala.toSet();
    final kemungkinan = <int>[];
    final akurat = <int>[];

    for (var penyakit in semuaPenyakit) {
      // Hitung berapa gejala rule yang cocok
      final rule = penyakit.gejalaIds;
      final cocok = rule.where((g) => inputSet.contains(g)).length;

      // Jika ada minimal 1 kecocokan, masukkan ke kemungkinan
      if (cocok > 0) {
        kemungkinan.add(penyakit.id);
      }

      // Jika input persis sama dengan rule, masukkan ke akurat
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
