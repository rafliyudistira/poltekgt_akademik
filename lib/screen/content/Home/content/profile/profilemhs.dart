import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:sisfo_pgt/screen/model/model_mahasiswa.dart';

class ProfileMHS extends StatefulWidget {
  GoRouterState? goRouterState;
  ProfileMHS({super.key, required this.goRouterState});

  @override
  State<ProfileMHS> createState() => _ProfileMHSState();
}

class _ProfileMHSState extends State<ProfileMHS> {
  @override
  Widget build(BuildContext context) {
    final String nimMhs = widget.goRouterState!.queryParams['nim'] as String;
    final String namaMhs = widget.goRouterState!.queryParams['nama'] as String;

    int nimMahasiswa = 0;
    setState(() {
      nimMahasiswa = int.parse(nimMhs);
    });

    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: Colors.grey,
              radius: 80,
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 3,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blue.shade200),
                child: FutureBuilder<http.Response>(
                    future: getNimMahasiswa(nimMahasiswa),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        var json = jsonDecode(snapshot.data!.body);
                        print(json['kelas']);

                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text(namaMhs,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500)),
                              Text(json['nim'].toString(),
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500)),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(json['tempatlahir'],
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500)),
                                  Text(' , '),
                                  Text(
                                      DateFormat('dd MMMM yyyy')
                                          .format(DateTime.parse(
                                              json['tanggallahir']))
                                          .toString(),
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500))
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(json['programstudi'],
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500)),
                                  Text(' - '),
                                  Text(json['tahunmasuk'].toString(),
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500)),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text("PA - ${json['pembimbing']}",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500)),
                                ],
                              ),
                            ],
                          ),
                        );
                      }
                      return Container();
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
