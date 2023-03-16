import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:sisfo_pgt/screen/model/model_mahasiswa.dart';

class DataNilai extends StatefulWidget {
  GoRouterState? goRouterState;
  DataNilai({super.key, required this.goRouterState});

  @override
  State<DataNilai> createState() => _DataNilaiState();
}

class _DataNilaiState extends State<DataNilai> {
  @override
  Widget build(BuildContext context) {
    String namaMhs = widget.goRouterState?.queryParams['nama'] as String;
    String nimMhs = widget.goRouterState?.queryParams['nim'] as String;
    int nimMahasiswa = 0;
    setState(() {
      nimMahasiswa = int.parse(nimMhs);
    });
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Index Prestasi',
          style: TextStyle(color: Colors.black87),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black87),
      ),
      body: FutureBuilder<List<AkademikSiswa>>(
        future: getNilaiMahasiswa(nimMahasiswa),
        builder: (context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            // print(nimMahasiswa.runtimeType);

            return Column(
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 10, left: 15, right: 15),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color.fromRGBO(0, 229, 255, 1),
                              Color.fromARGB(255, 65, 229, 218),
                            ]),
                        // image: const DecorationImage(
                        //     alignment: Alignment.bottomCenter,
                        //     fit: BoxFit.fill,
                        //     image: AssetImage('assets/image/gbr.jpeg')),
                        // borderRadius: BorderRadius.circular(20),
                        // color: Color.fromARGB(255, 231, 231, 231),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(8),
                                child: Text(
                                  'KUMULATIF',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 15),
                                child: Text(
                                  "Default",
                                  style: TextStyle(
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              )
                            ],
                          ),
                          // SizedBox(
                          //   width: 100,
                          //   height: 100,
                          //   child: Image.asset('assets/image/piagam.png'),
                          // )
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: const Padding(
                    padding: EdgeInsets.only(left: 15, top: 25, bottom: 20),
                    child: Text(
                      'Perincian Nilai',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 37, 37, 37)),
                    ),
                  ),
                ),
                Expanded(
                    flex: 5,
                    child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        print(snapshot.data!.length);
                        return Padding(
                          padding: const EdgeInsets.only(
                              left: 15, right: 15, bottom: 15),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 120,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Color.fromARGB(255, 31, 132, 255)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Text(
                                    '${snapshot.data[index].tahunakademik.toString()}',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15, right: 15),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(bottom: 5),
                                            child: Text(
                                              '${snapshot.data[index].dosen}',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            ),
                                          ),
                                          Text(
                                            "${snapshot.data[index].namamk}",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(bottom: 5),
                                            child: Text(
                                              "${snapshot.data[index].akhir.toString()}",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            ),
                                          ),
                                          Text(
                                            'Nilai Akhir',
                                            style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(bottom: 5),
                                            child: Text(
                                              '${snapshot.data[index].huruf}',
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            ),
                                          ),
                                          Text(
                                            'Grade',
                                            style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(bottom: 5),
                                            child: Text(
                                              "${snapshot.data[index].sks.toString()}",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            ),
                                          ),
                                          Text(
                                            'SKS',
                                            style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      physics: BouncingScrollPhysics(),
                    ))
              ],
            );
          }
          return Container();
        },
      ),
    );
  }
}
