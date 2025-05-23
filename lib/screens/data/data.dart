import 'package:pedulitht/screens/models/gejala.dart';
import 'package:pedulitht/screens/models/penyakit.dart';

/// Daftar semua gejala 
final List<Gejala> semuaGejala = [
  Gejala(id: 0, nama: 'Demam'),
  Gejala(id: 1, nama: 'Sakit kepala'),
  Gejala(id: 2, nama: 'Nyeri saat bicara atau menelan'),
  Gejala(id: 3, nama: 'Batuk'),
  Gejala(id: 4, nama: 'Hidung tersumbat'),
  Gejala(id: 5, nama: 'Nyeri telinga'),
  Gejala(id: 6, nama: 'Nyeri tenggorokan'),
  Gejala(id: 7, nama: 'Hidung meler'),
  Gejala(id: 8, nama: 'Letih dan lesu'),
  Gejala(id: 9, nama: 'Mual dan muntah'),
  Gejala(id: 10, nama: 'Selaput lendir merah dan bengkak'),
  Gejala(id: 11, nama: 'Ada benjolan di leher'),
  Gejala(id: 12, nama: 'Nyeri leher'),
  Gejala(id: 13, nama: 'Pembengkakan kelenjar getah bening'),
  Gejala(id: 14, nama: 'Pendarahan hidung'),
  Gejala(id: 15, nama: 'Suara serak'),
  Gejala(id: 16, nama: 'Bola mata bergerak tanpa sadar'),
  Gejala(id: 17, nama: 'Dahi sakit'),
  Gejala(id: 18, nama: 'Leher bengkak'),
  Gejala(id: 19, nama: 'Tuli'),
  Gejala(id: 20, nama: 'Ada yang tumbuh di mulut'),
  Gejala(id: 21, nama: 'Air liur menetes'),
  Gejala(id: 22, nama: 'Berat badan turun'),
  Gejala(id: 23, nama: 'Bunyi napas abnormal'),
  Gejala(id: 24, nama: 'Infeksi sinus'),
  Gejala(id: 25, nama: 'Nyeri antara mata'),
  Gejala(id: 26, nama: 'Nyeri pinggir hidung'),
  Gejala(id: 27, nama: 'Nyeri pipi di bawah mata'),
  Gejala(id: 28, nama: 'Nyeri wajah'),
  Gejala(id: 29, nama: 'Perubahan kulit'),
  Gejala(id: 30, nama: 'Perubahan suara'),
  Gejala(id: 31, nama: 'Radang gendang telinga'),
  Gejala(id: 32, nama: 'Sakit gigi'),
  Gejala(id: 33, nama: 'Serangan vertigo'),
  Gejala(id: 34, nama: 'Telinga berdenging'),
  Gejala(id: 35, nama: 'Telinga terasa penuh'),
  Gejala(id: 36, nama: 'Tenggorokan gatal'),
  Gejala(id: 37, nama: 'Tubuh tak seimbang'),
];

/// Daftar semua penyakit beserta aturan gejala 
final List<Penyakit> semuaPenyakit = [
  Penyakit(id: 0, nama: 'CONTRACT ULCERS',         gejalaIds: [2, 15]),
  Penyakit(id: 1, nama: 'ABAES PARAFARINGEAL',     gejalaIds: [2, 18]),
  Penyakit(id: 2, nama: 'ABAES PERITONAILER',      gejalaIds: [0, 1, 6, 13, 15, 21]),
  Penyakit(id: 3, nama: 'BAROTITIS MEDIA',        gejalaIds: [1, 5]),
  Penyakit(id: 4, nama: 'DEVIASI SEPTUM',          gejalaIds: [0, 4, 5, 14, 24, 28]),
  Penyakit(id: 5, nama: 'FARINGITIS',             gejalaIds: [0, 2, 6, 12, 13]),
  Penyakit(id: 6, nama: 'KANKER LARING',          gejalaIds: [2, 3, 6, 12, 15, 22, 23]),
  Penyakit(id: 7, nama: 'KANKER LEHER DAN KEPALA', gejalaIds: [2, 11, 14, 20, 29, 30]),
  Penyakit(id: 8, nama: 'KANKER LEHER METASTATIK', gejalaIds: [11]),
  Penyakit(id: 9, nama: 'KANKER NASOFARING',       gejalaIds: [4, 14]),
  Penyakit(id: 10, nama: 'KANKER TONSIL',          gejalaIds: [6, 11]),
  Penyakit(id: 11, nama: 'LARINGITIS',            gejalaIds: [0, 2, 13, 18, 36]),
  Penyakit(id: 12, nama: 'NEURONITIS VESTIBULARIS', gejalaIds: [9, 16]),
  Penyakit(id: 13, nama: 'OSTEOSKLEROSIS',        gejalaIds: [19, 34]),
  Penyakit(id: 14, nama: 'OTITIS MEDIA AKUT',      gejalaIds: [0, 5, 9, 31]),
  Penyakit(id: 15, nama: 'MENIERE',               gejalaIds: [5, 9, 33, 35]),
  Penyakit(id: 16, nama: 'TONSILITIS',            gejalaIds: [0, 1, 2, 3, 6, 9]),
  Penyakit(id: 17, nama: 'TUMOR SYARAF PENDENGARAN', gejalaIds: [1, 19, 37]),
  Penyakit(id: 18, nama: 'VERTIGO POSTULAR',      gejalaIds: [16]),
  Penyakit(id: 19, nama: 'SINUSITIS MAKSILARIS',  gejalaIds: [0, 1, 3, 4, 7, 8, 10, 27, 32]),
  Penyakit(id: 20, nama: 'SINUSITIS FRONTALIS',    gejalaIds: [0, 1, 3, 4, 7, 8, 10, 17]),
  Penyakit(id: 21, nama: 'SINUSITIS ETMOIDALIS',  gejalaIds: [0, 1, 3, 4, 7, 8, 10, 17, 25, 26]),
  Penyakit(id: 22, nama: 'SINUSITIS SFENOIDALIS', gejalaIds: [0, 1, 3, 4, 5, 7, 8, 10, 11]),
  Penyakit(id: 23, nama: 'PERUT',                 gejalaIds: [0, 1, 2, 3]),
];
