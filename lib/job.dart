class Job {
  final int? id;
  final String name;
  final String email;

  Job({this.id, required this.name, required this.email});

  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
        id: json['id'],
        name: json['name'],
        email: json['email']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email
    };
  } 
}