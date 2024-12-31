class Category{
   late int categoryID;
  late final String categoryTitle;
  Category({required this.categoryTitle}); // ==> We can use the constructor because we create the category without a category ID. The category ID is generated automatically.
  Category.withID(this.categoryID,this.categoryTitle); // We can use the constructor from database reader.
Map<String,dynamic> toMap(){
  var map= Map<String, dynamic>();
  map['categoryID']=categoryID;
  map['categoryTitle'] = categoryTitle;

  return map;
}

Category.fromMap(Map<String,dynamic> map){
  this.categoryID=map['categoryID'];
  this.categoryTitle=map['categoryTitle'];

}
@override
  String toString() {
    // TODO: implement toString
    return 'Category {category ID: $categoryID, category Title: $categoryTitle}';
  }

}