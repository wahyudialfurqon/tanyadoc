import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pedulitht/screens/allPenyakitScreen.dart';
import 'package:pedulitht/screens/data/data.dart';
import 'package:pedulitht/screens/detailPenyakitScreen.dart';
import 'package:pedulitht/screens/searchScreen.dart';
import 'package:pedulitht/screens/widgets/card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isHovered = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 213, 239, 248),
      body: Stack(
        children: [
          Positioned(
            top: 200,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 243, 253, 255),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(45),
                  topRight: Radius.circular(45),
                ),
              ),
            ),
          ),
          // Pattern hiasan
          Positioned(
            left: 0,
            top: 0,
            child: Image.asset('images/patternR.png', width: 520),
          ),
          Positioned(
            right: 0,
            top: 0,
            child: Image.asset('images/patternL.png', width: 520),
          ),

          // Konten
          Padding(
            padding: const EdgeInsets.only(top: 60),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: const Text(
                    'Hi! Apa yang kamu rasakan\nhari ini?',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                      fontSize: 23,
                      height: 1.2,
                      color: Color.fromARGB(255, 47, 47, 47),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    DateFormat(
                      'EEEE, d MMMM y',
                      'id_ID',
                    ).format(DateTime.now()),
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      color: Color.fromARGB(221, 42, 42, 42),
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 6,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        'images/banner1.png',
                        width: double.infinity,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 6,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: TextField(
                      readOnly: true, // Biar tap tidak memunculkan keyboard
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const SearchScreen(),
                          ),
                        );
                      },
                      decoration: InputDecoration(
                        hintText: 'Cari gejala atau nama penyakit...',
                        contentPadding: const EdgeInsets.only(
                          left: 16,
                          top: 15,
                          bottom: 15,
                        ),
                        suffixIcon: const Padding(
                          padding: EdgeInsets.only(right: 16),
                          child: Icon(Icons.search),
                        ),
                        border: InputBorder.none,
                        hintStyle: TextStyle(color: Colors.grey[600]),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Penyakit Populer',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 15,
                              color: Color.fromARGB(221, 42, 42, 42),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const AllPenyakitScreen(),
                                ),
                              );
                            },
                            child: Text(
                              'Lihat Semua',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 15,
                                color: Color.fromARGB(221, 42, 42, 42),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: ListView(
                    children: [
                      // Grid pertama
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: GridView.count(
                          crossAxisCount: 3,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          crossAxisSpacing: 16,
                          childAspectRatio: 1,
                          children: [
                            CardPenyakit(
                              imageName: 'Faringitis.png',
                              title: 'Faringitis',
                              onTap: () {
                                final penyakit = semuaPenyakit.firstWhere(
                                  (p) =>
                                      p.nama.toLowerCase() ==
                                      'faringitis'.toLowerCase(),
                                );
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) =>
                                            DetailPenyakit(penyakit: penyakit),
                                  ),
                                );
                              },
                            ),
                            CardPenyakit(
                              imageName: 'Sinusitis.png',
                              title: 'Sinusitis',
                              onTap: () {
                                final penyakit = semuaPenyakit.firstWhere(
                                  (p) => p.nama.toLowerCase().contains(
                                    'sinusitis',
                                  ),
                                );
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) =>
                                            DetailPenyakit(penyakit: penyakit),
                                  ),
                                );
                              },
                            ),
                            CardPenyakit(
                              imageName: 'Tonsilitis.png',
                              title: 'Tonsilitis',
                              onTap: () {
                                final penyakit = semuaPenyakit.firstWhere(
                                  (p) => p.nama.toLowerCase() == 'tonsilitis',
                                );
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) =>
                                            DetailPenyakit(penyakit: penyakit),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 40),

                      // Grid kedua responsif
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 80),
                        child: GridView.count(
                          crossAxisCount: 1,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          childAspectRatio: 5.0,
                          children: [
                            GestureDetector(
                              onTap: () {
                                // Menavigasi ke DiagnosisScreen ketika card diklik
                                Navigator.pushNamed(context, '/diagnosis');
                              },
                              child: MouseRegion(
                                onEnter: (_) {
                                  // Tambahkan efek hover, misalnya mengubah warna atau bayangan
                                  setState(() {
                                    _isHovered = true;
                                  });
                                },
                                onExit: (_) {
                                  // Kembalikan efek hover saat pointer keluar
                                  setState(() {
                                    _isHovered = false;
                                  });
                                },
                                child: AnimatedContainer(
                                  duration: Duration(
                                    milliseconds: 300,
                                  ), // Animasi transisi saat hover
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors:
                                          _isHovered
                                              ? [
                                                Color(0xFF1f4571),
                                                Color(0xFF4e7ab7),
                                              ] // Warna saat hover
                                              : [
                                                Color(0xFF1f4571),
                                                Color(0xFF4e7ab7),
                                              ], // Warna default
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color:
                                          _isHovered
                                              ? Colors.blueAccent
                                              : const Color.fromARGB(
                                                255,
                                                91,
                                                150,
                                                253,
                                              ), // Warna border saat hover
                                      width:
                                          _isHovered
                                              ? 2
                                              : 2, // Ketebalan border saat hover
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            _isHovered
                                                ? Colors.blueAccent.withOpacity(
                                                  0.8,
                                                ) // Efek glow saat hover
                                                : Colors.blueAccent.withOpacity(
                                                  0.6,
                                                ),
                                        spreadRadius: 3,
                                        blurRadius:
                                            _isHovered
                                                ? 15
                                                : 10, // Blur lebih besar saat hover
                                        offset: Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'images/periksa.png', // Image inside the button
                                        height: 40,
                                        width: 40,
                                      ),
                                      SizedBox(width: 20),
                                      Text(
                                        'Mulai Diagnosis',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 18),
                      Text(
                        'Cek gejala awal Anda secara cepat dan gratis.',
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  //
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
