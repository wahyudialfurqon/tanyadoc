import 'package:flutter/material.dart';
import 'package:pedulitht/screens/data/data.dart';
import 'package:pedulitht/screens/detailPenyakitScreen.dart';
import 'package:pedulitht/screens/models/gejala.dart';
import 'package:pedulitht/screens/models/penyakit.dart';

class AllPenyakitScreen extends StatefulWidget {
  const AllPenyakitScreen({super.key});

  @override
  State<AllPenyakitScreen> createState() => _AllPenyakitScreenState();
}

class _AllPenyakitScreenState extends State<AllPenyakitScreen> {
  final List<String> categories = ['Semua', 'Umum', 'Telinga', 'Hidung', 'Tenggorokan'];
  String selectedCategory = 'Semua';
  String searchQuery = '';

  // Mapping penyakit.id to category
  final Map<int, String> penyakitCategory = {
    0: 'Tenggorokan',  // CONTRACT ULCERS
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
    19: 'Hidung',
    20: 'Hidung',
    // Add more mappings as needed
  };

  @override
  Widget build(BuildContext context) {
    // Filter berdasarkan kategori dan search
    final filtered = semuaPenyakit.where((p) {
      final matchesCategory = selectedCategory == 'Semua' ||
          (penyakitCategory[p.id] ?? 'Semua') == selectedCategory;
      final matchesSearch = p.nama.toLowerCase().contains(searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Penyakit',
        style: TextStyle(fontFamily: 'Poppins')),
        backgroundColor: Colors.blue[400],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Pilihan penyakit berdasarkan kategori dan pencarian. Ketuk untuk melihat detail gejala.',
              style: TextStyle(fontSize: 14, color: Colors.black87),
            ),
            const SizedBox(height: 16),

            // Search Field
            TextField(
              decoration: InputDecoration(
                hintText: 'Cari penyakit...',
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

            // Category Chips
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: categories.map((cat) {
                  final selected = cat == selectedCategory;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: ChoiceChip(
                      label: Text(cat),
                      selected: selected,
                      onSelected: (_) => setState(() => selectedCategory = cat),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 16),

            // List of filtered diseases
            Expanded(
              child: filtered.isEmpty
                  ? const Center(child: Text('Tidak ada penyakit ditemukan.'))
                  : ListView.builder(
                      itemCount: filtered.length,
                      itemBuilder: (context, index) {
                        final penyakit = filtered[index];
                        final gejalaList = penyakit.gejalaIds
                            .map((id) => semuaGejala.firstWhere((g) => g.id == id).nama)
                            .toList();
                        final gejalaText = gejalaList.join(', ');

                        return Card(
                          color: Colors.white,
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          elevation: 2,
                          child: ListTile(
                            title: Text(
                              penyakit.nama,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              gejalaText,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => DetailPenyakit(penyakit: penyakit),
                                ),
                              );
                            },
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
