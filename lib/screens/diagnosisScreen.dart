import 'dart:convert';
import 'dart:ui'; 
import 'package:flutter/material.dart';
import 'package:pedulitht/screens/data/data.dart';
import 'package:pedulitht/screens/models/gejala.dart';
import 'package:pedulitht/screens/services/diagnosa_session.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DiagnosisScreen extends StatefulWidget {
  const DiagnosisScreen({super.key});

  @override
  State<DiagnosisScreen> createState() => _DiagnosisScreenState();
}

class _DiagnosisScreenState extends State<DiagnosisScreen> {
  late DiagnosaSession _session;
  int? _currentGejalaId;
  bool _started = false;

  double _persentase(int penyakitId) {
    final penyakit = semuaPenyakit.firstWhere((p) => p.id == penyakitId);
    final totalGejala = penyakit.gejalaIds.length;
    final cocok =
        penyakit.gejalaIds.where((g) => _session.gejalaYa.contains(g)).length;
    return (cocok / totalGejala) * 100;
  }

  @override
  void initState() {
    super.initState();
    _session = DiagnosaSession();
    _advanceQuestion();
  }

  void _advanceQuestion() {
    setState(() {
      _currentGejalaId = _session.getNextGejala();
    });
  }

  void _answer(bool hasSymptom) {
    if (_currentGejalaId != null) {
      _session.answer(_currentGejalaId!, hasSymptom);
      _advanceQuestion();

      if (_session.isFinished) {
        final hasil = _session.getResult();
        final List<int> listId =
            hasil.akurat.isNotEmpty ? hasil.akurat : hasil.kemungkinan;

        if (listId.isNotEmpty) {
          final id = listId.first;
          final penyakit = semuaPenyakit.firstWhere((p) => p.id == id);
          final cocokGejala =
              penyakit.gejalaIds
                  .where((gid) => _session.gejalaYa.contains(gid))
                  .map((gid) => semuaGejala.firstWhere((g) => g.id == gid).nama)
                  .toList();

        }
      }
    }
  }

  void _startDiagnosis() {
    setState(() {
      _started = true;
      _advanceQuestion();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    if (!_started) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('images/diagnosisIcons.png', width: 110),
            const SizedBox(height: 20),
            const Text(
              'Selamat Datang di TanyaDoc!',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            const Text(
              'Tekan tombol di bawah untuk memulai proses diagnosis.',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                color: Colors.black54,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: _startDiagnosis,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[400],
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Mulai Diagnosis',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      );
    }
    if (!_session.isFinished && _currentGejalaId != null) {
      final gejala = semuaGejala.firstWhere(
        (g) => g.id == _currentGejalaId!,
        orElse: () => Gejala(id: -1, nama: '--'),
      );
      final namaGejala = gejala.nama;

      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 60),
          Image.asset('images/diagnosisIcons.png', width: 110),
          const SizedBox(height: 20),
          const Text(
            'Mulai Diagnosis Anda',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),
          const SizedBox(
            width: 450,
            child: Text(
              'Jawab beberapa pertanyaan berikut untuk membantu kami memahami kondisi Anda dan memberikan saran yang sesuai.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                color: Colors.black54,
              ),
            ),
          ),
          const SizedBox(height: 30),
          Card(
            color: const Color.fromARGB(255, 235, 250, 255),
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Text(
                'Apakah Anda mengalami "$namaGejala"?',
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () => _answer(true),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 135, 238, 138),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                ),
                child: const Text(
                  'Ya',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () => _answer(false),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 236, 98, 88),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                ),
                child: const Text(
                  'Tidak',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    }

    final hasil = _session.getResult();
    final bool hasAccurate = hasil.akurat.isNotEmpty;
    final bool hasPossible = hasil.kemungkinan.isNotEmpty;

    final String title =
        hasAccurate
            ? 'Diagnosis Akurat'
            : hasPossible
            ? 'Daftar Kemungkinan Penyakit'
            : 'Hasil Tidak Ditemukan';

    final List<Widget> hasilList =
        (hasAccurate
                ? hasil.akurat
                : hasPossible
                ? hasil.kemungkinan
                : [])
            .map((id) {
              final penyakit = semuaPenyakit.firstWhere((p) => p.id == id);
              final pct = _persentase(id);
              final cocokGejala =
                  penyakit.gejalaIds
                      .where((gid) => _session.gejalaYa.contains(gid))
                      .map(
                        (gid) =>
                            semuaGejala.firstWhere((g) => g.id == gid).nama,
                      )
                      .toList();

              return Card(
                color: Colors.white,
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              penyakit.nama,
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text(
                            '${pct.toStringAsFixed(1)}%',
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Gejala yang cocok:',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 4),
                      ...cocokGejala.map(
                        (nama) => Text(
                          '• $nama',
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            })
            .toList();

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 60),
        Image.asset('images/diagnosisIcons.png', width: 110),
        const SizedBox(height: 20),
        Text(
          title,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 15),
        SizedBox(
          width: 440,
          child: Text(
            'Kami menemukan beberapa hal yang bisa memengaruhi kenyamanan Anda. Dengan perhatian yang sesuai, kondisi ini dapat ditangani dengan baik.',
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
              color: Colors.black54,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 15),
        SizedBox(
          height: 300,
          child:
              hasilList.isNotEmpty
                  ? ListView(children: hasilList)
                  : const Center(
                    child: Text(
                      'Maaf, tidak ada diagnosis yang sesuai.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.black54,
                      ),
                    ),
                  ),
        ),
        const SizedBox(height: 30),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.blue[100]),
          onPressed: () {
            setState(() {
              _session = DiagnosaSession();
              _advanceQuestion();
            });
          },
          child: const Text(
            'Mulai Ulang',
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Poppins',
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}
