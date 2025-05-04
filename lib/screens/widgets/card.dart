import 'package:flutter/material.dart';

class CardPenyakit extends StatelessWidget {
  final String imageName;
  final String title;

  const CardPenyakit({
    super.key,
    required this.imageName,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 16),
          Image.asset(
            'images/$imageName',
            height: 45,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 5),
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
            ),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}

// Tambahan: Kartu Menu (gambar kiri, teks kanan)
class CardMenu extends StatelessWidget {
  final String imagePath;
  final String title;
  final Color? color;
  final Color? textColor;

  const CardMenu({
    super.key,
    required this.imagePath,
    required this.title,
    this.color,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color ?? Color(0xFFbcdbf4),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Image.asset(
              imagePath,
              width: 40,
              height: 40,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.normal,
                  fontFamily: 'Poppins',
                  color: textColor ?? Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
