class Productmodel {
   int  ? id;
   String? title;
   double? price;
   String? description;
   String? category;
   String?image;
    Ratingmodel ?rating;
   Productmodel({
      required this.id,

   required this.price,
   required this.title,
   required this.image,
   required this.category,
   required this.description,
   required this.rating,

});

   factory Productmodel.frommap(Map<String,dynamic>map){

      return Productmodel(
      id: map['id'],
         description: map['description'],
   price:map['price']?.toDouble(),
   title: map['title'],
   image: map['image'],
   category:map['category'],
  rating : map['rating'] != null? Ratingmodel.frommap(map['rating']): null,
      );
   }

Map<String,dynamic> tomap(){

      return{

         'id': id,
         'category': category,
         'title': title,
         'Rating': rating?.tomap(),
         'image': image,
         'discription': description,
         'price': price,


   };





}

}







class Ratingmodel{
   double? rate;
   double? count;
   Ratingmodel({
      required this.rate,
      required this.count
   });
factory Ratingmodel.frommap(Map<String,dynamic >map) => Ratingmodel(
   rate: map['rate']?.toDouble(),
   count: map['count']?.toDouble(),);


Map<String,dynamic>tomap(){
   return{

      'rate': rate,
      'count':count,


   };





}
}



