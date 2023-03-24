import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:sisfo_pgt/screen/model/model_mahasiswa.dart';

class Point extends StatefulWidget {
  GoRouterState? goRouterState;
  Point({super.key, required this.goRouterState});

  @override
  State<Point> createState() => _PointState();
}

class _PointState extends State<Point> {
  @override
  Widget build(BuildContext context) {
    final String nimMhs = widget.goRouterState!.queryParams['nim'] as String;
    final String namaMhs = widget.goRouterState!.queryParams['nama'] as String;

    int nimMahasiswa = 0;
    setState(() {
      nimMahasiswa = int.parse(nimMhs);
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Catatan Poin Ku',
          style: TextStyle(color: Colors.black87),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black87),
      ),
      body: FutureBuilder<List<Logkondite>>(
        future: getLogkondite(nimMahasiswa),
        builder: (context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            int plus = 0;
            int minus = 0;
            for (var i = 0; i < snapshot.data!.length; i++) {
              if (snapshot.data[i].jenispoin == 'Plus') {
                plus += int.parse(snapshot.data[i].poin);
              } else {
                minus += int.parse(snapshot.data[i].poin);
              }
            }
            int jumlah = plus + (minus);
            print(plus);
            print(minus);
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: Padding(
                      padding:
                          const EdgeInsets.only(top: 30, left: 15, right: 5),
                      child: Container(
                        width: 130,
                        height: 100,
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
                            color: Color.fromARGB(255, 31, 132, 255)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 15),
                                  child: Text(
                                    'PLUS',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 15),
                                  child: Text(
                                    plus.toString(),
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              width: 80,
                              height: 50,
                              child: Image.asset('assets/image/plus.png'),
                            )
                          ],
                        ),
                      ),
                    )),
                    Expanded(
                        child: Padding(
                      padding:
                          const EdgeInsets.only(top: 30, right: 15, left: 5),
                      child: Container(
                        width: 130,
                        height: 100,
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
                            color: Color.fromARGB(255, 255, 53, 53)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 15),
                                  child: Text(
                                    'MINUS',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 15),
                                  child: Text(
                                    minus.toString(),
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              width: 80,
                              height: 50,
                              child: Image.asset('assets/image/minus.png'),
                            )
                          ],
                        ),
                      ),
                    )),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
                  child: Container(
                    width: 350,
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
                        image: const DecorationImage(
                            alignment: Alignment.bottomCenter,
                            fit: BoxFit.fill,
                            image: AssetImage('assets/image/gbr.jpeg')),
                        borderRadius: BorderRadius.circular(20),
                        color: Color.fromARGB(255, 231, 231, 231)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 15, bottom: 5),
                              child: Text(
                                'TOTAL',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 15),
                              child: Text(
                                jumlah.toString(),
                                style: TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 15),
                              child: SizedBox(
                                width: 200,
                                child: Text(
                                  'Tingkatkan terus, ${namaMhs}!',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                  overflow: TextOverflow.clip,
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          width: 100,
                          height: 65,
                          child: Image.asset('assets/image/tick.png'),
                        )
                      ],
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 15, top: 25, bottom: 20),
                  child: Text(
                    'Perincian Poin',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 37, 37, 37)),
                  ),
                ),
                Expanded(
                    flex: 5,
                    child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        print(snapshot.data!.length);
                        if (snapshot.data[index].jenispoin == 'Plus') {
                          return Padding(
                            padding: const EdgeInsets.only(
                                left: 15, right: 15, bottom: 15),
                            child: Container(
                              width: MediaQuery.of(context).size.width - 50,
                              height: 160,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Color.fromARGB(255, 31, 132, 255)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: Text(
                                      'Tanggal ${snapshot.data[index].tanggal}',
                                      style: TextStyle(
                                          fontSize: 15,
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
                                              padding:
                                                  EdgeInsets.only(bottom: 8),
                                              child: SizedBox(
                                                width: 300,
                                                child: Text(
                                                  '${snapshot.data[index].keterangan}',
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white),
                                                  overflow: TextOverflow.clip,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10),
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 10),
                                                    child: Text(
                                                      "${snapshot.data[index].jenispoin}",
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                  Text(
                                                    "${snapshot.data[index].poin}",
                                                    style: TextStyle(
                                                        fontSize: 30,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white),
                                                  ),
                                                ],
                                              ),
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
                        } else {
                          return Padding(
                            padding: const EdgeInsets.only(
                                left: 15, right: 15, bottom: 15),
                            child: Container(
                              width: MediaQuery.of(context).size.width - 50,
                              height: 160,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Color.fromARGB(255, 255, 31, 31)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: Text(
                                      'Tanggal ${snapshot.data[index].tanggal}',
                                      style: TextStyle(
                                          fontSize: 15,
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
                                              padding:
                                                  EdgeInsets.only(bottom: 8),
                                              child: Text(
                                                '${snapshot.data[index].keterangan}',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                                overflow: TextOverflow.clip,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10),
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 10),
                                                    child: Text(
                                                      "${snapshot.data[index].jenispoin}",
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                  Text(
                                                    "${snapshot.data[index].poin}",
                                                    style: TextStyle(
                                                        fontSize: 30,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white),
                                                  ),
                                                ],
                                              ),
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
                        }
                      },
                      physics: BouncingScrollPhysics(),
                    )
                    ),
              ],
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
