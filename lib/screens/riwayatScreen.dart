import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class RiwayatScreen extends StatefulWidget {
  const RiwayatScreen({super.key});

  @override
  State<RiwayatScreen> createState() => _RiwayatScreenState();
}

class _RiwayatScreenState extends State<RiwayatScreen> {
  List<Map<String, dynamic>> _riwayat = [];

  @override
  void initState() {
    super.initState();
    _muatRiwayat();
  }

  Future<void> _muatRiwayat() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getStringList('riwayat') ?? [];
    setState(() {
      _riwayat =
          data.map((item) => jsonDecode(item) as Map<String, dynamic>).toList();
    });
  }

  Future<void> _hapusRiwayat() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('riwayat');
    setState(() {
      _riwayat.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:
          _riwayat.isEmpty
              ? Center(child: Text('Belum ada riwayat diagnosa'))
              : ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Riwayat Diagnosa',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: _hapusRiwayat,
                        child: const Text(
                          'Clear All',
                          style: TextStyle(
                            color: Colors.red,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ),
                    ],
                  ),
                  ..._riwayat.map((item) {
                    final nama = item['penyakit'];
                    final waktu = item['waktu'];
                    final gejala = List<String>.from(item['gejala']);
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              nama,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Poppins',
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              'Gejala: ${gejala.join(', ')}',
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 13,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              'Tanggal: ${DateTime.parse(waktu).toLocal().toString().split('.')[0]}',
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ],
              ),
    );
  }
}
