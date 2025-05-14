import 'package:pedulitht/screens/data/data.dart';
import 'package:pedulitht/screens/services/diagnosa_service.dart';

class DiagnosaSession {
  final Set<int> _gejalaYa = {};
  final Set<int> _gejalaDitanyakan = {};
  List<int> _kandidatPenyakit = semuaPenyakit.map((p) => p.id).toList();

  bool get isSelesai => _cariGejalaBerikutnya() == null;
  Set<int> get gejalaTerjawabYa => _gejalaYa;

  int? _cariGejalaBerikutnya() {
    final jumlahKemunculan = <int, int>{};

    for (var penyakit in semuaPenyakit.where((p) => _kandidatPenyakit.contains(p.id))) {
      for (var gejala in penyakit.gejalaIds) {
        if (!_gejalaDitanyakan.contains(gejala)) {
          jumlahKemunculan[gejala] = (jumlahKemunculan[gejala] ?? 0) + 1;
        }
      }
    }

    if (jumlahKemunculan.isEmpty) return null;

    return jumlahKemunculan.entries
        .reduce((a, b) => a.value >= b.value ? a : b)
        .key;
  }

  int? getNextGejala() => _cariGejalaBerikutnya();

  void jawab(int gejalaId, bool jawabYa) {
    _gejalaDitanyakan.add(gejalaId);
    if (jawabYa) _gejalaYa.add(gejalaId);

    _kandidatPenyakit = semuaPenyakit.where((p) {
      return _gejalaYa.every(p.gejalaIds.contains);
    }).map((p) => p.id).toList();
  }

  HasilDiagnosa hasilAkhir() {
    final kemungkinan = <int>[];
    final akurat = <int>[];

    for (var penyakit in semuaPenyakit.where((p) => _kandidatPenyakit.contains(p.id))) {
      final cocok = penyakit.gejalaIds.where(_gejalaYa.contains).length;

      if (cocok > 0) kemungkinan.add(penyakit.id);
      if (cocok == penyakit.gejalaIds.length && _gejalaYa.length == cocok) {
        akurat.add(penyakit.id);
      }
    }

    return HasilDiagnosa(
      kemungkinan: kemungkinan,
      akurat: akurat,
    );
  }
}
