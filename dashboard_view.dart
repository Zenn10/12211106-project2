import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pendataanwarga/providers/dashboard_provider.dart';
import 'package:pendataanwarga/providers/label_berita_provider.dart';
import 'package:provider/provider.dart';

class DashboardView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final panels = [DashboardPanel(), LabelBerita(), SizedBox()];
    return Consumer<Dashboardprovider>(builder: (context, Provider, Widget) {
      return Scaffold(
          bottomNavigationBar: NavigatorBawah(),
          body: Provider.indexTombol == 0
              ? DashboardPanel()
              : Provider.indexTombol == 1
                  ? LabelBerita()
                  : SizedBox());
    });
  }
}

class DashboardPanel extends StatelessWidget {
  const DashboardPanel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset('assets/background.png'),
        InformasiPengguna(),
        SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.only(top: 180),
          child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              margin: EdgeInsets.zero,
              child: Container(
                width: double.infinity,
                child: Column(
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    LabelBerita(),
                    ListBerita(),
                    SizedBox(
                      height: 40,
                    ),
                    Wrap(
                      children: [
                        TombolMenu(
                          image: Image.asset(
                            'assets/icon1.png',
                            width: 60,
                          ),
                        ),
                        TombolMenu(
                          image: Image.asset(
                            'assets/icon2.png',
                            width: 60,
                          ),
                        ),
                        TombolMenu(
                            image: Image.asset(
                          'assets/icon3.png',
                          width: 60,
                        )),
                      ],
                    )
                  ],
                ),
              )),
        ))
      ],
    );
  }
}

class TombolMenu extends StatelessWidget {
  final Image? image;
  const TombolMenu({Key? key, this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 9,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      margin: EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Image.asset(
          'assets/icon1.png',
          width: 60,
        ),
      ),
    );
  }
}

class ListBerita extends StatelessWidget {
  const ListBerita({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Image.asset(
                'assets/berita1.png',
                height: 120,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Image.asset(
                'assets/berita2.png',
                height: 120,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Image.asset(
                'assets/berita3.png',
                height: 120,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LabelBerita extends StatelessWidget {
  const LabelBerita({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    context.read<labelberitaprovider>().muatdata();
    return Scaffold(
      appBar: AppBar(
        title: Text('Berita'),
      ),
      body: Consumer<labelberitaprovider>(builder: (context, prov, w) {
        return ListView();
        children:
        [
          for (final data in prov.data)
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('${data['title']}'),
                Image.network(data['image'] ?? '',
                    errorBuilder: (context, error, stackTrace) {
                  return Image.asset('assets/logo.png');
                }),
                Text('${data['description']}')
              ],
            )
        ];
      }),
    );
  }
}

class NavigatorBawah extends StatelessWidget {
  const NavigatorBawah({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final p = context.read<Dashboardprovider>();

    return BottomNavigationBar(
      currentIndex: p.indexTombol,
      onTap: (value) {
        p.saatdiklik(value);
      },
      items: [
        BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.house), label: 'Home'),
        BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.newspaper), label: 'Berita'),
        BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.gear), label: 'Pengaturan')
      ],
    );
  }
}

class InformasiPengguna extends StatelessWidget {
  const InformasiPengguna({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 60, 20, 0),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.asset(
              'assets/fotoprofil.png',
              width: 60,
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hi, Ryoo',
                  style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                Text(
                  'Ryoo.ea@gmail.com',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ],
            ),
          ),
          Image.asset(
            'assets/gambar1.png',
            width: 40,
          )
        ],
      ),
    );
  }
}
