// 1. implementasi kelas utama dan subkelas

//kategori produk digital
enum KategoriProduk {DataManagement, NetworkAutomation}

class ProdukDigital {
  String namaProduk;
  double harga;
  KategoriProduk kategori;

  ProdukDigital(this.namaProduk, this.harga, this.kategori) {
    if(kategori == KategoriProduk.NetworkAutomation && harga < 200000) {
      throw ArgumentError('Harga untuk NetworkAutomation harus minimal 200.000');
    } else if (kategori == KategoriProduk.DataManagement && harga >= 200000) {
      throw ArgumentError('Harga untuk DataManagement harus di bawah 200.000');
    }
  }

  void terapkanDiskon(int jumlahTerjual) {
    if (kategori == KategoriProduk.NetworkAutomation && jumlahTerjual > 50) {
      double hargaDiskon = harga * 0.85;
      harga = (hargaDiskon >= 200000) ? hargaDiskon : 200000;
    }
  }
}

abstract class Karyawan {
  String nama;
  int umur;
  String peran;

  Karyawan(this.nama, {required this.umur, required this.peran});

  void bekerja(); 
}

class KaryawanTetap extends Karyawan {
  KaryawanTetap(String nama, {required int umur, required String peran})
    : super(nama, umur: umur, peran: peran);

  @override
  void bekerja() {
    print('$nama bekerja selama hari kerja reguler');
  }
}

class KaryawanKontrak extends Karyawan {
  KaryawanKontrak(String nama, {required int umur, required String peran})
    : super(nama, umur: umur, peran: peran);

  @override
  void bekerja() {
    print('$nama bekerja pada proyek tertentu dalam periode waktu tertentu');
  }
}

//2. penggunaan positional dan named arguments
void contohPenggunaan() {
  var karyawan = KaryawanTetap('Indri', umur: 20, peran: 'Developer');
  print('Nama: ${karyawan.nama}, Umur: ${karyawan.umur}, Peran: ${karyawan.peran}');
}

//3. mixin kinerja untuk produktivitas
mixin Kinerja {
  int produktivitas = 0;
  DateTime lastUpdate = DateTime.now();

  void updateProduktivitas(int nilai) {
    if (DateTime.now().difference(lastUpdate).inDays >= 30) {
      produktivitas = (produktivitas + nilai).clamp(0, 100);
      lastUpdate = DateTime.now();
    }
  }
}

// menerapkan mixin pada kelas karyawan dengan kondisi khusus untuk manager
class Manager extends Karyawan with Kinerja {
  Manager(String nama, {required int umur, required String peran})
    : super(nama, umur: umur, peran: peran);
  
  @override
  void bekerja() {
    print('$nama bekerja sebagai manager');
  }

  @override
  void updateProduktivitas(int nilai) {
    super.updateProduktivitas(nilai);
    if (produktivitas < 85) {
      print('Peringatan: produktivitas manager harus di atas 85');
    }
  }
}

//4. enum faseproyek untuk konsistensi proyek
enum FaseProyek {Perencanaan, Pengembangan, Evaluasi}

class Proyek {
  FaseProyek fase = FaseProyek.Perencanaan;
  int jumlahKaryawanAktif = 0;
  DateTime mulaiProyek;

  Proyek(this.mulaiProyek);

  void lanjutkanFase() {
    if (fase == FaseProyek.Perencanaan && jumlahKaryawanAktif >= 5) {
      fase = FaseProyek.Pengembangan;
    } else if (fase == FaseProyek.Pengembangan &&
      DateTime.now().difference(mulaiProyek).inDays > 45) {
        fase = FaseProyek.Evaluasi;
    }
  }
}

//5. mekanisme pembatasan jumlah karyawan aktif
class Perusahaan {
  List<Karyawan> karyawanAktif = [];
  List<Karyawan> karyawanNonAktif = [];
  static const int maxKaryawanAktif = 20;

  void tambahKaryawan(Karyawan karyawan) {
    if (karyawanAktif.length < maxKaryawanAktif) {
      karyawanAktif.add(karyawan);
    } else {
      print('Karyawan aktif telah mencapai batas maksimum');
    }
  }

  void karyawanResign(Karyawan karyawan) {
    if (karyawanAktif.remove(karyawan)) {
      karyawanNonAktif.add(karyawan);
    }
  }
}

void main() {
  contohPenggunaan();

  var perusahaan = Perusahaan();
  var karyawan1 = KaryawanTetap('Amel', umur: 21, peran: 'Developer');
  perusahaan.tambahKaryawan(karyawan1);

  var proyek = Proyek(DateTime.now());
  proyek.jumlahKaryawanAktif = 5;
  proyek.lanjutkanFase();
  print('Fase proyek saat ini: ${proyek.fase}');
}