import 'package:daikita/src/resources/apiProviders.dart';

class Repositories {
  final apiProvider = ApiProviders();

  Future getJadwalSholat(int kota, String tgl) => apiProvider.getJadwalSholat(kota, tgl);

  Future login(String username, String password) => apiProvider.login(username, password);

  Future daftarGuest(String username, String password, String fullName, String noHp, String email, String provinsi, String kota,
          String kecamatan) =>
      apiProvider.daftarGuest(username, password, fullName, noHp, email, provinsi, kota, kecamatan);

  Future konfirmOtp(String username, String kode) => apiProvider.konfirmOtp(username, kode);

  Future getProvinsi() => apiProvider.getProvinsi();

  Future getKota(String kodeProv) => apiProvider.getKota(kodeProv);

  Future getKecamatan(String kodeProv, String kodeKota) => apiProvider.getKecamatan(kodeProv, kodeKota);

  Future getListUstadz(String kota, String token) => apiProvider.getListUstadz(kota, token);

  Future undangan(String ustadz, String tgl, String awal, String akhir, String jenisKajian, String provinsi, String kota,
          String kecamatan, String tema, String jmlhPeserta, String alamat, String akomodasi, String token) =>
      apiProvider.undangan(
          ustadz, tgl, awal, akhir, jenisKajian, provinsi, kota, kecamatan, tema, jmlhPeserta, alamat, akomodasi, token);

  Future masterKajian(String token) => apiProvider.masterKajian(token);

  Future listUndangan(String token, String status) => apiProvider.listUndangan(token, status);

  Future detailUndangan(String kode, String token) => apiProvider.detailUndangan(kode, token);

  Future jadwalUstadz(String token) => apiProvider.jadwalUstadz(token);

  Future ustadzKonfirmUndangan(String kode, String status, String token) =>
      apiProvider.ustadzKonfirmUndangan(kode, status, token);

  Future jadwalSholatTerdekat(String jam, String kode, String tgl) => apiProvider.jadwalSholatTerdekat(jam, kode, tgl);

  Future loginGmail(String email, String name) => apiProvider.loginGmail(email, name);

  Future afterLoginGmail(String email, String provinsi, String kota, String kecamatan) =>
      apiProvider.afterLoginGmail(email, provinsi, kota, kecamatan);

  Future chatList(String token) => apiProvider.chatList(token);

  Future checkChatDetail(String token, String email) => apiProvider.checkChatDetail(token, email);

  Future chatListDetail(String token, String email, String topik) => apiProvider.chatListDetail(token, email, topik);

  Future sendChat(String token, String email, String pesan) => apiProvider.sendChat(token, email, pesan);

  Future listKategori(String kategori) => apiProvider.listKategori(kategori);

  Future listDoa(String label) => apiProvider.listDoa(label);

  Future detailDoa(String token, String artikel) => apiProvider.detailDoa(token, artikel);

  Future lupaPassword(String noHp) => apiProvider.lupaPassword(noHp);

  Future markArtikel(String token, String artikel) => apiProvider.markArtikel(token, artikel);

  Future listMarkArtikel(String token, String label) => apiProvider.listMarkArtikel(token, label);

  Future profilUstadz(String noHp) => apiProvider.profilUstadz(noHp);

  Future bannerQuotes() => apiProvider.bannerQuotes();

  Future bannerTengah() => apiProvider.bannerTengah();

  Future bannerAtas() => apiProvider.bannerAtas();
}
