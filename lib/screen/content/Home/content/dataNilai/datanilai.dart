import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:sisfo_pgt/main.dart';
// import 'package:sisfo_pgt/screen/content/Home/bloc/filter.dart';
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
    // FilterBloc bloc = FilterBloc();
    String namaMhs = widget.goRouterState?.queryParams['nama'] as String;
    String nimMhs = widget.goRouterState?.queryParams['nim'] as String;
    int nimMahasiswa = 0;
    setState(() {
      nimMahasiswa = int.parse(nimMhs);
    });
    var _valTahun;

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
      body: FutureBuilder<http.Response>(
          future: getIpkMahasiswa(nimMahasiswa),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var json = jsonDecode(snapshot.data!.body);
              // print(json);

              return FutureBuilder<List<AkademikSiswa>>(
                future: getNilaiMahasiswa(nimMahasiswa),
                builder: (context, AsyncSnapshot<dynamic> snapshotIN) {
                  if (snapshotIN.hasData) {
                    // print(nimMahasiswa.runtimeType);
                    // print(snapshotIN.data.runtimeType);

                    List tahun = [];

                    List filteredTahun = [];
                    // var Testing = [];
                    // var Testing1 = [];

                    for (int i = 0; i < snapshotIN.data.length; i++) {
                      tahun.add(snapshotIN.data[i].tahunakademik);
                      filteredTahun.add(snapshotIN.data[i].tahunakademik);

                      print(snapshotIN.data[i]);
                    }
                    var tahunak = tahun.toSet().toList();
                    int tahunAkademik = int.parse(tahun[0]);
                    // print(Testing[1].nama);
                    // print("${tahunak} - TESTING");

                    // void _filterTahun(value) {
                    //   setState(() {
                    //     for (int i = 0; i < Testing1.length; i++) {
                    //       Testing1.add(Testing.where(
                    //           (x) => x[i].tahunakademik == 20202));

                    //       print("${Testing1[i].tahunakademik} - Helaw");
                    //     }
                    //   });
                    // }

                    // List<AkademikSiswa> main_nilai = [];
                    // List<AkademikSiswa> display_nilai = [];

                    // // List<AkademikSiswa> display_nilai = List.from(main_nilai);
                    // for (int i = 0; i < snapshotIN.data.length; i++) {
                    //   main_nilai.add(snapshotIN.data[i]);
                    //   print("FOR LOP!");
                    // }

                    // display_nilai = main_nilai
                    //     .where((x) => x.tahunakademik
                    //         .toString()
                    //         .contains(inputControl.text))
                    //     .toList();

                    // print(main_nilai.length);
                    // print(display_nilai.length);

                    // void updateList(String value) {
                    //   setState(() {
                    //     display_nilai = main_nilai
                    //         .where((element) => element.tahunakademik == 20211)
                    //         .toList();
                    //     print("${display_nilai} === DISPLAY NILAI VOID");
                    //   });
                    //   print('PULANG');
                    // }

                    // print("${main_nilai} +++ XXX");
                    // print("${display_nilai} === DISPLAY");

                    return Column(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 10, left: 15, right: 15),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 150,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: Color.fromARGB(255, 195, 195, 195)
                                          .withOpacity(0.7),
                                      spreadRadius: 5,
                                      blurRadius: 4,
                                      offset: Offset(0, 3))
                                ],
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                          '0'
                                          // '${json['akademik'].toString()}'
                                          ,
                                          style: TextStyle(
                                              fontSize: 40,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    width: 100,
                                    height: 100,
                                    child:
                                        Image.asset('assets/image/piagam.png'),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: EdgeInsets.only(top: 25, bottom: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  'Perincian Nilai',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 37, 37, 37)),
                                ),

                                DropdownButton(
                                  hint: Text("Tahun"),
                                  value: _valTahun,
                                  items: tahunak.map((value) {
                                    return DropdownMenuItem(
                                      child: Text(value),
                                      value: value,
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      _valTahun = value.toString();

                                      print(
                                          "${tahunAkademik.runtimeType} - HELLOW"); //Untuk memberitahu _valFriends bahwa isi nya akan diubah sesuai dengan value yang kita pilih
                                    });
                                  },
                                ),
                                // Container(
                                //   width: 180,
                                //   height: 100,
                                //   child: TextField(
                                //     // onChanged: (value) => updateList(value),
                                //     controller: inputControl,
                                //     style: TextStyle(color: Colors.white),
                                //     decoration: InputDecoration(
                                //         filled: true,
                                //         fillColor:
                                //             Color.fromARGB(255, 226, 226, 226),
                                //         border: OutlineInputBorder(
                                //             borderRadius:
                                //                 BorderRadius.circular(10),
                                //             borderSide: BorderSide.none),
                                //         hintText: 'Cari Tahun Ajaran',
                                //         prefixIcon: Icon(Icons.search),
                                //         prefixIconColor: Colors.white),
                                //   ),
                                // )
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                            flex: 5,
                            child: ListView.builder(
                              itemCount: snapshotIN.data.length,
                              itemBuilder: (context, index) {
                                print(snapshotIN.data.length);
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15, right: 15, bottom: 15),
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width - 50,
                                    height: 160,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color:
                                            Color.fromARGB(255, 31, 132, 255)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(15),
                                          child: Text(
                                            '${snapshotIN.data[index].tahunakademik.toString()}',
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
                                                    padding: EdgeInsets.only(
                                                        bottom: 5),
                                                    child: SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              1.3,
                                                      child: Text(
                                                        '${snapshotIN.data[index].dosen}',
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.white),
                                                        overflow:
                                                            TextOverflow.clip,
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    "${snapshotIN.data[index].namamk}",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                right: 5,
                                                                top: 10),
                                                        child: Column(
                                                          children: [
                                                            Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      bottom:
                                                                          5),
                                                              child: Text(
                                                                "${snapshotIN.data[index].akhir.toString()}",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        18,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                            ),
                                                            Text(
                                                              'Nilai Akhir',
                                                              style: TextStyle(
                                                                  fontSize: 10,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 5,
                                                                right: 5,
                                                                top: 10),
                                                        child: Column(
                                                          children: [
                                                            Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      bottom:
                                                                          5),
                                                              child: Text(
                                                                '${snapshotIN.data[index].huruf}',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        18,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                            ),
                                                            Text(
                                                              'Grade',
                                                              style: TextStyle(
                                                                  fontSize: 10,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 5,
                                                                top: 10),
                                                        child: Column(
                                                          children: [
                                                            Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      bottom:
                                                                          5),
                                                              child: Text(
                                                                "${snapshotIN.data[index].sks.toString()}",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        18,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                            ),
                                                            Text(
                                                              'SKS',
                                                              style: TextStyle(
                                                                  fontSize: 10,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
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
              );
            }
            return Container();
          }),
    );
  }
}
