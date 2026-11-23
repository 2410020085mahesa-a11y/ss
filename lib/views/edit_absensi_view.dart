import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/absensi_controller.dart';
import '../models/absensi.dart';

class EditAbsensiView extends StatefulWidget {
  final Absensi absensi;

  const EditAbsensiView({super.key, required this.absensi});

  @override
  _EditAbsensiViewState createState() => _EditAbsensiViewState();
}

class _EditAbsensiViewState extends State<EditAbsensiView> {
  final AbsensiController controller = Get.find();

  final TextEditingController idKarController = TextEditingController();
  final TextEditingController namaKarController = TextEditingController();
  final TextEditingController absenController = TextEditingController();

  @override
  void initState() {
    super.initState();
    idKarController.text = widget.absensi.idKar.toString();
    namaKarController.text = widget.absensi.namaKar;
    absenController.text = widget.absensi.absen;
  }

  @override
  void dispose() {
    idKarController.dispose();
    namaKarController.dispose();
    absenController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Data Absensi'),
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
                final updatedAbsensi = Absensi(
                  idAbsensi: widget.absensi.idAbsensi,
                  idKar: int.tryParse(idKarController.text) ?? widget.absensi.idKar,
                  namaKar: namaKarController.text,
                  absen: absenController.text,
                );
                controller.updateAbsensi(widget.absensi.idAbsensi!, updatedAbsensi);
                Get.back();
              },
              child: const Text('Simpan Perubahan'),
            ),
          ],
        ),
      ),
    );
  }
}
