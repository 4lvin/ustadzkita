import 'package:daikita/src/models/getDetailDoaModel.dart';
import 'package:daikita/src/models/getDetailUndanganModel.dart';
import 'package:daikita/src/models/getDetailUstadzModel.dart';
import 'package:daikita/src/models/getJadwalSholatModel.dart';
import 'package:daikita/src/models/getJadwalUstadzModel.dart';
import 'package:daikita/src/models/getListDoaModel.dart';
import 'package:daikita/src/models/getListKategoriModel.dart';
import 'package:daikita/src/models/getListMarkArtikelModel.dart';
import 'package:daikita/src/models/getListUndanganModel.dart';
import 'package:daikita/src/models/getListUstadzModel.dart';
import 'package:daikita/src/models/getMasterKajianModel.dart';
import 'package:daikita/src/models/getUndanganModel.dart';
import 'package:daikita/src/models/jadwalSholatTerdekatModel.dart';
import 'package:daikita/src/models/resMarkArtikelModel.dart';
import 'package:daikita/src/models/resUstadzKonfirmModel.dart';
import 'package:daikita/src/resources/repositories.dart';
import 'package:rxdart/rxdart.dart';

class FiturBloc {
  final _repository = Repositories();
  final _jadwalSholatFetcher = PublishSubject<GetJadwalSholatModel>();
  final _ustadzFetcher = PublishSubject<GetListUstadzModel>();
  final _undanganFetcher = PublishSubject<GetUndanganModel>();
  final _masterKajianFetcher = PublishSubject<GetMasterKajianModel>();
  final _undanganListFetcher = PublishSubject<GetListUndanganModel>();
  final _undanganDetailFetcher = PublishSubject<GetDetailUndanganModel>();
  final _jadwalUstadzFetcher = PublishSubject<GetJadwalUstadzModel>();
  final _ustadzKonfirmasiFetcher = PublishSubject<ResUstadzKonfirmModel>();
  final _jadwalSholatTerdekatFetcher = PublishSubject<JadwalSholatTerdekatModel>();
  final _listKategoriFetcher = PublishSubject<GetListKategoriModel>();
  final _listDoaFetcher = PublishSubject<GetListDoaModel>();
  final _detailDoaFetcher = PublishSubject<GetDetailDoaModel>();
  final _markArtikelFetcher = PublishSubject<ResMarkArtikelModel>();
  final _listMarkArtikelFetcher = PublishSubject<GetListMarkArtikelModel>();
  final _profilUstadzFetcher = PublishSubject<GetDetailUstadzModel>();

  PublishSubject<GetJadwalSholatModel> get resJadwalSholat => _jadwalSholatFetcher.stream;

  PublishSubject<GetListUstadzModel> get resListUstadz => _ustadzFetcher.stream;

  PublishSubject<GetUndanganModel> get resUndangan => _undanganFetcher.stream;

  PublishSubject<GetMasterKajianModel> get resKajian => _masterKajianFetcher.stream;

  PublishSubject<GetListUndanganModel> get resUndanganList => _undanganListFetcher.stream;

  PublishSubject<GetDetailUndanganModel> get resUndanganDetail => _undanganDetailFetcher.stream;

  PublishSubject<GetJadwalUstadzModel> get resjadwalUstadz => _jadwalUstadzFetcher.stream;

  PublishSubject<ResUstadzKonfirmModel> get resustadzKonfirmasi => _ustadzKonfirmasiFetcher.stream;

  PublishSubject<JadwalSholatTerdekatModel> get resJadwalTerdekat => _jadwalSholatTerdekatFetcher.stream;

  PublishSubject<GetListKategoriModel> get resListKategori => _listKategoriFetcher.stream;

  PublishSubject<GetListDoaModel> get resListDoa => _listDoaFetcher.stream;

  PublishSubject<GetDetailDoaModel> get resDetailDoa => _detailDoaFetcher.stream;

  PublishSubject<ResMarkArtikelModel> get resMarkArtikel => _markArtikelFetcher.stream;

  PublishSubject<GetListMarkArtikelModel> get resListMarkArtikel => _listMarkArtikelFetcher.stream;

  PublishSubject<GetDetailUstadzModel> get resProfilUstadz => _profilUstadzFetcher.stream;

  getJadwalSholat(int kota, String tgl) async {
    try {
      GetJadwalSholatModel getJadwalSholatModel = await _repository.getJadwalSholat(kota, tgl);
      _jadwalSholatFetcher.sink.add(getJadwalSholatModel);
    } catch (error) {
      _jadwalSholatFetcher.sink.add(error);
    }
  }

  getListUstadz(String kota, String token) async {
    try {
      GetListUstadzModel getListUstadzModel = await _repository.getListUstadz(kota, token);
      _ustadzFetcher.sink.add(getListUstadzModel);
    } catch (error) {
      _ustadzFetcher.sink.add(error);
    }
  }

  undangan(String ustadz, String tgl, String awal, String akhir, String jenisKajian, String provinsi, String kota,
      String kecamatan, String tema, String jmlhPeserta, String alamat, String akomodasi, String token) async {
    try {
      GetUndanganModel getUndanganModel = await _repository.undangan(
          ustadz, tgl, awal, akhir, jenisKajian, provinsi, kota, kecamatan, tema, jmlhPeserta, alamat, akomodasi, token);
      _undanganFetcher.sink.add(getUndanganModel);
    } catch (error) {
      _undanganFetcher.sink.add(error);
    }
  }

  masterKajian(String token) async {
    try {
      GetMasterKajianModel getMasterKajianModel = await _repository.masterKajian(token);
      _masterKajianFetcher.sink.add(getMasterKajianModel);
    } catch (error) {
      _masterKajianFetcher.sink.add(error);
    }
  }

  listUndangan(String token, String status) async {
    try {
      GetListUndanganModel getListUndanganModel = await _repository.listUndangan(token, status);
      _undanganListFetcher.sink.add(getListUndanganModel);
    } catch (error) {
      _undanganListFetcher.sink.add(error);
    }
  }

  detailUndangan(String kode, String token) async {
    try {
      GetDetailUndanganModel getDetailUndanganModel = await _repository.detailUndangan(kode, token);
      _undanganDetailFetcher.sink.add(getDetailUndanganModel);
    } catch (error) {
      _undanganDetailFetcher.sink.add(error);
    }
  }

  jadwalUstadz(String token) async {
    try {
      GetJadwalUstadzModel getJadwalUstadzModel = await _repository.jadwalUstadz(token);
      _jadwalUstadzFetcher.sink.add(getJadwalUstadzModel);
    } catch (error) {
      _jadwalUstadzFetcher.sink.add(error);
    }
  }

  ustadzKonfirm(String kode, String status, String token) async {
    try {
      ResUstadzKonfirmModel resUstadzKonfirmModel = await _repository.ustadzKonfirmUndangan(kode, status, token);
      _ustadzKonfirmasiFetcher.sink.add(resUstadzKonfirmModel);
    } catch (error) {
      _ustadzKonfirmasiFetcher.sink.add(error);
    }
  }

  jadwalSholatTerdekat(String jam, String kode, String tgl) async {
    try {
      JadwalSholatTerdekatModel jadwalSholatTerdekatModel = await _repository.jadwalSholatTerdekat(jam, kode, tgl);
      _jadwalSholatTerdekatFetcher.sink.add(jadwalSholatTerdekatModel);
    } catch (error) {
      _jadwalSholatTerdekatFetcher.sink.add(error);
    }
  }

  listKategori(String kategori) async {
    try {
      GetListKategoriModel getListKategoriModel = await _repository.listKategori(kategori);
      _listKategoriFetcher.sink.add(getListKategoriModel);
    } catch (error) {
      _listKategoriFetcher.sink.add(error);
    }
  }

  listDoa(String label) async {
    try {
      GetListDoaModel getListDoaModel = await _repository.listDoa(label);
      _listDoaFetcher.sink.add(getListDoaModel);
    } catch (error) {
      print(error);
      _listDoaFetcher.sink.add(error);
    }
  }

  detailDoa(String token, String artikel) async {
    try {
      GetDetailDoaModel getDetailDoaModel = await _repository.detailDoa(token, artikel);
      _detailDoaFetcher.sink.add(getDetailDoaModel);
    } catch (error) {
      print(error);
      _detailDoaFetcher.sink.add(error);
    }
  }

  markArtikel(String token, String artikel) async {
    try {
      ResMarkArtikelModel resMarkArtikelModel = await _repository.markArtikel(token, artikel);
      _markArtikelFetcher.sink.add(resMarkArtikelModel);
    } catch (error) {
      print(error);
      _markArtikelFetcher.sink.add(error);
    }
  }

  listMarkArtikel(String token, String label) async {
    try {
      GetListMarkArtikelModel getListMarkArtikelModel = await _repository.listMarkArtikel(token, label);
      _listMarkArtikelFetcher.sink.add(getListMarkArtikelModel);
    } catch (error) {
      print(error);
      _listMarkArtikelFetcher.sink.add(error);
    }
  }

  profilUstadz(String noHp) async {
    try {
      GetDetailUstadzModel getDetailUstadzModel = await _repository.profilUstadz(noHp);
      _profilUstadzFetcher.sink.add(getDetailUstadzModel);
    } catch (error) {
      print(error);
      _profilUstadzFetcher.sink.add(error);
    }
  }

  dispose() {
    _jadwalSholatFetcher.close();
    _ustadzFetcher.close();
    _undanganFetcher.close();
    _masterKajianFetcher.close();
    _undanganListFetcher.close();
    _undanganDetailFetcher.close();
    _jadwalUstadzFetcher.close();
    _ustadzKonfirmasiFetcher.close();
    _jadwalSholatTerdekatFetcher.close();
    _listKategoriFetcher.close();
    _listDoaFetcher.close();
    _detailDoaFetcher.close();
    _markArtikelFetcher.close();
    _listMarkArtikelFetcher.close();
    _profilUstadzFetcher.close();
  }
}

final blocFitur = FiturBloc();
