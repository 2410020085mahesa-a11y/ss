import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../config.dart';
import '../models/absensi.dart';

class AbsensiController extends GetxController {
  var absensiList = <Absensi>[].obs;
  var isLoading = false.obs;

  String get apiUrl => '$baseUrl/absensi';
  final Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  @override
  void onInit() {
    super.onInit();
    tangkapDataAbsensi();
  }

  Future<void> tangkapDataAbsensi() async {
    isLoading.value = true;
    try {
      final response = await http.get(Uri.parse(apiUrl), headers: headers);
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        absensiList.value =
            data.map((item) => Absensi.fromJson(item)).toList();
      } else {
        throw Exception('Gagal ambil data absensi');
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

  Future<bool> addAbsensi(Absensi absensi) async {
    isLoading.value = true;
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: headers,
        body: json.encode(absensi.toJson()),
      );
      if (response.statusCode == 201 || response.statusCode == 200) {
        await tangkapDataAbsensi();
        Get.snackbar(
          'Sukses',
          'Data absensi berhasil disimpan',
          backgroundColor: const Color(0xFF4CAF50),
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
        return true;
      } else {
        String msg = 'Gagal simpan data absensi';
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

  Future<bool> updateAbsensi(int id, Absensi absensi) async {
    isLoading.value = true;
    try {
      final response = await http.put(
        Uri.parse('$apiUrl/$id'),
        headers: headers,
        body: json.encode(absensi.toJson()),
      );
      if (response.statusCode == 200) {
        await tangkapDataAbsensi();
        Get.snackbar(
          'Sukses',
          'Data absensi berhasil diubah',
          backgroundColor: const Color(0xFF4CAF50),
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
        return true;
      } else {
        String msg = 'Gagal ubah data absensi';
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

  Future<bool> deleteAbsensi(int id) async {
    try {
      final response =
          await http.delete(Uri.parse('$apiUrl/$id'), headers: headers);
      if (response.statusCode == 204 || response.statusCode == 200) {
        absensiList.removeWhere((a) => a.idAbsensi == id);
        Get.snackbar(
          'Sukses',
          'Data absensi berhasil dihapus',
          backgroundColor: const Color(0xFF4CAF50),
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
        return true;
      } else {
        throw Exception('Gagal hapus data absensi');
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
