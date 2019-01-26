//this is the model class, in other words, data model for example
class Todo {
  //parameters
  int _id;
  String _title;
  String _description;
  String _date;
  int _priority;
  //constructors
  Todo(this._title, this._date, this._priority, [this._description]);
  Todo.withID(this._id, this._title, this._date, this._priority,
      [this._description]); /* for example when you retrive or use DB*/
  Todo.fromObject(dynamic obj) {
    this._id = obj["id"];
    this._title = obj["title"];
    this._description = obj["description"];
    this._date = obj["date"];
    this._priority = obj["priority"];
  }
  //getters
  int get id => this._id;
  int get priority => this._priority;
  String get title => this._title;
  String get description => this._description;
  String get date => this._date;
  // setters
  set title(String newTitle) {
    if (newTitle.length <= 255) {
      this._title = newTitle;
    }
  }

  set description(String newDescription) {
    if (newDescription.length <= 255) {
      this._description = newDescription;
    }
  }

  set date(String newDate) {
    this._date = newDate;
  }

  set priority(int newPriority) {
    if (newPriority <= 3 && newPriority > 0) {
      this._priority = newPriority;
    }
  }

  // other methods
  Map<String, dynamic> toMaps() {
    // maps are collections of key value pairs , and can be iterated (manepulated through index)
    var map = Map<String, dynamic>(); // create an object of type map
    map["title"] = this._title;
    if (_id != null) map["id"] = this._id;
    map["priority"] = this._priority;
    map["date"] = this._date;
    map["description"] = this._description;
    return map;
  }
}
