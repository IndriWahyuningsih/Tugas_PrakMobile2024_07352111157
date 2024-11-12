import 'dart:async';

class Product {
  String productName;
  double price;
  bool inStock;

  Product(this.productName, this.price, this.inStock);

  void display() => print('Produk: $productName, Harga: \$${price.toStringAsFixed(2)}, in stock: $inStock');
}

enum Role { Admin, Customer }

abstract class User {
  String name;
  int age;
  late List<Product> products;
  Role? role;

  User(this.name, this.age, this.role);

  void displayProduct() => products.isEmpty
    ? print('Tidak ada produk $name')
    : products.forEach((product) => product.display());
}

class AdminUser extends User {
  AdminUser(String name, int age) : super(name, age, Role.Admin) {
    products = [];
  }

  void addProduct(Product product) {
    try {
      if (product.inStock) {
        products.add(product);
        print('Menambahkan: ${product.productName}');
      } else {
        throw Exception('Stok ${product.productName} kosong');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void removeProduct(Product product) {
    products.remove(product);
    print('Menghapus: ${product.productName}');
  }
}

class CustomerUser extends User {
  CustomerUser(String name, int age) : super(name, age, Role.Customer) {
    products = [];
  }
}

Future<void> fetchProductDetails(String productName) async {
  print('Fetching details for $productName...');
  await Future.delayed(Duration(seconds: 2));
  print('$productName details fetched');
}

void main() async {
  var admin = AdminUser('Indri', 20);
  var customer = CustomerUser('Amel', 21);
//indri
  var laptop = Product('Laptop', 999.99, true);
  var phone = Product('Phone', 499.99, false);

  var productsSet = {laptop, phone};

  admin.addProduct(laptop);
  admin.addProduct(phone);

  customer.products = List.from(productsSet);
  customer.displayProduct();

  await fetchProductDetails('Laptop');
}