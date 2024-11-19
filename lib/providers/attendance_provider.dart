import 'package:flutter/material.dart';
import '../models/student.dart';
import '../models/attendance_record.dart';

class AttendanceProvider extends ChangeNotifier {
  List<Student> _students = [
    Student(name: 'Avail'),
    Student(name: 'Dika'),
    Student(name: 'Arla'),
    Student(name: 'Febri'),
  ];
  List<AttendanceRecord> _records = [];

  List<Student> get students => _students;
  List<AttendanceRecord> get records => _records;

  void toggleAttendance(int index) {
    _students[index].isPresent = !_students[index].isPresent;
    notifyListeners();
  }

  void saveAttendance() {
    int present = _students.where((student) => student.isPresent).length;
    int absent = _students.length - present;

    _records.insert(
      0,
      AttendanceRecord(
        date: DateTime.now(),
        present: present,
        absent: absent,
      ),
    );

    // Reset attendance
    for (var student in _students) {
      student.isPresent = false;
    }
    
    notifyListeners();
  }
}