class Gejala {
  final int id;
  final String nama;
  bool dipilih;

  Gejala({
    required this.id,
    required this.nama,
    this.dipilih = false,
  });

  /// Untuk mempermudah debug / print
  @override
  String toString() => 'Gejala(id: $id, nama: $nama, dipilih: $dipilih)';
}
