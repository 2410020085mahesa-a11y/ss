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

  Future<void> _selectDate(
      BuildContext context, TextEditingController textController) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      textController.text =
          "${picked.year.toString().padLeft(4, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
    }
  }

  String _formatDate(String text) {
    final clean = text.trim();
    if (clean.isEmpty) return '';
    try {
      final parts = clean.replaceAll('/', '-').split('-');
      if (parts.length == 3) {
        if (parts[0].length == 4) {
          return "${parts[0]}-${parts[1].padLeft(2, '0')}-${parts[2].padLeft(2, '0')}";
        } else if (parts[2].length == 4) {
          return "${parts[2]}-${parts[1].padLeft(2, '0')}-${parts[0].padLeft(2, '0')}";
        }
      }
    } catch (_) {}
    return clean;
  }

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
              decoration: const InputDecoration(labelText: 'ID Karyawan *'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: namaKarController,
              decoration: const InputDecoration(labelText: 'Nama Karyawan *'),
            ),
            TextField(
              controller: absenController,
              readOnly: true,
              onTap: () => _selectDate(context, absenController),
              decoration: InputDecoration(
                labelText: 'Tanggal Absen (YYYY-MM-DD) *',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: () => _selectDate(context, absenController),
                ),
              ),
            ),
            const SizedBox(height: 25),
            Obx(() => ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(48),
                  ),
                  onPressed: controller.isLoading.value
                      ? null
                      : () async {
                          if (idKarController.text.trim().isEmpty ||
                              namaKarController.text.trim().isEmpty ||
                              absenController.text.trim().isEmpty) {
                            Get.snackbar(
                              'Peringatan',
                              'Semua kolom wajib diisi',
                              backgroundColor: Colors.orange,
                              colorText: Colors.white,
                              snackPosition: SnackPosition.BOTTOM,
                            );
                            return;
                          }

                          final absensi = Absensi(
                            idKar: int.tryParse(idKarController.text.trim()) ?? 0,
                            namaKar: namaKarController.text.trim(),
                            absen: _formatDate(absenController.text),
                          );

                          final success = await controller.addAbsensi(absensi);
                          if (success) {
                            Get.back();
                          }
                        },
                  child: controller.isLoading.value
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Simpan Data Absensi'),
                )),
          ],
        ),
      ),
    );
  }
}
