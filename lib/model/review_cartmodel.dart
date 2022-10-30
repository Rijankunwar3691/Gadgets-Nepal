class ReviewCartModel {
  String cartid;
  String cartname;
  String cartimage;
  int cartprice;
  int cartquantity;

  ReviewCartModel(
      {required this.cartimage,
      required this.cartname,
      required this.cartprice,
      required this.cartid,
      required this.cartquantity});
}
