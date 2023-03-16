import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class MahasiswaModel {
  final int nim;
  final String nama;
  final String jenisKelamin;
  final String programStudi;
  final String tempatLahir;
  final DateTime tanggalLahir;
  final int tahunMasuk;
  final String status;
  final String kelas;
  final String password;
  final String pembimbing;

  MahasiswaModel({
    required this.nim,
    required this.nama,
    required this.jenisKelamin,
    required this.programStudi,
    required this.tempatLahir,
    required this.tanggalLahir,
    required this.tahunMasuk,
    required this.status,
    required this.kelas,
    required this.password,
    required this.pembimbing,
  });

  factory MahasiswaModel.fromJson(Map<String, dynamic> json) {
    return MahasiswaModel(
        nim: json['nim'],
        nama: json['nama'],
        jenisKelamin: json['jeniskelamin'],
        programStudi: json['programstudi'],
        tempatLahir: json['tempatlahir'],
        tanggalLahir: json['tanggallahir'],
        tahunMasuk: json['tahunmasuk'],
        status: json['status'],
        kelas: json['kelas'],
        password: json['password'],
        pembimbing: json['pembimbing']);
  }
}

class AkademikSiswa {
  final String nim;
  final String nama;
  final String uts;
  final String uas;
  final String tugas;
  final String kuis;
  final String akhir;
  final String huruf;
  final String angka;
  final String kodemk;
  final String namamk;
  final String sks;
  final String tahunakademik;
  final String prodi;
  final String dosen;
  final String kelas;
  final String status;
  final String statusmk;

  AkademikSiswa(
      {required this.nim,
      required this.nama,
      required this.uts,
      required this.uas,
      required this.tugas,
      required this.kuis,
      required this.akhir,
      required this.huruf,
      required this.angka,
      required this.kodemk,
      required this.namamk,
      required this.sks,
      required this.tahunakademik,
      required this.prodi,
      required this.dosen,
      required this.kelas,
      required this.status,
      required this.statusmk});

  factory AkademikSiswa.fromJson(Map<String, dynamic> json) {
    return AkademikSiswa(
        nim: json['nim'],
        nama: json['nama'],
        uts: json['uts'],
        uas: json['uas'],
        tugas: json['tugas'],
        kuis: json['kuis'],
        akhir: json['akhir'],
        huruf: json['huruf'],
        angka: json['angka'],
        kodemk: json['kodemk'],
        namamk: json['namamk'],
        sks: json['sks'],
        tahunakademik: json['tahunakademik'],
        prodi: json['prodi'],
        dosen: json['dosen'],
        kelas: json['kelas'],
        status: json['status'],
        statusmk: json['statusmk']);
  }
}

String ipSaya = "192.168.137.235";

Future<List<MahasiswaModel>> getAllMahasiswa() async {
  var result =
      await http.get(Uri.parse("http://${ipSaya}/back_sisfo/all-mahasiswa"));
  Iterable i = jsonDecode(result.body);

  List<MahasiswaModel> dataMhs =
      List<MahasiswaModel>.from(i.map((e) => MahasiswaModel.fromJson(e)));
  if (result.statusCode == 200) {
    return dataMhs;
  } else {
    throw Exception('Failed to load data');
  }
}

Future<http.Response> getNimMahasiswa(int nim) async {
  var result =
      await http.get(Uri.parse("http://${ipSaya}/back_sisfo/mahasiswa/${nim}"));

  return result;
}

Future<http.Response> get(int nim) async {
  var result =
      await http.get(Uri.parse("http://${ipSaya}/back_sisfo/mahasiswa/${nim}"));

  return result;
}

Future<List<AkademikSiswa>> getNilaiMahasiswa(int nim) async {
  var result = await http
      .get(Uri.parse("http://${ipSaya}/back_sisfo/nilai-mahasiswa/${nim}"));
  Iterable i = jsonDecode(result.body);

  List<AkademikSiswa> dataMhs =
      List<AkademikSiswa>.from(i.map((e) => AkademikSiswa.fromJson(e)));
  if (result.statusCode == 200) {
    return dataMhs;
  } else {
    throw Exception('Failed to load data');
  }
}
