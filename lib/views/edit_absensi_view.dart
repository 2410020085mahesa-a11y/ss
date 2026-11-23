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

  Future<void> _selectDate(
      BuildContext context, TextEditingController textController) async {
    DateTime initial = DateTime.now();
    try {
      if (textController.text.isNotEmpty) {
        initial = DateTime.parse(textController.text);
      }
    } catch (_) {}

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initial,
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
        title: const Text('Edit Data Absensi'),
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
                          final updatedAbsensi = Absensi(
                            idAbsensi: widget.absensi.idAbsensi,
                            idKar: int.tryParse(idKarController.text.trim()) ??
                                widget.absensi.idKar,
                            namaKar: namaKarController.text.trim(),
                            absen: _formatDate(absenController.text),
                          );

                          final success = await controller.updateAbsensi(
                            widget.absensi.idAbsensi!,
                            updatedAbsensi,
                          );
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
                      : const Text('Simpan Perubahan'),
                )),
          ],
        ),
      ),
    );
  }
}
