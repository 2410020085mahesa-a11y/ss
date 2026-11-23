import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/karyawan_controller.dart';
import '../models/karyawan.dart';

class TambahKaryawanView extends StatelessWidget {
  final KaryawanController controller = Get.find();

  final TextEditingController namaController = TextEditingController();
  final TextEditingController sexController = TextEditingController();
  final TextEditingController jabatanController = TextEditingController();
  final TextEditingController norekController = TextEditingController();
  final TextEditingController upahController = TextEditingController();
  final TextEditingController kotaLahirController = TextEditingController();
  final TextEditingController tglLahirController = TextEditingController();
  final TextEditingController alamatController = TextEditingController();
  final TextEditingController tglMasukController = TextEditingController();
  final TextEditingController tglKeluarController = TextEditingController();
  final TextEditingController statusController = TextEditingController();

  TambahKaryawanView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Data Karyawan'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: namaController,
              decoration: const InputDecoration(labelText: 'Nama Karyawan'),
            ),
            TextField(
              controller: sexController,
              decoration: const InputDecoration(labelText: 'Jenis Kelamin (Laki-Laki / Perempuan)'),
            ),
            TextField(
              controller: jabatanController,
              decoration: const InputDecoration(labelText: 'Jabatan'),
            ),
            TextField(
              controller: norekController,
              decoration: const InputDecoration(labelText: 'No. Rekening'),
            ),
            TextField(
              controller: upahController,
              decoration: const InputDecoration(labelText: 'Upah / Gaji'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: kotaLahirController,
              decoration: const InputDecoration(labelText: 'Kota Lahir'),
            ),
            TextField(
              controller: tglLahirController,
              decoration: const InputDecoration(labelText: 'Tanggal Lahir (YYYY-MM-DD)'),
            ),
            TextField(
              controller: alamatController,
              decoration: const InputDecoration(labelText: 'Alamat'),
            ),
            TextField(
              controller: tglMasukController,
              decoration: const InputDecoration(labelText: 'Tanggal Masuk (YYYY-MM-DD)'),
            ),
            TextField(
              controller: tglKeluarController,
              decoration: const InputDecoration(labelText: 'Tanggal Keluar (Opsional, YYYY-MM-DD)'),
            ),
            TextField(
              controller: statusController,
              decoration: const InputDecoration(labelText: 'Status (Aktif / Nonaktif)'),
            ),
            const SizedBox(height: 25),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(45),
              ),
              onPressed: () {
                final karyawan = Karyawan(
                  nama: namaController.text,
                  sex: sexController.text,
                  jabatan: jabatanController.text,
                  norek: norekController.text,
                  upah: upahController.text,
                  kotaLahir: kotaLahirController.text,
                  tglLahir: tglLahirController.text,
                  alamat: alamatController.text,
                  tglMasuk: tglMasukController.text,
                  tglKeluar: tglKeluarController.text.isNotEmpty
                      ? tglKeluarController.text
                      : null,
                  status: statusController.text.isNotEmpty
                      ? statusController.text
                      : 'Aktif',
                );
                controller.addKaryawan(karyawan);
                Get.back();
              },
              child: const Text('Simpan Data'),
            ),
          ],
        ),
      ),
    );
  }
}
