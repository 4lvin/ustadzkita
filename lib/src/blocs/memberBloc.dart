import 'package:daikita/src/models/getBannerAtasModel.dart';
import 'package:daikita/src/models/getBannerQuotesModel.dart';
import 'package:daikita/src/models/getBannerTengahModel.dart';
import 'package:daikita/src/models/getJadwalSholatModel.dart';
import 'package:daikita/src/models/getKecamatanModel.dart';
import 'package:daikita/src/models/getKotaModel.dart';
import 'package:daikita/src/models/getLoginModel.dart';
import 'package:daikita/src/models/getProvinsiModel.dart';
import 'package:daikita/src/models/resKonfirmOtpModel.dart';
import 'package:daikita/src/models/resLoginGmailModel.dart';
import 'package:daikita/src/models/resLupaPasswordModel.dart';
import 'package:daikita/src/models/resRegisterGuestModel.dart';
import 'package:daikita/src/resources/repositories.dart';
import 'package:rxdart/rxdart.dart';

class MemberBloc {
  final _repository = Repositories();
  final _loginFetcher = PublishSubject<GetLoginModel>();
  final _daftarGuestFetcher = PublishSubject<ResRegisterGuestModel>();
  final _konfirmOtpFetcher = PublishSubject<ResKonfirmOtpModel>();
  final _provinsiFetcher = PublishSubject<GetProvinsiModel>();
  final _kotaFetcher = PublishSubject<GetKotaModel>();
  final _kecamatanFetcher = PublishSubject<GetKecamatanModel>();
  final _loginGmailFetcher = PublishSubject<ResLoginGmailModel>();
  final _afterLoginGmailFetcher = PublishSubject<GetLoginModel>();
  final _lupaPasswordFetcher = PublishSubject<ResLupaPasswordModel>();
  final _bannerQuotesFetcher = PublishSubject<GetBannerQuoteModel>();
  final _bannerTengahFetcher = PublishSubject<GetBannerTengahModel>();
  final _bannerAtasFetcher = PublishSubject<GetBannerAtasModel>();

  PublishSubject<GetLoginModel> get resLogin => _loginFetcher.stream;

  PublishSubject<ResRegisterGuestModel> get resRegister => _daftarGuestFetcher.stream;

  PublishSubject<ResKonfirmOtpModel> get resKonfirmOtp => _konfirmOtpFetcher.stream;

  PublishSubject<GetProvinsiModel> get resProvinsi => _provinsiFetcher.stream;

  PublishSubject<GetKotaModel> get resKota => _kotaFetcher.stream;

  PublishSubject<GetKecamatanModel> get resKecamatan => _kecamatanFetcher.stream;

  PublishSubject<ResLoginGmailModel> get resLoginGmail => _loginGmailFetcher.stream;

  PublishSubject<GetLoginModel> get resAfterLoginGmail => _afterLoginGmailFetcher.stream;

  PublishSubject<ResLupaPasswordModel> get resLupaPassword => _lupaPasswordFetcher.stream;

  PublishSubject<GetBannerQuoteModel> get resBannerQuote => _bannerQuotesFetcher.stream;

  PublishSubject<GetBannerTengahModel> get resBannerTengah => _bannerTengahFetcher.stream;

  PublishSubject<GetBannerAtasModel> get resBannerAtas => _bannerAtasFetcher.stream;

  login(String username, String password) async {
    try {
      GetLoginModel getLoginModel = await _repository.login(username, password);
      _loginFetcher.sink.add(getLoginModel);
    } catch (error) {
      _loginFetcher.sink.add(error);
    }
  }

  daftarGuest(String username, String password, String fullName, String noHp, String email, String provinsi, String kota,
      String kecamatan) async {
    try {
      ResRegisterGuestModel registerGuestModel =
          await _repository.daftarGuest(username, password, fullName, noHp, email, provinsi, kota, kecamatan);
      _daftarGuestFetcher.sink.add(registerGuestModel);
    } catch (error) {
      _daftarGuestFetcher.sink.add(error);
    }
  }

  konfirmOtp(String username, String kode) async {
    try {
      ResKonfirmOtpModel resKonfirmOtpModel = await _repository.konfirmOtp(username, kode);
      _konfirmOtpFetcher.sink.add(resKonfirmOtpModel);
    } catch (error) {
      _konfirmOtpFetcher.sink.add(error);
    }
  }

  getProvinsi() async {
    try {
      GetProvinsiModel getProvinsiModel = await _repository.getProvinsi();
      _provinsiFetcher.sink.add(getProvinsiModel);
    } catch (error) {
      _provinsiFetcher.sink.add(error);
    }
  }

  getKota(String kodeProv) async {
    try {
      GetKotaModel getKotaModel = await _repository.getKota(kodeProv);
      _kotaFetcher.sink.add(getKotaModel);
    } catch (error) {
      _kotaFetcher.sink.add(error);
    }
  }

  getKecamatan(String kodeProv, String kodeKota) async {
    try {
      GetKecamatanModel getKecamatanModel = await _repository.getKecamatan(kodeProv, kodeKota);
      _kecamatanFetcher.sink.add(getKecamatanModel);
    } catch (error) {
      _kecamatanFetcher.sink.add(error);
    }
  }

  loginGmail(String email, String name) async {
    try {
      ResLoginGmailModel resLoginGmailModel = await _repository.loginGmail(email, name);
      _loginGmailFetcher.sink.add(resLoginGmailModel);
    } catch (error) {
      _loginGmailFetcher.sink.add(error);
    }
  }

  afterLoginGmail(String email, String provinsi, String kota, String kecamatan) async {
    try {
      GetLoginModel getLoginModel = await _repository.afterLoginGmail(email, provinsi, kota, kecamatan);
      _afterLoginGmailFetcher.sink.add(getLoginModel);
    } catch (error) {
      _afterLoginGmailFetcher.sink.add(error);
    }
  }

  lupaPassword(String noHp) async {
    try {
      ResLupaPasswordModel resLupaPasswordModel = await _repository.lupaPassword(noHp);
      _lupaPasswordFetcher.sink.add(resLupaPasswordModel);
    } catch (error) {
      _lupaPasswordFetcher.sink.add(error);
    }
  }

  bannerQuotes() async {
    try {
      GetBannerQuoteModel getBannerQuoteModel = await _repository.bannerQuotes();
      _bannerQuotesFetcher.sink.add(getBannerQuoteModel);
    } catch (error) {
      _bannerQuotesFetcher.sink.add(error);
    }
  }

  bannerTengah() async {
    try {
      GetBannerTengahModel getBannerTengahModel = await _repository.bannerTengah();
      _bannerTengahFetcher.sink.add(getBannerTengahModel);
    } catch (error) {
      _bannerTengahFetcher.sink.add(error);
    }
  }

  bannerAtas() async {
    try {
      GetBannerAtasModel getBannerAtasModel = await _repository.bannerAtas();
      _bannerAtasFetcher.sink.add(getBannerAtasModel);
    } catch (error) {
      _bannerAtasFetcher.sink.add(error);
    }
  }

  dispose() {
    _loginFetcher.close();
    _daftarGuestFetcher.close();
    _konfirmOtpFetcher.close();
    _provinsiFetcher.close();
    _kotaFetcher.close();
    _kecamatanFetcher.close();
    _loginGmailFetcher.close();
    _afterLoginGmailFetcher.close();
    _lupaPasswordFetcher.close();
    _bannerQuotesFetcher.close();
    _bannerTengahFetcher.close();
    _bannerAtasFetcher.close();
  }
}

final memberBloc = MemberBloc();
