class ProductModel {
  final String productname;
  final int productprice;
  final String productimage;
  final String productdescription;
  final String productid;
  final int availablequantity;
  ProductModel(
      {required this.productname,
      required this.productprice,
      required this.productimage,
      required this.productid,
      required this.productdescription,
      required this.availablequantity});
}
