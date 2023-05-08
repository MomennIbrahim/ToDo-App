class TaskModel{
  String? title;
  String? dateTime;
  String? time;
  String? taskId;

  TaskModel({this.title,this.dateTime,this.time,this.taskId});

  TaskModel.fromJson(Map<String,dynamic> json){
    title = json['title'];
    dateTime = json['dateTime'];
    time = json['time'];
    taskId = json['TaskId'];

  }
  Map<String,dynamic> toMap(){
    return {
      'title' : title,
      'dateTime' : dateTime,
      'time' : time,
      'taskId' : taskId,
    };
  }
}