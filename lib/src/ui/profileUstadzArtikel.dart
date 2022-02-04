import 'package:daikita/src/blocs/fiturBloc.dart';
import 'package:daikita/src/models/getDetailUstadzModel.dart';
import 'package:daikita/src/models/getListUstadzModel.dart';
import 'package:daikita/src/resources/publicUrl.dart';
import 'package:daikita/src/ui/buatJadwal.dart';
import 'package:daikita/src/ui/chatRoom.dart';
import 'package:daikita/src/ui/postArtikel.dart';
import 'package:daikita/src/ui/utils/colorses.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';

class ProfileUstadzArtikel extends StatefulWidget {
  ProfileUstadzArtikel({this.nama,this.noHp,this.kecamatan, this.image});

  String nama;
  String noHp;
  String kecamatan;
  String image;

  @override
  _ProfileUstadzArtikelState createState() => _ProfileUstadzArtikelState();
}

class _ProfileUstadzArtikelState extends State<ProfileUstadzArtikel> with SingleTickerProviderStateMixin {
  TabController _tabController;
  List<dynamic> ustadzDetail = List<dynamic>();
  List<dynamic> pekerjaan = List<dynamic>();
  List<dynamic> organisasi = List<dynamic>();
  List<UlasanModel> ulasanList = List<UlasanModel>();
  List<ArtikelModel> artikel = List<ArtikelModel>();
  String profilS = "Loading ...";
  String label;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    blocFitur.profilUstadz(widget.noHp);
    blocFitur.resProfilUstadz.listen((value) {
      if (mounted)
        setState(() {
          ustadzDetail.addAll(value.result.pendidikan);
          pekerjaan.addAll(value.result.pekerjaan);
          organisasi.addAll(value.result.organisasi);
          ulasanList.addAll(value.result.ulasan);
          artikel.addAll(value.result.artikel);
          profilS = value.result.profile;

        });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height / 2 - 30,
            child: Stack(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height / 2,
                  color: Colors.white,
                  child: Stack(
                    children: <Widget>[
                      Container(
                        height: MediaQuery.of(context).size.height / 2 - 120,
                        color: colorses.hijaudasar,
                        child: Stack(
                          children: <Widget>[
                            SvgPicture.asset('assets/bg.svg',
                                color: Colors.green,
                                alignment: Alignment.center,
                                width: MediaQuery.of(context).size.width,
                                fit: BoxFit.cover),
                            Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [colorses.colorCustom[100], colorses.hijaudasar]),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: SafeArea(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Icon(
                                    Icons.arrow_back_ios,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  "Profile Ustadz",
                                  style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                                Container(
                                  width: 50,
                                  height: 50,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: MediaQuery.of(context).size.width - 60,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 50,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Colors.white,
                            image: DecorationImage(
                                image: widget.image == null
                                    ? NetworkImage(
                                        "https://3.bp.blogspot.com/-a6eXQ7JDago/WR6wYhHcp3I/AAAAAAAAB98/3QxH69fmBN85FPA5_PBATBSejiC2w-JHgCLcB/s1600/Flat%2BMusth%2B2.png")
                                    : NetworkImage(urlVps+widget.image),
                                fit: BoxFit.cover)),
                        width: 120,
                        height: 120,
                      ),
                      SizedBox(
                        height: 9,
                      ),
                      Text(
                        "${widget.nama}",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      SizedBox(
                        height: 9,
                      ),
                      Text(
                        "Penceramah",
                        style: TextStyle(color: Colors.orange),
                      ),
                      SizedBox(
                        height: 9,
                      ),
                      Text(
                        "${widget.kecamatan}",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Container(
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: TabBar(
              controller: _tabController,
              indicator: UnderlineTabIndicator(
                borderSide: BorderSide(color: colorses.hijaudasar, width: 5),
                // insets: EdgeInsets.fromLTRB(50.0, 0.0, 50.0, 40.0),
              ),
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              tabs: [
                Tab(
                  text: 'Profil',
                ),
                Tab(
                  text: 'Ulasan',
                ),
                Tab(
                  text: 'Artikel',
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [Profile(profilSingkat: profilS,data: ustadzDetail,pek: pekerjaan,org:organisasi), Ulasan(data: ulasanList), Artikel(artikel: artikel)],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.rightToLeft,
                  duration: Duration(milliseconds: 200),
                  child: PostArtikel()));
        },
        backgroundColor: Colors.red,
        child: Icon(Icons.article_outlined),
      ),
    );
  }
}

class Profile extends StatefulWidget {
  Profile({this.profilSingkat,this.data,this.pek,this.org});

  String profilSingkat;
  List<dynamic> data;
  List<dynamic> pek;
  List<dynamic> org;

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.only(left:12.0),
              child: Text("Profile Singkat",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
            ),
            Container(
              padding: EdgeInsets.all(12),
              child: Text(widget.profilSingkat),
            ),
            Padding(
              padding: const EdgeInsets.only(left:12.0),
              child: Text("Riwayat Pendidikan",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
            ),
            Container(
              height: 135,
                padding: EdgeInsets.all(12),
                child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: widget.data.length,
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, i) {
                      return Text("- "+widget.data[i]);
                    })),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.only(left:12.0),
              child: Text("Riwayat Pekerjaan",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
            ),
            Container(
                height: 135,
                padding: EdgeInsets.all(12),
                child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: widget.pek.length,
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, i) {
                      return Text("- "+widget.pek[i]);
                    })),
            Padding(
              padding: const EdgeInsets.only(left:12.0),
              child: Text("Riwayat Organisasi",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
            ),
            Container(
                height: 135,
                padding: EdgeInsets.all(12),
                child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: widget.org.length,
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, i) {
                      return Text("- "+widget.org[i]);
                    })),
          ],
        ),
      ),
    );
  }
}

class Ulasan extends StatefulWidget {
  Ulasan({this.data});
  List<UlasanModel> data;
  @override
  _UlasanState createState() => _UlasanState();
}

class _UlasanState extends State<Ulasan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
                itemCount: widget.data.length,
                padding: EdgeInsets.zero,
                itemBuilder: (context, i) {
                  return Container(
                    width: MediaQuery.of(context).size.width - 20,
                    margin: EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Icon(Icons.star,color: Colors.orangeAccent,size: 21,),
                            Text("  "+widget.data[i].rating),
                          ],
                        ),
                        SizedBox(height: 8,),
                        Text(widget.data[i].nama,style: TextStyle(fontWeight: FontWeight.bold),),
                        SizedBox(height: 8,),
                        Text(widget.data[i].komen),
                        Divider()
                      ],
                    ),
                  );
                }),
          ),
        ],
      )
    );
  }
}

class Artikel extends StatefulWidget {
  Artikel({this.artikel});
  List<ArtikelModel> artikel;
  @override
  _ArtikelState createState() => _ArtikelState();
}

class _ArtikelState extends State<Artikel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                  itemCount: widget.artikel.length,
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, i) {
                    return Container(
                      margin: EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("${DateFormat('EEEE', "id_ID").format(widget.artikel[i].tanggal)}, ${widget.artikel[i].tanggal.day} ${DateFormat('MMMM', "id_ID").format(widget.artikel[i].tanggal)} 2021"),
                          SizedBox(height: 8,),
                          Text(widget.artikel[i].judul,style: TextStyle(fontWeight: FontWeight.bold),),
                          SizedBox(height: 8,),
                          Container(
                              width: MediaQuery.of(context).size.width-45,
                              child: Html(data: widget.artikel[i].isi??"")),
                          Divider()
                        ],
                      ),
                    );
                  }),
            ),
          ],
        )
    );
  }
}
