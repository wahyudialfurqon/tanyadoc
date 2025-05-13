// Import file yang berisi data penyakit dan gejala
import 'package:pedulitht/screens/data/data.dart';
// Import file yang berisi model hasil diagnosa
import 'package:pedulitht/screens/services/diagnosa_service.dart';

// Kelas untuk menangani sesi diagnosa
class DiagnosaSession {
  // Set untuk menyimpan ID gejala yang dijawab "ya"
  final Set<int> _gejalaYa = {};
  // Set untuk menyimpan ID gejala yang sudah ditanyakan
  final Set<int> _gejalaDitanyakan = {};

  // List kandidat penyakit yang masih mungkin, diambil dari semua penyakit
  List<int> _kandidatPenyakit = semuaPenyakit.map((p) => p.id).toList();

  // Getter untuk mengecek apakah diagnosa sudah selesai
  bool get isSelesai => _cariGejalaBerikutnya() == null;

  // Getter untuk mengambil semua gejala yang dijawab "ya"
  Set<int> get gejalaTerjawabYa => _gejalaYa;

  // Fungsi internal untuk mencari gejala berikutnya yang paling sering muncul
  int? _cariGejalaBerikutnya() {
    // Map untuk menghitung jumlah kemunculan tiap gejala dari kandidat penyakit
    final jumlahKemunculan = <int, int>{};

    // Iterasi pada semua kandidat penyakit
    for (var penyakit in semuaPenyakit.where((p) => _kandidatPenyakit.contains(p.id))) {
      // Hitung gejala yang belum ditanyakan
      for (var gejala in penyakit.gejalaIds) {
        if (!_gejalaDitanyakan.contains(gejala)) {
          jumlahKemunculan[gejala] = (jumlahKemunculan[gejala] ?? 0) + 1;
        }
      }
    }

    // Jika tidak ada gejala tersisa, return null
    if (jumlahKemunculan.isEmpty) return null;

    // Kembalikan gejala dengan jumlah kemunculan terbanyak
    return jumlahKemunculan.entries
        .reduce((a, b) => a.value >= b.value ? a : b)
        .key;
  }

  // Fungsi publik untuk mengambil ID gejala selanjutnya
  int? getNextGejala() => _cariGejalaBerikutnya();

  // Fungsi untuk mencatat jawaban user terhadap sebuah gejala
  void jawab(int gejalaId, bool jawabYa) {
    // Tambahkan gejala ke daftar yang sudah ditanyakan
    _gejalaDitanyakan.add(gejalaId);

    // Jika jawab "ya", tambahkan ke daftar gejala "ya"
    if (jawabYa) _gejalaYa.add(gejalaId);

    // Perbarui kandidat penyakit berdasarkan gejala yang dijawab "ya"
    _kandidatPenyakit = semuaPenyakit.where((p) {
      // Hanya ambil penyakit yang semua gejalanya ada di gejala "ya"
      return _gejalaYa.every(p.gejalaIds.contains);
    }).map((p) => p.id).toList();
  }

  // Fungsi untuk menghitung hasil akhir dari diagnosa
  HasilDiagnosa hasilAkhir() {
    final kemungkinan = <int>[]; // Penyakit yang mungkin
    final akurat = <int>[]; // Penyakit yang cocok secara akurat

    for (var penyakit in semuaPenyakit.where((p) => _kandidatPenyakit.contains(p.id))) {
      // Hitung jumlah gejala yang cocok
      final cocok = penyakit.gejalaIds.where(_gejalaYa.contains).length;

      // Jika ada gejala yang cocok, tambahkan ke kemungkinan
      if (cocok > 0) kemungkinan.add(penyakit.id);

      // Jika semua gejala cocok dan tidak lebih, tambahkan ke akurat
      if (cocok == penyakit.gejalaIds.length && _gejalaYa.length == cocok) {
        akurat.add(penyakit.id);
      }
    }

    // Kembalikan hasil diagnosa
    return HasilDiagnosa(
      kemungkinan: kemungkinan,
      akurat: akurat,
    );
  }
}
