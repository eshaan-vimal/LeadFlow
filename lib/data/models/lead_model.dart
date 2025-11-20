import 'package:equatable/equatable.dart';


class Lead extends Equatable 
{
  final int? id;
  final String name;
  final String contact;
  final String status;
  final String? notes;
  final DateTime createdTime;

  const Lead({
    this.id,
    required this.name,
    required this.contact,
    required this.status,
    this.notes,
    required this.createdTime,
  });


  Lead copyWith({
    int? id,
    String? name,
    String? contact,
    String? status,
    String? notes,
    DateTime? createdTime,
  }) 
  {
    return Lead(
      id: id ?? this.id,
      name: name ?? this.name,
      contact: contact ?? this.contact,
      status: status ?? this.status,
      notes: notes ?? this.notes,
      createdTime: createdTime ?? this.createdTime,
    );
  }


  Map<String, dynamic> toMap() 
  {
    return {
      'id': id,
      'name': name,
      'contact': contact,
      'status': status,
      'notes': notes,
      'createdTime': createdTime.toIso8601String(),
    };
  }


  factory Lead.fromMap(Map<String, dynamic> map) 
  {
    return Lead(
      id: map['id'],
      name: map['name'],
      contact: map['contact'],
      status: map['status'],
      notes: map['notes'],
      createdTime: DateTime.parse(map['createdTime']),
    );
  }


  @override
  List<Object?> get props => [id, name, contact, status, notes, createdTime];
}