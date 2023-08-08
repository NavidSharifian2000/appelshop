abstract class CategoryProductEvent {}

class categoryProductInitialize extends CategoryProductEvent {
  String CategoryId;
  categoryProductInitialize(this.CategoryId);
}
