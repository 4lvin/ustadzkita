import 'package:daikita/src/blocs/fiturBloc.dart';
import 'package:daikita/src/blocs/memberBloc.dart';
import 'package:daikita/src/models/getKecamatanModel.dart';
import 'package:daikita/src/models/getKotaModel.dart';
import 'package:daikita/src/models/getListUstadzModel.dart';
import 'package:daikita/src/models/getMasterKajianModel.dart';
import 'package:daikita/src/models/getProvinsiModel.dart';
import 'package:daikita/src/pref/preferences.dart';
import 'package:daikita/src/ui/konfirmasiJadwal.dart';
import 'package:daikita/src/ui/utils/colorses.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:toast/toast.dart';

class BuatJadwal extends StatefulWidget {
  BuatJadwal({this.data});

  Result data;

  @override
  _BuatJadwalState createState() => _BuatJadwalState();
}

class _BuatJadwalState extends State<BuatJadwal> {
  var _tgl = TextEditingController();
  var _jamMulai = TextEditingController();
  var _jamSelesai = TextEditingController();

  // var _jenisKegiatan = TextEditingController();
  var _tema = TextEditingController();
  var _jmlhPeserta = TextEditingController();
  var _alamat = TextEditingController();
  var _akomodasi = TextEditingController();
  int _provinsi;
  int _kota;
  int _kecamatan;
  int _kajian;
  String _selectedProvinsi;
  String _selectedKota;
  String _namaKota;
  String _selectedKecamatan;
  String _selectedKajian;
  bool _validate = false;
  DateTime mulai;
  DateTime selesai;

  @override
  void initState() {
    memberBloc.getProvinsi();
    getToken().then((value) {
      blocFitur.masterKajian(value);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height / 6 - 20,
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
                Align(
                  alignment: Alignment.topCenter,
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          InkWell(
                            onTap: (){
                              Navigator.of(context).pop();
                            },
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "Buat Jadwal",
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
          Container(
            height: 60,
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.looks_one,
                        color: colorses.hijaucerahg1,
                      ),
                      Text(
                        "  Buat Jadwal",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.looks_two,
                        color: Colors.grey,
                      ),
                      Text(
                        "  Konfirmasi",
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            height: 8,
            width: MediaQuery.of(context).size.width / 2,
            color: colorses.hijaucerahg1,
          ),
          SizedBox(
            height: 5,
          ),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              children: <Widget>[
                Container(
                  height: 140,
                  padding: EdgeInsets.only(top: 8, left: 20),
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Ustadz Pilihan Anda",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 8),
                        height: 80,
                        child: Row(
                          children: <Widget>[
                            Container(
                              height: 80,
                              width: 80,
                              margin: EdgeInsets.only(right: 8),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  image: DecorationImage(
                                      image: widget.data.foto == null
                                          ? NetworkImage(
                                              "https://3.bp.blogspot.com/-a6eXQ7JDago/WR6wYhHcp3I/AAAAAAAAB98/3QxH69fmBN85FPA5_PBATBSejiC2w-JHgCLcB/s1600/Flat%2BMusth%2B2.png")
                                          : NetworkImage(widget.data.foto),
                                      fit: BoxFit.cover)),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "${widget.data.fullName}",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text("${widget.data.provinsi}"),
                              ],
                            )
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
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12))),
                  child: Column(
                    children: <Widget>[
                      Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.only(left: 12, top: 12),
                          child: Text(
                            "Rencana Kegiatan",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                      Container(
                        margin: EdgeInsets.all(12),
                        child: TextFormField(
                            style: TextStyle(height: 1),
                            enabled: true,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.calendar_today),
                              labelText: 'Tanggal Kegiatan',
                              contentPadding: EdgeInsets.only(bottom: 1, left: 12),
                              border: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(8.0),
                                ),
                              ),
                              hintText: 'Tanggal Kegiatan',
                              errorStyle: TextStyle(color: Colors.redAccent, fontSize: 12.0),
                              // errorText:
                              // _tglPelaksanaan.text.length < 3 && _validate
                              //     ? 'Tanggal Pelaksanaan harus diisi!'
                              //     : null
                            ),
                            controller: _tgl,
                            onTap: () async {
                              DateTime date = DateTime(1900);
                              FocusScope.of(context).requestFocus(new FocusNode());
                              date = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2100));
                              final DateFormat formatter = DateFormat('yyyy-MM-dd');
                              var formatDate = formatter.format(date);
                              _tgl.text = formatDate;
                            }),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 12, right: 12),
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width / 2 - 17,
                              margin: EdgeInsets.only(top: 12),
                              child: TextFormField(
                                  style: TextStyle(height: 1),
                                  decoration: InputDecoration(
                                      // prefixIcon: Icon(Icons.access_time),
                                      labelText: 'Jam Mulai',
                                      contentPadding: EdgeInsets.only(bottom: 1, left: 12),
                                      border: OutlineInputBorder(
                                        borderRadius: const BorderRadius.all(
                                          const Radius.circular(8.0),
                                        ),
                                      ),
                                      hintText: 'Jam Mulai',
                                      errorStyle: TextStyle(color: Colors.redAccent, fontSize: 12.0),
                                      errorText: _jamMulai.text.length < 3 && _validate ? 'Jam Mulai harus diisi!' : null),
                                  controller: _jamMulai,
                                  onTap: () async {
                                    FocusScope.of(context).requestFocus(new FocusNode());
                                    var now = DateTime.now();
                                    TimeOfDay time = await showTimePicker(
                                        context: context, initialTime: TimeOfDay(hour: now.hour, minute: now.minute));
                                    setState(() {
                                      final DateFormat formatter = DateFormat('HH:mm');
                                      mulai = DateTime(now.year, now.month, now.day, time.hour, time.minute);
                                      _jamMulai.text = formatter.format(mulai);
                                    });
//                                DatePicker.showTimePicker(context,
//                                    showTitleActions: true, onConfirm: (date) {
//
//                                  var time = date.hour.toString() +
//                                      ":" +
//                                      date.minute.toString();
//                                  setState(() {
//                                    mulai = date;
//                                    _jamMulai.text = time;
//                                  });
//                                }, currentTime: DateTime.now());
                                  }),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 2 - 17,
                              margin: EdgeInsets.only(top: 12, left: 10),
                              child: TextFormField(
                                  style: TextStyle(height: 1),
                                  decoration: InputDecoration(
                                      // prefixIcon: Icon(Icons.access_time),
                                      labelText: 'Jam Selesai',
                                      contentPadding: EdgeInsets.only(bottom: 1, left: 12),
                                      border: OutlineInputBorder(
                                        borderRadius: const BorderRadius.all(
                                          const Radius.circular(8.0),
                                        ),
                                      ),
                                      hintText: 'Jam Selesai',
                                      errorStyle: TextStyle(color: Colors.redAccent, fontSize: 12.0),
                                      errorText: _jamMulai.text.length < 3 && _validate ? 'Jam Selesai harus diisi!' : null),
                                  controller: _jamSelesai,
                                  onTap: () async {
                                    FocusScope.of(context).requestFocus(new FocusNode());
                                    var now = DateTime.now();
                                    TimeOfDay time = await showTimePicker(
                                        context: context, initialTime: TimeOfDay(hour: now.hour, minute: now.minute));
                                    setState(() {
                                      final DateFormat formatter = DateFormat('HH:mm');
                                      selesai = DateTime(now.year, now.month, now.day, time.hour, time.minute);
                                      _jamSelesai.text = formatter.format(selesai);
                                    });
//                                DatePicker.showTimePicker(context,
//                                    showTitleActions: true, onConfirm: (date) {
//                                      var time = date.hour.toString() +
//                                          ":" +
//                                          date.minute.toString();
//                                      setState(() {
//                                        _jamSelesai.text = time;
//                                        selesai = date;
//                                        _durasi.text = selesai.difference(mulai).inHours.toString()+" Jam";
//                                      });
//                                    }, currentTime: DateTime.now());
                                  }),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 12, right: 12, top: 12),
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 1),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.white, borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.grey)),
                        child: StreamBuilder(
                            stream: blocFitur.resKajian,
                            builder: (context, AsyncSnapshot<GetMasterKajianModel> snapshot) {
                              if (snapshot.hasData) {
                                return new DropdownButton<ResultKajian>(
                                  isExpanded: true,
                                  items: snapshot.data.result.map((ResultKajian value) {
                                    return new DropdownMenuItem<ResultKajian>(
                                      value: value,
                                      child: Container(
                                          width: 140.0,
                                          child: new Text(
                                            value.jenis,
                                            style: TextStyle(fontSize: 14.0),
                                          )),
                                    );
                                  }).toList(),
                                  value: _kajian == null ? null : snapshot.data.result[_kajian],
                                  hint: Text(
                                    "Jenis Kajian",
                                    style: TextStyle(fontSize: 14.0),
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      FocusScope.of(context).requestFocus(new FocusNode());
                                      _kajian = snapshot.data.result.indexOf(value);
                                      _selectedKajian = value.jenis;
                                    });
                                  },
                                );
                              }
                              return Container(
                                child: Text("loading.."),
                              );
                            }),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 12, right: 12, top: 12),
                        child: TextField(
                          controller: _tema,
                          cursorColor: Color(0xff740e13),
                          style: TextStyle(fontSize: 16),
                          decoration: InputDecoration(
                            errorText: _tema.text.length < 3 && _validate ? 'Tema/Topik !' : null,
                            labelText: "Tema/Topik",
                            contentPadding: EdgeInsets.only(bottom: 1, left: 12),
                            border: OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(8.0),
                              ),
                            ),
                          ),
                          keyboardType: TextInputType.text,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 12, right: 12, top: 12),
                        child: TextField(
                          controller: _jmlhPeserta,
                          cursorColor: Color(0xff740e13),
                          style: TextStyle(fontSize: 16),
                          decoration: InputDecoration(
                            errorText: _validate ? 'Jumlah Peserta !' : null,
                            labelText: "Jumlah Peserta",
                            contentPadding: EdgeInsets.only(bottom: 1, left: 12),
                            border: OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(8.0),
                              ),
                            ),
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.only(left: 12, top: 12, bottom: 12),
                          child: Text(
                            "Alamat Kegiatan",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                      Container(
                        margin: EdgeInsets.only(left: 12, right: 12, top: 12),
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 1),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.white, borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.grey)),
                        child: StreamBuilder(
                            stream: memberBloc.resProvinsi,
                            builder: (context, AsyncSnapshot<GetProvinsiModel> snapshot) {
                              if (snapshot.hasData) {
                                return new DropdownButton<ResultProv>(
                                  isExpanded: true,
                                  items: snapshot.data.result.map((ResultProv value) {
                                    return new DropdownMenuItem<ResultProv>(
                                      value: value,
                                      child: Container(
                                          width: 140.0,
                                          child: new Text(
                                            "${value.provinsi}",
                                            style: TextStyle(fontSize: 14.0),
                                          )),
                                    );
                                  }).toList(),
                                  value: _provinsi == null ? null : snapshot.data.result[_provinsi],
                                  hint: Text(
                                    "pilih Provinsi",
                                    style: TextStyle(fontSize: 14.0),
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      FocusScope.of(context).requestFocus(new FocusNode());
                                      _provinsi = snapshot.data.result.indexOf(value);
                                      _selectedProvinsi = value.kode;
                                      memberBloc.getKota(_selectedProvinsi);
                                    });
                                  },
                                );
                              }
                              return Container(
                                child: Text("loading.."),
                              );
                            }),
                      ),
                      Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(left: 12, right: 0, top: 12),
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 1),
                            width: MediaQuery.of(context).size.width / 2 - 17,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.grey)),
                            child: StreamBuilder(
                                stream: memberBloc.resKota,
                                builder: (context, AsyncSnapshot<GetKotaModel> snapshot) {
                                  if (snapshot.hasData) {
                                    return new DropdownButton<ResultKota>(
                                      isExpanded: true,
                                      items: snapshot.data.result.map((ResultKota value) {
                                        return new DropdownMenuItem<ResultKota>(
                                          value: value,
                                          child: Container(
                                              width: 140.0,
                                              child: new Text(
                                                value.kota,
                                                style: TextStyle(fontSize: 14.0),
                                              )),
                                        );
                                      }).toList(),
                                      value: _kota == null ? null : snapshot.data.result[_kota],
                                      hint: Text(
                                        "pilih Kota",
                                        style: TextStyle(fontSize: 14.0),
                                      ),
                                      onChanged: (value) {
                                        setState(() {
                                          FocusScope.of(context).requestFocus(new FocusNode());
                                          _kota = snapshot.data.result.indexOf(value);
                                          _selectedKota = value.kode;
                                          _namaKota = value.kota;
                                          memberBloc.getKecamatan(_selectedProvinsi, value.kode);
                                        });
                                      },
                                    );
                                  }
                                  return Container(
                                    height: 40,
                                    child: Text("Pilih kota"),
                                  );
                                }),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 8, right: 12, top: 12),
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 1),
                            width: MediaQuery.of(context).size.width / 2 - 17,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.grey)),
                            child: StreamBuilder(
                                stream: memberBloc.resKecamatan,
                                builder: (context, AsyncSnapshot<GetKecamatanModel> snapshot) {
                                  if (snapshot.hasData) {
                                    return new DropdownButton<ResultKecamatan>(
                                      isExpanded: true,
                                      items: snapshot.data.result.map((ResultKecamatan value) {
                                        return new DropdownMenuItem<ResultKecamatan>(
                                          value: value,
                                          child: Container(
                                              width: 140.0,
                                              child: new Text(
                                                value.kecamatan,
                                                style: TextStyle(fontSize: 14.0),
                                              )),
                                        );
                                      }).toList(),
                                      value: _kecamatan == null ? null : snapshot.data.result[_kecamatan],
                                      hint: Text(
                                        "pilih Kecamatan",
                                        style: TextStyle(fontSize: 14.0),
                                      ),
                                      onChanged: (value) {
                                        setState(() {
                                          FocusScope.of(context).requestFocus(new FocusNode());
                                          _kecamatan = snapshot.data.result.indexOf(value);
                                          _selectedKecamatan = value.kode;
                                        });
                                      },
                                    );
                                  }
                                  return Container(
                                    height: 40,
                                    child: Text("Pilih Kecamatan"),
                                  );
                                }),
                          ),
                        ],
                      ),
                      Container(
                        // width: MediaQuery.of(context).size.width-12,
                        margin: EdgeInsets.only(left: 14, right: 14, top: 12),
                        child: TextField(
                          controller: _alamat,
                          cursorColor: Color(0xff740e13),
                          style: TextStyle(fontSize: 16),
                          decoration: InputDecoration(
                            errorText: _alamat.text.length < 3 && _validate ? 'Alamat Harus diisi !' : null,
                            labelText: "Alamat",
                            contentPadding: EdgeInsets.only(bottom: 1, left: 12),
                            border: OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(8.0),
                              ),
                            ),
                          ),
                          keyboardType: TextInputType.text,
                        ),
                      ),
                      Container(
                        // width: MediaQuery.of(context).size.width-12,
                        margin: EdgeInsets.only(left: 14, right: 14, top: 12),
                        child: TextField(
                          controller: _akomodasi,
                          cursorColor: Color(0xff740e13),
                          style: TextStyle(fontSize: 16),
                          decoration: InputDecoration(
                            errorText: _akomodasi.text.length < 3 && _validate ? 'Akomodasi Harus diisi !' : null,
                            labelText: "Akomodasi",
                            contentPadding: EdgeInsets.only(bottom: 1, left: 12),
                            border: OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(8.0),
                              ),
                            ),
                          ),
                          keyboardType: TextInputType.text,
                        ),
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      InkWell(
                        onTap: () {
                          if (_tgl.text.isEmpty ||
                              _jamMulai.text.isEmpty ||
                              _jamSelesai.text.isEmpty ||
                              _selectedKajian == null ||
                              _tema.text.isEmpty ||
                              _jmlhPeserta.text.isEmpty ||
                              _selectedProvinsi == null ||
                              _selectedKota == null ||
                              _selectedKecamatan == null ||
                              _alamat.text.isEmpty ||
                              _akomodasi.text.isEmpty) {
                            setState(() {
                              _validate = true;
                              Toast.show("Lengkapi Semua Field !", context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                            });
                          } else {
                            Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.leftToRight,
                                    duration: Duration(milliseconds: 200),
                                    child: KonfirmasiJadwal(
                                      ustadz: widget.data.noHp,
                                      namaUstadz: widget.data.fullName,
                                      tgl: _tgl.text,
                                      jamMulai: _jamMulai.text,
                                      jamSelesai: _jamSelesai.text,
                                      jenisKegiatan: _selectedKajian,
                                      tema: _tema.text,
                                      jmlhPeserta: _jmlhPeserta.text,
                                      provinsi: _selectedProvinsi,
                                      kota: _selectedKota,
                                      kecamatan: _selectedKecamatan,
                                      alamat: _alamat.text,
                                      akomodasi: _akomodasi.text,
                                      namaKota: _namaKota,
                                    )));
                          }
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width - 12,
                          height: 50,
                          margin: EdgeInsets.only(left: 12, right: 12, bottom: 12),
                          decoration: BoxDecoration(color: colorses.biru2, borderRadius: BorderRadius.circular(12)),
                          child: Center(
                              child: Text(
                            "Lanjutkan",
                            style: TextStyle(color: Colors.white),
                          )),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
