class CategoryWithProduct {
  final String idCategory;
  final String category;
  final String image;
  final String status;

  CategoryWithProduct({
    required this.idCategory,
    required this.category,
    required this.image,
    required this.status,
  });

  factory CategoryWithProduct.fromJson(Map<dynamic, dynamic> data){
    return CategoryWithProduct(
      idCategory: data['idCategory'] as String, 
      category: data['category'] as String, 
      image: data['image'] as String, 
      status: data['status'] as String);
  }
}

class ProductModel{
  final String idProduct;
  final String idCategory;
  final String nameProduct;
  final String description;
  final String imageProduct;
  final String price;
  final String status;
  final String createAt;

  ProductModel({
    required this.idProduct ,
    required this.idCategory,
    required this.nameProduct,
    required this.description,
    required this.imageProduct,
    required this.price,
    required this.status,
    required this.createAt,
  });

  factory ProductModel.fromJson(Map<String, dynamic> data){
    return ProductModel(
    idProduct: data['idProduct'], 
    idCategory: data['idCategory'], 
    nameProduct: data['nameProduct'], 
    description: data['description'], 
    imageProduct: data['imageProduct'], 
    price: data['price'], 
    status: data['status'], 
    createAt: data['createAt']);
  }
}