import 'package:flutter/material.dart';
import 'package:pedulitht/screens/data/data.dart';
import 'package:pedulitht/screens/models/gejala.dart';
import 'package:pedulitht/screens/services/diagnosa_service.dart';
import 'package:pedulitht/screens/services/diagnosa_session.dart';

class DiagnosisScreen extends StatefulWidget {
  const DiagnosisScreen({super.key});

  @override
  State<DiagnosisScreen> createState() => _DiagnosisScreenState();
}

class _DiagnosisScreenState extends State<DiagnosisScreen> {
  late DiagnosaSession _session;
  int? _currentGejalaId;

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
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Diagnosis Penyakit'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    if (!_session.isFinished && _currentGejalaId != null) {
      // Ambil nama gejala dari list semuaGejala
      final gejala = semuaGejala.firstWhere(
        (g) => g.id == _currentGejalaId!,
        orElse: () => Gejala(id: -1, nama: '--'),
      );
      final namaGejala = gejala.nama;

      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Text(
                'Apakah Anda mengalami "$namaGejala"?',
                style: Theme.of(context).textTheme.titleLarge,
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
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                child: const Text('Ya'),
              ),
              ElevatedButton(
                onPressed: () => _answer(false),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                child: const Text('Tidak'),
              ),
            ],
          ),
        ],
      );
    }

    final hasil = _session.getResult();
    if (hasil.akurat.isNotEmpty) {
      final penyakit = semuaPenyakit
          .where((p) => hasil.akurat.contains(p.id))
          .map((p) => p.nama)
          .join(', ');
      return _buildResultCard(
        title: 'Diagnosis Tepat',
        content: 'Kemungkinan penyakit: $penyakit',
      );
    } else if (hasil.kemungkinan.isNotEmpty) {
      final listNama = semuaPenyakit
          .where((p) => hasil.kemungkinan.contains(p.id))
          .map((p) => p.nama)
          .toList();
      return _buildResultCard(
        title: 'Daftar Kemungkinan',
        content: listNama.map((n) => '• $n').join('\n'),
      );
    } else {
      return _buildResultCard(
        title: 'Hasil Tidak Ditemukan',
        content: 'Maaf, tidak ada diagnosis yang sesuai.',
      );
    }
  }

  Widget _buildResultCard({required String title, required String content}) {
    return Center(
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              Text(
                content,
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _session = DiagnosaSession();
                    _advanceQuestion();
                  });
                },
                child: const Text('Mulai Ulang'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}