import 'package:flutter/material.dart';

class CardPenyakit extends StatelessWidget {
  final String imageName;
  final String title;
  final VoidCallback? onTap; // ✅ tambahkan onTap opsional

  const CardPenyakit({
    super.key,
    required this.imageName,
    required this.title,
    this.onTap, // ✅ inisialisasi
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // ✅ bungkus seluruh Card agar bisa ditekan
      child: Card(
        color: Colors.white,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('images/$imageName', height: 55, fit: BoxFit.contain),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
                height: 1.2,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
