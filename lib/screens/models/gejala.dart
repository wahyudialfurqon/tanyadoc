class Gejala {
  final int id;
  final String nama;
  bool dipilih;

  Gejala({
    required this.id,
    required this.nama,
    this.dipilih = false,
  });

  @override
  String toString() => 'Gejala(id: $id, nama: $nama, dipilih: $dipilih)';
}
