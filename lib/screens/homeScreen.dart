import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pedulitht/screens/widgets/card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
                      decoration: InputDecoration(
                        hintText: 'Cari gejala atau nama penyakit...',
                        contentPadding: EdgeInsets.only(
                          left: 16,
                          top: 15,
                          bottom: 15,
                        ),
                        suffixIcon: Padding(
                          padding: EdgeInsets.only(
                            right: 16,
                          ), // padding kanan untuk ikon
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
                          Text(
                            'Lihat Semua',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 15,
                              color: Color.fromARGB(221, 42, 42, 42),
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
                          mainAxisSpacing: 16,
                          childAspectRatio: 1,
                          children: const [
                            CardPenyakit(
                              imageName: 'Faringitis.png',
                              title: 'Faringitis',
                            ),
                            CardPenyakit(
                              imageName: 'Sinusitis.png',
                              title: 'Sinusitis',
                            ),
                            CardPenyakit(
                              imageName: 'Tonsilitis.png',
                              title: 'Tonsilitis',
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Grid kedua responsif
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: GridView.count(
                          crossAxisCount: 2,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          crossAxisSpacing: 12,
                          childAspectRatio: 2.5,
                          children: [
                            GestureDetector(
                              onTap: () {
                                // Menavigasi ke DiagnosisScreen ketika card diklik
                                Navigator.pushNamed(context, '/diagnosis');
                              },
                              child: const CardMenu(
                                imagePath: 'images/periksa.png',
                                title: 'Mulai Diagnosis',
                                color: Color(0xFF1f4571),
                                textColor: Colors.white,
                              ),
                            ),
                            const CardMenu(
                              imagePath: 'images/gejala.png',
                              title: 'Kenali Gejala',
                            ),
                          ],
                        ),
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
