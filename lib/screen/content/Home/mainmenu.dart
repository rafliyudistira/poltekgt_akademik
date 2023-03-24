import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:sisfo_pgt/screen/model/model_mahasiswa.dart';
import 'package:http/http.dart' as http;

class MainMenu extends StatefulWidget {
  final GoRouterState? goRouterState;
  MainMenu({super.key, this.goRouterState});

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  String dateNow = DateFormat('EEEE ,dd MMM yyyy').format(DateTime.now());
  int nimMahasiwa = 0;

  @override
  Widget build(BuildContext context) {
    String namaMhs = widget.goRouterState!.queryParams['nama'] as String;
    String nimMhs = widget.goRouterState!.queryParams['nim'] as String;
    setState(() {
      nimMahasiwa = int.parse(nimMhs);
    });
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              flex: 4,
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 35),
                      child: Expanded(
                        flex: 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset('assets/image/poltekgt.png', scale: 3),
                            Text('Sistem Informasi Akademik',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white)),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Hi , ${namaMhs}',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white)),
                            Text(
                              'Selamat Datang',
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            // FutureBuilder<http.Response>(
                            //   future: getNimMahasiswa(nimMahasiwa),
                            //   builder: (context, snapshot) {
                            //     if (snapshot.hasData) {
                            //       var json = jsonDecode(snapshot.data!.body);
                            //       return Text(json['kelas']);
                            //     }
                            //     return Container();
                            //   },
                            // )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )),
          Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    dateNow.toString(),
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                  ),
                ),
              )),
          Expanded(
            flex: 8,
            child: Container(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: GridView.builder(
                  itemCount: menuList.length,
                  scrollDirection: Axis.vertical,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15),
                  itemBuilder: (context, index) {
                    return Material(
                      borderRadius: BorderRadius.circular(20),
                      color: menuList[index].color,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(20),
                        splashColor: Colors.grey.shade200,
                        onTap: () {
                          if (menuList[index].navigate == 'logout') {
                            context.goNamed('login');
                          } else if (menuList[index].navigate == 'profile') {
                            context.goNamed('profile',
                                queryParams: {"nim": nimMhs, "nama": namaMhs});
                          } else if (menuList[index].navigate == 'akademik') {
                            context.goNamed('akademik',
                                queryParams: {"nama": namaMhs, "nim": nimMhs});
                          } else if (menuList[index].navigate == 'point') {
                            context.goNamed('point',
                                queryParams: {"nama": namaMhs, "nim": nimMhs});
                          } else if (menuList[index].navigate == 'ubahpw') {
                            context.goNamed('ubahpw',
                                queryParams: {"nama": namaMhs, "nim": nimMhs});
                          } else {
                            const snackbar = SnackBar(
                              backgroundColor: Colors.grey,
                              content: Text('Coming Soon!'),
                              behavior: SnackBarBehavior.floating,
                            );

                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackbar);
                            // context.goNamed('${menuList[index].navigate}');
                          }
                        },
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.white.withOpacity(0.5),
                                radius: 30,
                                child: Center(
                                    child: Image.asset(
                                  'assets/image/${menuList[index].image}',
                                  scale: 15,
                                  color: menuList[index].tcolor,
                                )),
                              ),
                              Text(
                                menuList[index].title,
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: menuList[index].tcolor),
                                overflow: TextOverflow.clip,
                                textAlign: TextAlign.center,
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            )),
          )
        ],
      ),
    );
  }
}

// class ListMenu extends StatelessWidget {
//   const ListMenu({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: GridView.builder(
//         itemCount: menuList.length,
//         scrollDirection: Axis.vertical,
//         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 3, crossAxisSpacing: 15, mainAxisSpacing: 15),
//         itemBuilder: (context, index) {
//           return Material(
//             borderRadius: BorderRadius.circular(20),
//             color: menuList[index].color,
//             child: InkWell(
//               borderRadius: BorderRadius.circular(20),
//               splashColor: Colors.grey.shade200,
//               onTap: () {
//                 if (menuList[index].navigate == 'logout') {
//                   context.goNamed('login');
//                 } else if (menuList[index].navigate == 'profile') {
//                   context.goNamed('profile');
//                 } else {
//                   context.goNamed('${menuList[index].navigate}');
//                 }
//               },
//               child: Container(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     CircleAvatar(
//                       backgroundColor: Colors.white.withOpacity(0.5),
//                       radius: 30,
//                       child: Center(
//                           child: Image.asset(
//                         'assets/image/${menuList[index].image}',
//                         scale: 15,
//                         color: menuList[index].tcolor,
//                       )),
//                     ),
//                     Text(
//                       menuList[index].title,
//                       style: TextStyle(
//                           fontWeight: FontWeight.w500,
//                           color: menuList[index].tcolor),
//                       overflow: TextOverflow.clip,
//                       textAlign: TextAlign.center,
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

class Menu {
  final String title;
  final Color color;
  final Color tcolor;
  final String image;
  final String navigate;
  const Menu(
      {required this.title,
      required this.color,
      required this.tcolor,
      required this.image,
      required this.navigate});
}

List<Menu> menuList = <Menu>[
  Menu(
      title: 'Akademik',
      color: Colors.green.shade100,
      tcolor: Colors.green,
      image: 'akademik.png',
      navigate: 'akademik'),
  Menu(
      title: 'Point',
      color: Colors.blue.shade100,
      tcolor: Colors.blue,
      image: 'spam.png',
      navigate: 'point'),
  Menu(
      title: 'Profile',
      color: Colors.purple.shade100,
      tcolor: Colors.purple,
      image: 'profile.png',
      navigate: 'profile'),
  Menu(
      title: 'Ubah Password',
      color: Colors.pink.shade100,
      tcolor: Colors.pink,
      image: 'setting.png',
      navigate: 'ubahpw'),
  Menu(
      title: 'Absensi',
      color: Colors.amber.shade100,
      tcolor: Colors.amber,
      image: 'map.png',
      navigate: 'absensi'),
  Menu(
      title: 'Log Out',
      color: Colors.red.shade100,
      tcolor: Colors.red,
      image: 'logout.png',
      navigate: 'logout'),
];
