class ProdukApple {
  String nama;
  double harga;
  String _kategori;

  ProdukApple(this.nama, this.harga, {String kategori = 'Tidak diketahui'}) : _kategori = kategori;

  void tampilkanDetail() {
    print("Produk: $nama, Harga: Rp $harga, Kategori: $_kategori");
  } 

  String get kategori => _kategori;

  set kategori(String kategori) {
    _kategori = kategori;
  }
}

class iPhone extends ProdukApple {
  String model;
  int kapasitas;

  iPhone(String nama, double harga, this.model, this.kapasitas, {String kategori = 'Telepon'})
    : super(nama, harga, kategori: kategori);

  void tampilkanModel() {
    print("Ini adalah iPhone model $model dengan kapasitas $kapasitas GB");
  }
}

abstract class FiturApple {
  void detailFitur();
}

class Macbook extends ProdukApple implements FiturApple {
  String prosesor;
  int ram;

  Macbook(String nama, double harga, this.prosesor, this.ram, {String kategori = 'Laptop'})
    : super(nama, harga, kategori: kategori);

  @override
  void detailFitur() {
    print("Macbook dengan prosesor: $prosesor dan RAM: ${ram} GB");
  }
}

mixin TahanAir {
  void tingkatKetahananAir() {
    print("Produk ini tahan air hingga 2 meter selama 30 menit");
  }
}

class AppleWatch extends ProdukApple with TahanAir {
  AppleWatch(String nama, double harga, {String kategori = 'Wearable'})
    : super(nama, harga, kategori: kategori);
}

enum KategoriProduk {telepon, laptop, wearable, tablet}

void main() {
  var iphone = iPhone('iPhone 11', 8000000, '11 Pro', 128, kategori: 'Telepon');
  iphone.tampilkanDetail();
  iphone.tampilkanModel();

  var macbook = Macbook('Macbook Pro', 10000000, 'MI', 16, kategori: 'Laptop');
  macbook.tampilkanDetail();
  macbook.detailFitur();

  var applewatch = AppleWatch('Apple Watch Series 8', 7000000);
  applewatch.tampilkanDetail();
  applewatch.tingkatKetahananAir();

  KategoriProduk kategoriFavorit = KategoriProduk.telepon;
  switch (kategoriFavorit) {
    case KategoriProduk.telepon:
      print("Kategori produk favorit adalah Telepon");
      break;
    case KategoriProduk.laptop:
      print("Kategori produk favorit adalah Laptop");
      break;
    case KategoriProduk.wearable:
      print("Kategori produk favorit adalah Wearable");
      break;
    case KategoriProduk.tablet:
      print("Kategori produk favorit adalah Tablet");
      break;
  }
}

// link referensi: https://codekey.id/dart/dart-enumeration/