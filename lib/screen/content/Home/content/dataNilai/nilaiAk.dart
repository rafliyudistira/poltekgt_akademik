import 'package:flutter/material.dart';
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
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.blue.shade100
                        // gradient: const LinearGradient(
                        //     begin: Alignment.topCenter,
                        //     end: Alignment.bottomCenter,
                        //     colors: [
                        //       Color.fromRGBO(0, 229, 255, 1),
                        //       Color.fromARGB(255, 65, 229, 218),
                        //     ]),
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
                                    color: Colors.blue),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: Text(
                                '-'
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
                          child: Image.asset('assets/image/piagam.png',
                              color: Colors.blue),
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
                              )
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
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: ExpansionTile(
            collapsedBackgroundColor: Colors.grey[200],
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(siswa.tahunakademik.toString(),
                    style: TextStyle(fontWeight: FontWeight.w500)),
                SizedBox(
                  height: 3,
                ),
                Text(siswa.dosen)
              ],
            ),
            subtitle: Text(siswa.namamk),
            children: [
              ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Text(siswa.akhir.toString()),
                        Text('Nilai Akhir')
                      ],
                    ),
                    Column(
                      children: [Text(siswa.huruf), Text('Grade')],
                    ),
                    Column(
                      children: [Text(siswa.sks.toString()), Text('SKS')],
                    ),
                  ],
                ),
              )
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
