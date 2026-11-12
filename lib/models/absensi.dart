class Absensi {
  final int? idAbsensi;
  final int idKar;
  final String namaKar;
  final String absen;

  Absensi({
    this.idAbsensi,
    required this.idKar,
    required this.namaKar,
    required this.absen,
  });

  factory Absensi.fromJson(Map<String, dynamic> json) {
    return Absensi(
      idAbsensi: json['id_absensi'],
      idKar: json['id_kar'],
      namaKar: json['nama_kar'],
      absen: json['absen'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_kar': idKar,
      'nama_kar': namaKar,
      'absen': absen,
    };
  }
}