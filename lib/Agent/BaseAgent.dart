class BaseAgent {
//  .*?\s+(\w+)(?:;|(?:\s+=.*;))
  static String name = "BaseAgent";
  static DateTime DefaultDateTime = DateTime(2010);
  String _UUID = "";

  DateTime lastRun = DefaultDateTime;
  static String AgentUUID =
      "36aee99f-5ce8-4726-802d-363308bb9054"; //https://www.uuidgenerator.net/


  String get UUID => _UUID;

  //  this.$1,
  BaseAgent(){
    _UUID = "";// todo generate UUID here
  }

  void doWork() {
    this.lastRun = DateTime.now();
  }

  void fromJson(Map<String, dynamic> json) {
    if (AgentUUID != json['AgentUUID']) return;
//    this.$1 = json['$1'];
    this.UUID = json['UUID'];
    this.lastRun = json['lastRun'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
//    data['$1'] = this.$1;
    data['UUID'] = this.UUID;
    data['lastRun'] = this.lastRun;

    return data;
  }
}
