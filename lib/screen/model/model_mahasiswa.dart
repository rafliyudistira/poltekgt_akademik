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

  factory AkademikSiswa.fromJson(Map<String, dynamic> json) => AkademikSiswa(
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

class Logkondite {
  final String nim;
  final String nama;
  final String jenispoin;
  final String poin;
  final String keterangan;
  final String tahun;
  final String prodi;
  final String tanggal;

  Logkondite({
    required this.nim,
    required this.nama,
    required this.jenispoin,
    required this.poin,
    required this.keterangan,
    required this.tahun,
    required this.prodi,
    required this.tanggal,
  });

  factory Logkondite.fromJson(Map<String, dynamic> json) {
    return Logkondite(
      nim: json['nim'],
      nama: json['nama'],
      jenispoin: json['jenispoin'],
      poin: json['poin'],
      keterangan: json['keterangan'],
      tahun: json['tahun'],
      prodi: json['prodi'],
      tanggal: json['tanggal'],
    );
  }
}

String ipSaya = "192.168.43.34";

class NilaiAkademikApi {
  static Future<List<AkademikSiswa>> getAkademik(String query, int nim) async {
    final url = Uri.parse("http://${ipSaya}/back_sisfo/filter-tahun/${nim}");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List nilai = json.decode(response.body);
      return nilai.map((json) => AkademikSiswa.fromJson(json)).where((nilai) {
        final tahunLower = nilai.tahunakademik.toLowerCase();
        final searchLower = query.toLowerCase();

        return tahunLower.contains(searchLower);
      }).toList();
    } else {
      throw Exception();
    }
  }
}

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

Future<http.Response> getIpkMahasiswa(int nim) async {
  var result = await http
      .get(Uri.parse("http://${ipSaya}/back_sisfo/akademik-mahasiswa/${nim}"));

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

Future<List<Logkondite>> getLogkondite(int nim) async {
  var result = await http.get(
      Uri.parse("http://${ipSaya}/back_sisfo/logkondite-mahasiswa/${nim}"));
  Iterable i = jsonDecode(result.body);

  List<Logkondite> dataLog =
      List<Logkondite>.from(i.map((e) => Logkondite.fromJson(e)));
  if (result.statusCode == 200) {
    return dataLog;
  } else {
    throw Exception('Failed to load data');
  }
}

Future<List<AkademikSiswa>> filterTahun(int nim, int tahun) async {
  var result = await http
      .get(Uri.parse("http://${ipSaya}/back_sisfo/filter/${nim}/${tahun}"));
  Iterable i = jsonDecode(result.body);

  List<AkademikSiswa> dataMhs =
      List<AkademikSiswa>.from(i.map((e) => AkademikSiswa.fromJson(e)));

  if (result.statusCode == 200) {
    return dataMhs;
  } else {
    throw Exception('Failed to load data');
  }
}
