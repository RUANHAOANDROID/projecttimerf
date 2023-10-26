
class Customer {
   String id="";
   String name="";
   String email="";
   String address="";
   String phone="";
   int  use_time=0;
   int  end_time=0;

   Customer({required id, required name, required email, required address, required phone, required use_time, required end_time});
   Customer.empty();
   factory Customer.fromJson(Map<String, dynamic> json) {
     return Customer(
       id: json['id'],
       name: json['name'],
       email: json['email'],
       address: json['address'],
       phone: json['phone'],
       use_time: json['use_time'],
       end_time: json['end_time'],
     );
   }
}