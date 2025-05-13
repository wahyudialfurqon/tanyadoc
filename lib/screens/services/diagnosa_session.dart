import 'package:pedulitht/screens/data/data.dart';
import 'package:pedulitht/screens/services/diagnosa_service.dart';

class DiagnosaSession {
  final Set<int> _gejalaYa = {};
  final Set<int> _gejalaDitanyakan = {};

  List<int> _kandidatPenyakit = semuaPenyakit.map((p) => p.id).toList();

  bool get isFinished => getNextGejala() == null;

  Set<int> get gejalaYa => _gejalaYa;

  int? getNextGejala() {
    final Map<int, int> hitungGejala = {};

    for (var id in _kandidatPenyakit) {
      final penyakit = semuaPenyakit.firstWhere((p) => p.id == id);
      for (var gid in penyakit.gejalaIds) {
        if (!_gejalaDitanyakan.contains(gid)) {
          hitungGejala[gid] = (hitungGejala[gid] ?? 0) + 1;
        }
      }
    }

    if (hitungGejala.isEmpty) return null;

    final next = hitungGejala.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return next.first.key;
  }

  void answer(int gejalaId, bool ya) {
    _gejalaDitanyakan.add(gejalaId);
    if (ya) _gejalaYa.add(gejalaId);

    // Filter penyakit berdasarkan gejala yang sudah dikumpulkan.
    _kandidatPenyakit = semuaPenyakit.where((p) {
      return _gejalaYa.every((gid) => p.gejalaIds.contains(gid));
    }).map((p) => p.id).toList();
  }

  HasilDiagnosa getResult() {
    final kemungkinan = <int>[];  // Penyakit yang memiliki minimal satu gejala cocok
    final akurat = <int>[];  // Penyakit yang memiliki kecocokan persis (exact match)

    for (var id in _kandidatPenyakit) {
      final penyakit = semuaPenyakit.firstWhere((p) => p.id == id);
      final rule = penyakit.gejalaIds;
      final cocok = rule.where((g) => _gejalaYa.contains(g)).length;

      // Jika ada minimal 1 kecocokan, masukkan ke kemungkinan.
      if (cocok > 0) {
        kemungkinan.add(id);
      }

      // Jika input persis cocok dengan gejala penyakit (exact match), masukkan ke akurat.
      if (cocok == rule.length && _gejalaYa.length == rule.length) {
        akurat.add(id);
      }
    }

    return HasilDiagnosa(
      kemungkinan: kemungkinan,
      akurat: akurat,
    );
  }
}
