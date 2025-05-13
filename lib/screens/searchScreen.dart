import 'package:flutter/material.dart';
import 'package:pedulitht/screens/data/data.dart';
import 'package:pedulitht/screens/models/gejala.dart';
import 'package:pedulitht/screens/models/penyakit.dart';
import 'package:pedulitht/screens/detailPenyakitScreen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final List<String> categories = [
    'Semua',
    'Umum',
    'Telinga',
    'Hidung',
    'Tenggorokan',
  ];
  String selectedCategory = 'Semua';
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final filtered =
        semuaPenyakit.where((p) {
          final namaMatch = p.nama.toLowerCase().contains(
            searchQuery.toLowerCase(),
          );
          final gejalaMatch = p.gejalaIds
              .map(
                (id) =>
                    semuaGejala
                        .firstWhere((g) => g.id == id)
                        .nama
                        .toLowerCase(),
              )
              .any((nama) => nama.contains(searchQuery.toLowerCase()));
          final matchesSearch =
              searchQuery.isEmpty ? false : (namaMatch || gejalaMatch);
          final matchesCategory =
              selectedCategory == 'Semua' ||
              (penyakitCategory[p.id] ?? 'Semua') == selectedCategory;
          return matchesSearch && matchesCategory;
        }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cari Penyakit & Gejala',
          style: TextStyle(fontFamily: 'Poppins'),
        ),
        backgroundColor: Color.fromARGB(255, 159, 212, 255),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Ketik nama penyakit atau gejala...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
              onChanged: (val) => setState(() => searchQuery = val),
            ),
            const SizedBox(height: 12),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children:
                    categories.map((cat) {
                      final selected = cat == selectedCategory;
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: ChoiceChip(
                          label: Text(cat),
                           selectedColor: const Color.fromARGB(255, 159, 212, 255),
                           backgroundColor: Colors.grey[300],
                          selected: selected,
                          onSelected:
                              (_) => setState(() => selectedCategory = cat),
                        ),
                      );
                    }).toList(),
              ),
            ),
            const SizedBox(height: 16),

            Expanded(
              child:
                  searchQuery.isEmpty
                      ? const Center(
                        child: Text(
                          'Tidak Ada Data Ditemukan',
                          style: TextStyle(fontSize: 16, color: Colors.black54),
                        ),
                      )
                      : filtered.isEmpty
                      ? Center(
                        child: Text(
                          'Tidak Ada Hasil Untuk "\$searchQuery"',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                          ),
                        ),
                      )
                      : ListView.builder(
                        itemCount: filtered.length,
                        itemBuilder: (context, index) {
                          final penyakit = filtered[index];
                          final gejalaList =
                              penyakit.gejalaIds
                                  .map(
                                    (id) =>
                                        semuaGejala
                                            .firstWhere((g) => g.id == id)
                                            .nama,
                                  )
                                  .toList();
                          final gejalaText = gejalaList.join(', ');
                          return Card(
                            color: Colors.white,
                            margin: const EdgeInsets.symmetric(vertical: 6),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 2,
                            child: ListTile(
                              title: Text(
                                penyakit.nama,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                gejalaText,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              onTap:
                                  () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (_) => DetailPenyakit(
                                            penyakit: penyakit,
                                          ),
                                    ),
                                  ),
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

final Map<int, String> penyakitCategory = {
  0: 'Tenggorokan',
  1: 'Tenggorokan',
  2: 'Tenggorokan',
  3: 'Telinga',
  4: 'Hidung',
  5: 'Tenggorokan',
  6: 'Tenggorokan',
  7: 'Tenggorokan',
  8: 'Tenggorokan',
  9: 'Hidung',
  10: 'Tenggorokan',
  11: 'Tenggorokan',
  12: 'Telinga',
  13: 'Telinga',
  14: 'Telinga',
  15: 'Telinga',
  16: 'Tenggorokan',
  17: 'Telinga',
  18: 'Telinga',
  19: 'Hidung',
  20: 'Hidung',
  21: 'Hidung',
  22: 'Umum',
  23: 'Tenggorokan',
  24: 'Hidung',
  25: 'Hidung',
  26: 'Hidung',
  27: 'Hidung',
  28: 'Hidung',
  29: 'Tenggorokan',
  30: 'Tenggorokan',
  31: 'Telinga',
  32: 'Hidung',
  33: 'Telinga',
  34: 'Telinga',
  35: 'Telinga',
  36: 'Tenggorokan',
  37: 'Telinga',
};
