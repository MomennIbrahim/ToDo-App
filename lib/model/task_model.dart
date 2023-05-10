class TaskModel{
  String? title;
  String? content;
  String? dateTime;
  String? time;
  String? taskId;

  TaskModel({this.title,this.dateTime,this.time,this.taskId,this.content});

  TaskModel.fromJson(Map<String,dynamic> json){
    title = json['title'];
    content = json['content'];
    dateTime = json['dateTime'];
    time = json['time'];
    taskId = json['TaskId'];

  }
  Map<String,dynamic> toMap(){
    return {
      'title' : title,
      'content' : content,
      'dateTime' : dateTime,
      'time' : time,
      'taskId' : taskId,
    };
  }
}