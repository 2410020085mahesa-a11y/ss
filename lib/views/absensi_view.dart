import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/absensi_controller.dart';
import 'edit_absensi_view.dart';
import 'tambah_absensi_view.dart';

class AbsensiView extends StatelessWidget {
  AbsensiView({super.key});

  final AbsensiController controller = Get.put(AbsensiController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Absensi'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: controller.tangkapDataAbsensi,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Get.to(() => TambahAbsensiView());
        },
        icon: const Icon(Icons.add),
        label: const Text('Tambah Absensi'),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.absensiList.isEmpty) {
          return const Center(child: Text('Tidak ada data absensi'));
        }
        return ListView.builder(
          padding: const EdgeInsets.only(bottom: 80),
          itemCount: controller.absensiList.length,
          itemBuilder: (context, index) {
            final a = controller.absensiList[index];
            return Card(
              margin: const EdgeInsets.all(10),
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      a.namaKar,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text('ID Absensi: ${a.idAbsensi}'),
                    Text('ID Karyawan: ${a.idKar}'),
                    Text('Tanggal Absen: ${a.absen}'),
                    const SizedBox(height: 10),
                    OverflowBar(
                      alignment: MainAxisAlignment.end,
                      children: [
                        TextButton.icon(
                          icon: const Icon(Icons.edit, size: 18),
                          label: const Text('Edit'),
                          onPressed: () {
                            Get.to(() => EditAbsensiView(absensi: a));
                          },
                        ),
                        TextButton.icon(
                          icon: const Icon(Icons.delete, size: 18, color: Colors.red),
                          label: const Text('Hapus', style: TextStyle(color: Colors.red)),
                          onPressed: () {
                            Get.defaultDialog(
                              title: 'Konfirmasi',
                              middleText: 'Yakin ingin menghapus absensi ${a.namaKar}?',
                              textConfirm: 'Hapus',
                              textCancel: 'Batal',
                              confirmTextColor: Colors.white,
                              buttonColor: Colors.red,
                              onConfirm: () {
                                controller.deleteAbsensi(a.idAbsensi!);
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
