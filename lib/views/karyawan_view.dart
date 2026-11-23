import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/karyawan_controller.dart';
import 'edit_karyawan_view.dart';
import 'tambah_karyawan_view.dart';

class KaryawanView extends StatelessWidget {
  KaryawanView({super.key});

  final KaryawanController controller = Get.put(KaryawanController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Karyawan'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: controller.tangkapDataKaryawan,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Get.to(() => TambahKaryawanView());
        },
        icon: const Icon(Icons.add),
        label: const Text('Tambah Karyawan'),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.karyawanList.isEmpty) {
          return const Center(child: Text('Tidak ada data karyawan'));
        }
        return ListView.builder(
          padding: const EdgeInsets.only(bottom: 80),
          itemCount: controller.karyawanList.length,
          itemBuilder: (context, index) {
            final k = controller.karyawanList[index];
            return Card(
              margin: const EdgeInsets.all(10),
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      k.nama,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text('ID: ${k.idKar}'),
                    Text('Jabatan: ${k.jabatan}'),
                    Text('Jenis Kelamin: ${k.sex}'),
                    Text('No. Rekening: ${k.norek}'),
                    Text('Upah: ${k.upah}'),
                    Text('Tempat, Tgl Lahir: ${k.kotaLahir}, ${k.tglLahir}'),
                    Text('Alamat: ${k.alamat}'),
                    Text('Tgl Masuk: ${k.tglMasuk}'),
                    Text('Tgl Keluar: ${k.tglKeluar ?? '-'}'),
                    Text('Status: ${k.status}'),
                    const SizedBox(height: 10),
                    OverflowBar(
                      alignment: MainAxisAlignment.end,
                      children: [
                        TextButton.icon(
                          icon: const Icon(Icons.edit, size: 18),
                          label: const Text('Edit'),
                          onPressed: () {
                            Get.to(() => EditKaryawanView(karyawan: k));
                          },
                        ),
                        TextButton.icon(
                          icon: const Icon(Icons.delete, size: 18, color: Colors.red),
                          label: const Text('Hapus', style: TextStyle(color: Colors.red)),
                          onPressed: () {
                            Get.defaultDialog(
                              title: 'Konfirmasi',
                              middleText: 'Yakin ingin menghapus ${k.nama}?',
                              textConfirm: 'Hapus',
                              textCancel: 'Batal',
                              confirmTextColor: Colors.white,
                              buttonColor: Colors.red,
                              onConfirm: () {
                                controller.deleteKaryawan(k.idKar!);
                                Get.back();
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
