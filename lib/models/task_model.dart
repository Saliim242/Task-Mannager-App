class TaskModel {
  int? id;
  String? title;
  String? notes;
  int? isComplete;
  String? dateTime;
  String? startTime;
  String? endTime;
  int? setColor;
  int? remind;
  String? repeating;

  // Constructor Class Methods
  TaskModel(
      {this.id,
      this.title,
      this.notes,
      this.isComplete,
      this.dateTime,
      this.startTime,
      this.endTime,
      this.setColor,
      this.remind,
      this.repeating});

  TaskModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    notes = json['notes'];
    isComplete = json['isComplete'];
    dateTime = json['dateTime'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    setColor = json['setColor'];
    remind = json['remind'];
    repeating = json['repeating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['notes'] = this.notes;
    data['isComplete'] = this.isComplete;
    data['dateTime'] = this.dateTime;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['setColor'] = this.setColor;
    data['remind'] = this.remind;
    data['repeating'] = this.repeating;
    return data;
  }
}
