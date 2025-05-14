import 'package:pedulitht/screens/data/data.dart';

class HasilDiagnosa {
  final List<int> kemungkinan;
  final List<int> akurat;

  HasilDiagnosa({required this.kemungkinan, required this.akurat});
}

class DiagnosaService {
  static HasilDiagnosa diagnosa(List<int> gejalaTerpilih) {
    final inputSet = gejalaTerpilih.toSet(); 
    final kemungkinan = <int>[]; 
    final akurat = <int>[]; 

    for (var penyakit in semuaPenyakit) {
      final rule = penyakit.gejalaIds; 
      final cocok = rule.where((g) => inputSet.contains(g)).length; 

      if (cocok > 0) {
        kemungkinan.add(penyakit.id);
      }

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
