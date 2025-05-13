class Penyakit {
  final int id;
  final String nama;
  final List<int> gejalaIds;

  Penyakit({
    required this.id,
    required this.nama,
    required this.gejalaIds,
  });

  @override
  String toString() =>
      'Penyakit(id: $id, nama: $nama, gejalaIds: $gejalaIds)';
}
