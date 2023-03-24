import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:go_router/go_router.dart';
import 'package:sisfo_pgt/color.dart';
import 'package:sisfo_pgt/screen/model/model_mahasiswa.dart';

class SearchClass extends StatefulWidget {
  final String Text;
  final ValueChanged<String> onChanged;
  final String hintText;
  const SearchClass(
      {Key? key,
      required this.Text,
      required this.onChanged,
      required this.hintText})
      : super(key: key);

  @override
  State<SearchClass> createState() => _SearchClassState();
}

class _SearchClassState extends State<SearchClass> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Perincian Nilai',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 37, 37, 37)),
            ),
            Container(
              decoration: BoxDecoration(
                  // color: Color.fromARGB(255, 187, 187, 187),
                  ),
              width: MediaQuery.of(context).size.width / 2,
              child: TextFormField(
                controller: controller,
                decoration: InputDecoration(
                    labelText: 'Tahun Akademik',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    suffixIcon: widget.Text.isNotEmpty
                        ? GestureDetector(
                            child: Icon(Icons.close),
                            onTap: () {
                              controller.clear();
                              widget.onChanged('');
                              // FocusScope.of(context).requestFocus(Focu)
                            },
                          )
                        : null,
                    hintText: widget.hintText),
                onChanged: widget.onChanged,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NilaiAkademik extends StatefulWidget {
  GoRouterState? goRouterState;
  NilaiAkademik({super.key, required this.goRouterState});

  @override
  State<NilaiAkademik> createState() => _NilaiAkademikState();
}

class _NilaiAkademikState extends State<NilaiAkademik> {
  // late List<AkademikSiswa> nilaiSiswa;
  List<AkademikSiswa> nilaiAkademik = [];
  String query = '';

  @override
  void initState() {
    // TODO: implement initState
    // nilaiSiswa = allNilai;
    init();
    super.initState();
  }

  int nimSiswa = 0;
  Future init() async {
    final nilaiAkademik = await NilaiAkademikApi.getAkademik(query, nimSiswa);

    setState(() {
      this.nilaiAkademik = nilaiAkademik;
    });
  }

  @override
  Widget build(BuildContext context) {
    String namaMhs = widget.goRouterState?.queryParams['nama'] as String;
    String nimMhs = widget.goRouterState?.queryParams['nim'] as String;
    nimSiswa = int.parse(nimMhs);
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
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: Text(
                                'KUMULATIF',
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: Text(
                                '0'
                                // '${json['akademik'].toString()}'
                                ,
                                style: TextStyle(
                                    fontSize: 45,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          width: 100,
                          height: 100,
                          child: Image.asset('assets/image/piagam.png'),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                child: buildSearch(),
              ),
              // Expanded(flex: 1, child: buildSearch()),
              Expanded(
                flex: 4,
                child: Container(
                    child: nilaiAkademik.isNotEmpty
                        ? ListView.builder(
                            itemCount: nilaiAkademik.length,
                            itemBuilder: (context, index) {
                              final nilaiw = nilaiAkademik[index];
                              return buildnilai(nilaiw);
                            },
                            physics: BouncingScrollPhysics(),
                          )
                        : Center(
                            child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 15),
                                child: CircularProgressIndicator(),
                              ),
                              Text(
                                'Silahkan cari tahun dulu',
                                style: TextStyle(fontSize: 15),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 3),
                                child: Text(
                                  '${namaMhs} :)',
                                  style: TextStyle(fontSize: 15),
                                ),
                              ),
                            ],
                          ))),
              ),
            ],
          ),
        ));
  }

  Widget buildSearch() =>
      SearchClass(Text: query, onChanged: searchNilai, hintText: '');

  Widget buildnilai(AkademikSiswa siswa) => Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
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
                  '${siswa.tahunakademik}',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 5),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width / 1.3,
                            child: Text(
                              '${siswa.dosen}',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                              overflow: TextOverflow.clip,
                            ),
                          ),
                        ),
                        Text(
                          "${siswa.namamk}",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 5, top: 10),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 5),
                                    child: Text(
                                      "${siswa.akhir.toString()}",
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
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 5, right: 5, top: 10),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 5),
                                    child: Text(
                                      '${siswa.huruf}',
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
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5, top: 10),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 5),
                                    child: Text(
                                      "${siswa.sks.toString()}",
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

  void searchNilai(String query) async {
    final nilaiQ = await NilaiAkademikApi.getAkademik(query, nimSiswa);

    if (!mounted) return;

    setState(() {
      this.query = query;
      this.nilaiAkademik = nilaiQ;
    });
  }
}
