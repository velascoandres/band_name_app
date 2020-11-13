class Band {
  String id;
  String name;
  int votes;

  Band({this.id, this.name, this.votes});

  Band fromJson(Map<String, dynamic> json) => Band(
        id: json['id'],
        name: json['name'],
        votes: json['votes'],
      );
}
