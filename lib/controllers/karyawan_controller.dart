import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../config.dart';
import '../models/karyawan.dart';

class KaryawanController extends GetxController {
  var karyawanList = <Karyawan>[].obs;
  var isLoading = false.obs;

  String get apiUrl => '$baseUrl/karyawan';
  final Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  @override
  void onInit() {
    super.onInit();
    tangkapDataKaryawan();
  }

  Future<void> tangkapDataKaryawan() async {
    isLoading.value = true;
    try {
      final response = await http.get(Uri.parse(apiUrl), headers: headers);
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        karyawanList.value =
            data.map((item) => Karyawan.fromJson(item)).toList();
      } else {
        throw Exception('Gagal ambil data karyawan');
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        backgroundColor: const Color(0xFFE53935),
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> addKaryawan(Karyawan karyawan) async {
    isLoading.value = true;
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: headers,
        body: json.encode(karyawan.toJson()),
      );
      if (response.statusCode == 201 || response.statusCode == 200) {
        await tangkapDataKaryawan();
        Get.snackbar(
          'Sukses',
          'Data karyawan berhasil disimpan',
          backgroundColor: const Color(0xFF4CAF50),
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
        return true;
      } else {
        String msg = 'Gagal simpan data karyawan';
        try {
          final err = json.decode(response.body);
          if (err['message'] != null) msg = err['message'];
        } catch (_) {}
        Get.snackbar(
          'Gagal Simpan',
          msg,
          backgroundColor: const Color(0xFFE53935),
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
        return false;
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        backgroundColor: const Color(0xFFE53935),
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> updateKaryawan(int id, Karyawan karyawan) async {
    isLoading.value = true;
    try {
      final response = await http.put(
        Uri.parse('$apiUrl/$id'),
        headers: headers,
        body: json.encode(karyawan.toJson()),
      );
      if (response.statusCode == 200) {
        await tangkapDataKaryawan();
        Get.snackbar(
          'Sukses',
          'Data karyawan berhasil diubah',
          backgroundColor: const Color(0xFF4CAF50),
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
        return true;
      } else {
        String msg = 'Gagal ubah data karyawan';
        try {
          final err = json.decode(response.body);
          if (err['message'] != null) msg = err['message'];
        } catch (_) {}
        Get.snackbar(
          'Gagal Ubah',
          msg,
          backgroundColor: const Color(0xFFE53935),
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
        return false;
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        backgroundColor: const Color(0xFFE53935),
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> deleteKaryawan(int id) async {
    try {
      final response =
          await http.delete(Uri.parse('$apiUrl/$id'), headers: headers);
      if (response.statusCode == 204 || response.statusCode == 200) {
        karyawanList.removeWhere((k) => k.idKar == id);
        Get.snackbar(
          'Sukses',
          'Data karyawan berhasil dihapus',
          backgroundColor: const Color(0xFF4CAF50),
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
        return true;
      } else {
        throw Exception('Gagal hapus data karyawan');
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        backgroundColor: const Color(0xFFE53935),
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }
  }
}
