import 'package:flutter/material.dart';
import 'package:pedulitht/screens/data/data.dart';
import 'package:pedulitht/screens/models/gejala.dart';
import 'package:pedulitht/screens/models/penyakit.dart';

class DetailPenyakit extends StatelessWidget {
  final Penyakit penyakit;

  const DetailPenyakit({super.key, required this.penyakit});

  @override
  Widget build(BuildContext context) {
    List<Gejala> gejalaPenyakit = semuaGejala
        .where((gejala) => penyakit.gejalaIds.contains(gejala.id))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Penyakit',
        style: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.bold
        )),
        backgroundColor: Color.fromARGB(255, 159, 212, 255),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              penyakit.nama,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),

            const Text(
              'Gejala yang Ditemukan:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),

            Expanded(
              child: gejalaPenyakit.isEmpty
                  ? const Center(child: Text("Tidak ada gejala terdaftar."))
                  : ListView.separated(
                      itemCount: gejalaPenyakit.length,
                      separatorBuilder: (context, index) => const Divider(),
                      itemBuilder: (context, index) {
                        final gejala = gejalaPenyakit[index];
                        return ListTile(
                          leading: const Icon(Icons.check_circle_outline,
                              color: Colors.green),
                          title: Text(
                            gejala.nama,
                            style: const TextStyle(fontSize: 16),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
