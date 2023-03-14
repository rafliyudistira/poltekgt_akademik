import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MainMenu extends StatelessWidget {
  MainMenu({super.key});

  String dateNow = DateFormat('EEEE ,dd MMM yyyy').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              flex: 3,
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(25),
                        bottomRight: Radius.circular(25))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset('assets/image/poltekgt.png', scale: 5),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Hi , Bagas Bote',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white)),
                          Text(
                            'Welcome Back',
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          )
                        ],
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
              child: ListMenu(),
            )),
          )
        ],
      ),
    );
  }
}

class ListMenu extends StatelessWidget {
  const ListMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.builder(
        itemCount: menuList.length,
        scrollDirection: Axis.vertical,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, crossAxisSpacing: 15, mainAxisSpacing: 15),
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: menuList[index].color,
            ),
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
                    color: menuList[index].t_color,
                  )),
                ),
                Text(
                  menuList[index].title,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: menuList[index].t_color),
                  overflow: TextOverflow.clip,
                  textAlign: TextAlign.center,
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

class Menu {
  final String title;
  final Color color;
  final Color t_color;
  final String image;
  const Menu(
      {required this.title,
      required this.color,
      required this.t_color,
      required this.image});
}

List<Menu> menuList = <Menu>[
  Menu(
      title: 'Akademik',
      color: Colors.green.shade100,
      t_color: Colors.green,
      image: 'akademik.png'),
  Menu(
      title: 'Point',
      color: Colors.blue.shade100,
      t_color: Colors.blue,
      image: 'spam.png'),
  Menu(
      title: 'Profile',
      color: Colors.purple.shade100,
      t_color: Colors.purple,
      image: 'profile.png'),
  Menu(
      title: 'Ubah Password',
      color: Colors.pink.shade100,
      t_color: Colors.pink,
      image: 'setting.png'),
  Menu(
      title: 'Absensi',
      color: Colors.amber.shade100,
      t_color: Colors.amber,
      image: 'map.png'),
  Menu(
      title: 'Log Out',
      color: Colors.red.shade100,
      t_color: Colors.red,
      image: 'logout.png'),
];
