enum Mode{
   Food,
   Travel,
   Lesiure,
   Work


}
class ExpenseModel{
  ExpenseModel({required  this.title,required this.amount,required this.date,required this.mode});
 final String title;
 final double amount;
 final DateTime date;
  final Mode mode;
  
}


