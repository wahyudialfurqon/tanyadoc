import 'package:flutter/material.dart';

class RiwayatScreen extends StatefulWidget {
  const RiwayatScreen({super.key});

  @override
  State<RiwayatScreen> createState() => _RiwayatScreenState();
}

class _RiwayatScreenState extends State<RiwayatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 60),
          child: Column(
            children: [
              Image.asset('images/iconRiwayat.png', width: 150),
              const SizedBox(height: 15),
              Text(
                'Riwayat Kesehatan Anda',
                style: TextStyle(fontFamily: 'Poppins', fontSize: 23),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  width: 590,
                  child: Text(
                    'Telusuri hasil diagnosis sebelumnya untuk memantau kondisi kesehatan Anda dari waktu ke waktu. Semua data tersimpan dengan rapi dan mudah diakses kapan saja.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 12,
                      color: Colors.black45,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'History',
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'Poppins',
                        color: Colors.black54,
                      ),
                    ),
                    Text(
                      'Clear All',
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'Poppins',
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
