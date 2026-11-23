import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/absensi_controller.dart';
import '../models/absensi.dart';

class TambahAbsensiView extends StatelessWidget {
  final AbsensiController controller = Get.find();

  final TextEditingController idKarController = TextEditingController();
  final TextEditingController namaKarController = TextEditingController();
  final TextEditingController absenController = TextEditingController();

  TambahAbsensiView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Data Absensi'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: idKarController,
              decoration: const InputDecoration(labelText: 'ID Karyawan'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: namaKarController,
              decoration: const InputDecoration(labelText: 'Nama Karyawan'),
            ),
            TextField(
              controller: absenController,
              decoration: const InputDecoration(labelText: 'Tanggal Absen (YYYY-MM-DD)'),
            ),
            const SizedBox(height: 25),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(45),
              ),
              onPressed: () {
                final absensi = Absensi(
                  idKar: int.tryParse(idKarController.text) ?? 0,
                  namaKar: namaKarController.text,
                  absen: absenController.text,
                );
                controller.addAbsensi(absensi);
                Get.back();
              },
              child: const Text('Simpan Data Absensi'),
            ),
          ],
        ),
      ),
    );
  }
}
