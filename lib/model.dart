class TodoModel {
  late final int? id;
  late final String? title;
  late final String? desc;
  late final String? dateandtime;

  TodoModel({
    this.id,
    this.title,
    this.desc,
    this.dateandtime
  });

  TodoModel.fromMap(Map<String, dynamic>res)
     :id = res['id'],
     title = res['title'],
     desc = res['desc'],
     dateandtime = res['dateandtime'];

   Map<String, Object?> toMap(){
     return {
       'id': id,
       'title':title,
       'desc':desc,
       'dateandtime':dateandtime
     };
   }
}