import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/karyawan_controller.dart';
import '../models/karyawan.dart';

class EditKaryawanView extends StatefulWidget {
  final Karyawan karyawan;

  const EditKaryawanView({super.key, required this.karyawan});

  @override
  _EditKaryawanViewState createState() => _EditKaryawanViewState();
}

class _EditKaryawanViewState extends State<EditKaryawanView> {
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

  @override
  void initState() {
    super.initState();
    namaController.text = widget.karyawan.nama;
    sexController.text = widget.karyawan.sex;
    jabatanController.text = widget.karyawan.jabatan;
    norekController.text = widget.karyawan.norek;
    upahController.text = widget.karyawan.upah;
    kotaLahirController.text = widget.karyawan.kotaLahir;
    tglLahirController.text = widget.karyawan.tglLahir;
    alamatController.text = widget.karyawan.alamat;
    tglMasukController.text = widget.karyawan.tglMasuk;
    tglKeluarController.text = widget.karyawan.tglKeluar ?? '';
    statusController.text = widget.karyawan.status;
  }

  @override
  void dispose() {
    namaController.dispose();
    sexController.dispose();
    jabatanController.dispose();
    norekController.dispose();
    upahController.dispose();
    kotaLahirController.dispose();
    tglLahirController.dispose();
    alamatController.dispose();
    tglMasukController.dispose();
    tglKeluarController.dispose();
    statusController.dispose();
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
      firstDate: DateTime(1950),
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
    final isLaki = sexController.text.toLowerCase().contains('laki');
    final isAktif = statusController.text.toLowerCase().contains('aktif') &&
        !statusController.text.toLowerCase().contains('non');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Data Karyawan'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: namaController,
              decoration: const InputDecoration(labelText: 'Nama Karyawan *'),
            ),
            DropdownButtonFormField<String>(
              value: isLaki ? 'Laki-Laki' : 'Perempuan',
              decoration: const InputDecoration(labelText: 'Jenis Kelamin'),
              items: const [
                DropdownMenuItem(value: 'Laki-Laki', child: Text('Laki-Laki')),
                DropdownMenuItem(value: 'Perempuan', child: Text('Perempuan')),
              ],
              onChanged: (val) {
                if (val != null) sexController.text = val;
              },
            ),
            TextField(
              controller: jabatanController,
              decoration: const InputDecoration(labelText: 'Jabatan *'),
            ),
            TextField(
              controller: norekController,
              decoration: const InputDecoration(labelText: 'No. Rekening *'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: upahController,
              decoration: const InputDecoration(labelText: 'Upah / Gaji *'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: kotaLahirController,
              decoration: const InputDecoration(labelText: 'Kota Lahir *'),
            ),
            TextField(
              controller: tglLahirController,
              readOnly: true,
              onTap: () => _selectDate(context, tglLahirController),
              decoration: InputDecoration(
                labelText: 'Tanggal Lahir (YYYY-MM-DD) *',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: () => _selectDate(context, tglLahirController),
                ),
              ),
            ),
            TextField(
              controller: alamatController,
              decoration: const InputDecoration(labelText: 'Alamat *'),
            ),
            TextField(
              controller: tglMasukController,
              readOnly: true,
              onTap: () => _selectDate(context, tglMasukController),
              decoration: InputDecoration(
                labelText: 'Tanggal Masuk (YYYY-MM-DD) *',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: () => _selectDate(context, tglMasukController),
                ),
              ),
            ),
            TextField(
              controller: tglKeluarController,
              readOnly: true,
              onTap: () => _selectDate(context, tglKeluarController),
              decoration: InputDecoration(
                labelText: 'Tanggal Keluar (Opsional)',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: () => _selectDate(context, tglKeluarController),
                ),
              ),
            ),
            DropdownButtonFormField<String>(
              value: isAktif ? 'Aktif' : 'Nonaktif',
              decoration: const InputDecoration(labelText: 'Status'),
              items: const [
                DropdownMenuItem(value: 'Aktif', child: Text('Aktif')),
                DropdownMenuItem(value: 'Nonaktif', child: Text('Nonaktif')),
              ],
              onChanged: (val) {
                if (val != null) statusController.text = val;
              },
            ),
            const SizedBox(height: 25),
            Obx(() => ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(48),
                  ),
                  onPressed: controller.isLoading.value
                      ? null
                      : () async {
                          final updatedKaryawan = Karyawan(
                            idKar: widget.karyawan.idKar,
                            nama: namaController.text.trim(),
                            sex: sexController.text.trim(),
                            jabatan: jabatanController.text.trim(),
                            norek: norekController.text.trim(),
                            upah: upahController.text.trim(),
                            kotaLahir: kotaLahirController.text.trim(),
                            tglLahir: _formatDate(tglLahirController.text),
                            alamat: alamatController.text.trim(),
                            tglMasuk: _formatDate(tglMasukController.text),
                            tglKeluar: tglKeluarController.text.trim().isNotEmpty
                                ? _formatDate(tglKeluarController.text)
                                : null,
                            status: statusController.text.trim(),
                          );

                          final success = await controller.updateKaryawan(
                            widget.karyawan.idKar!,
                            updatedKaryawan,
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
