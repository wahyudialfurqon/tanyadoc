import 'package:flutter/material.dart';
import 'package:pedulitht/screens/models/gejala.dart';
import 'package:pedulitht/screens/data/data.dart';
import 'package:pedulitht/screens/models/penyakit.dart';
import 'package:pedulitht/screens/services/diagnosa_service.dart';

class DiagnosisScreen extends StatefulWidget {
  const DiagnosisScreen({super.key});

  @override
  State<DiagnosisScreen> createState() => _DiagnosisScreenState();
}

class _DiagnosisScreenState extends State<DiagnosisScreen> {
  final List<Gejala> gejalaList = List.from(semuaGejala);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              right: 20,
              left: 20,
              top: 20,
              bottom: 80,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Kenali Gejala',
                  style: TextStyle(fontFamily: 'Poppins', fontSize: 25),
                ),
                SizedBox(height: 2),
                Text(
                  'Silakan pilih gejala yang kamu alami.',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),
                SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                    itemCount: gejalaList.length,
                    itemBuilder: (context, index) {
                      final gejala = gejalaList[index];
                      return CheckboxListTile(
                        title: Text(
                          gejala.nama,
                          style: TextStyle(fontFamily: 'Poppins'),
                        ),
                        value: gejala.dipilih,
                        onChanged: (bool? value) {
                          setState(() {
                            gejala.dipilih = value ?? false;
                          });
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton(
                onPressed: () {
                  final inputGejala = gejalaList
                      .where((g) => g.dipilih)
                      .map((g) => g.id)
                      .toList();

                  final hasil = DiagnosaService.diagnosa(inputGejala);

                  String hasilText = '';

                  if (hasil.akurat.isNotEmpty) {
                    hasilText += 'Diagnosis Akurat:\n';
                    hasilText += hasil.akurat
                        .map((id) =>
                            '- ${semuaPenyakit.firstWhere((p) => p.id == id).nama}')
                        .join('\n');
                  }

                  if (hasil.kemungkinan.isNotEmpty &&
                      hasil.kemungkinan.toSet().difference(hasil.akurat.toSet()).isNotEmpty) {
                    hasilText += '\n\nKemungkinan Lain:\n';
                    hasilText += hasil.kemungkinan
                        .where((id) => !hasil.akurat.contains(id))
                        .map((id) =>
                            '- ${semuaPenyakit.firstWhere((p) => p.id == id).nama}')
                        .join('\n');
                  }

                  if (hasilText.isEmpty) {
                    hasilText = 'Tidak ditemukan penyakit yang cocok.';
                  }

                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: Text('Hasil Diagnosis'),
                      content: Text(
                        hasilText,
                        style: TextStyle(fontFamily: 'Poppins'),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('Tutup'),
                        ),
                      ],
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:  Color(0xFF1f4571),
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  'Cek Sekarang',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
