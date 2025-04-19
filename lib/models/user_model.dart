import 'package:cloud_firestore/cloud_firestore.dart';
import 'lab_result_entry_model.dart';

class UserModel {
  final String id;
  final String name;
  final String email;
  final String phone;
  final int age;

  /// Map from test name (e.g., "Calcium", "Thyroid") to list of results
  final Map<String, List<LabResultEntry>> labHistory;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.age,
    Map<String, List<LabResultEntry>>? labHistory,
  }) : labHistory = labHistory ?? {};

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'age': age,
      'labHistory': labHistory.map((test, entries) => MapEntry(
        test,
        entries.map((e) => e.toMap()).toList(),
      )),
    };
  }

  factory UserModel.fromDoc(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    final rawLab = data['labHistory'] as Map<String, dynamic>? ?? {};
    final parsedLab = rawLab.map((test, rawEntries) {
      final list = (rawEntries as List)
          .map((e) => LabResultEntry.fromMap(e as Map<String, dynamic>))
          .toList();
      return MapEntry(test, list);
    });

    return UserModel(
      id: doc.id,
      name: data['name'],
      email: data['email'],
      phone: data['phone'] ?? '',
      age: (data['age'] as num?)?.toInt() ?? 0,
      labHistory: parsedLab,
    );
  }
}
