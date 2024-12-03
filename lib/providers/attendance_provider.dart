import 'package:flutter/material.dart';
import '../models/student.dart';
import '../models/attendance_record.dart';

// Provider untuk mengelola state manajemen absensi
class AttendanceProvider extends ChangeNotifier {
  // Daftar siswa default
  final List<Student> _students = [
    Student(name: 'Avail'),
    Student(name: 'Dika'),
    Student(name: 'Arla'),
    Student(name: 'Febri'),
    Student(name: 'Hisyam'),
  ];

  // Daftar rekaman absensi
  final List<AttendanceRecord> _records = [];

  // Getter untuk akses data siswa
  List<Student> get students => _students;

  // Getter untuk akses rekaman absensi
  List<AttendanceRecord> get records => _records;

  // Fungsi untuk menambah siswa baru
  void addStudent(String name) {
    // Cek validasi nama
    if (name.isNotEmpty) {
      _students.add(Student(name: name));
      notifyListeners(); // Update UI
    }
  }

  // Fungsi untuk menghapus siswa
  void removeStudent(int index) {
    if (index >= 0 && index < _students.length) {
      _students.removeAt(index);
      notifyListeners(); // Update UI
    }
  }

  // Toggle kehadiran siswa
  void toggleAttendance(int index) {
    // Pastikan index valid
    if (index >= 0 && index < _students.length) {
      // Balik status kehadiran
      _students[index].isPresent = !_students[index].isPresent;
      notifyListeners(); // Trigger update UI
    }
  }

  // Simpan data absensi
  void saveAttendance() {
    // Hitung jumlah siswa hadir
    int present = _students.where((student) => student.isPresent).length;
    
    // Hitung jumlah siswa tidak hadir
    int absent = _students.length - present;

    // Validasi sebelum menyimpan
    if (present > 0 || absent > 0) {
      // Tambahkan record absensi di posisi pertama
      _records.insert(
        0,
        AttendanceRecord(
          date: DateTime.now(), // Tanggal saat ini
          present: present,
          absent: absent,
        ),
      );

      // Reset status kehadiran semua siswa
      for (var student in _students) {
        student.isPresent = false;
      }
      
      notifyListeners(); // Update UI
    }
  }

  // Fungsi untuk mendapatkan detail absensi hari ini
  AttendanceRecord? getTodayAttendance() {
    // Cari record absensi hari ini
    return _records.isNotEmpty ? _records.first : null;
  }

  // Fungsi untuk menghitung persentase kehadiran
  Map<String, double> getAttendancePercentage() {
    // Hitung total siswa
    int totalStudents = _students.length;
    
    // Hitung jumlah siswa hadir
    int presentStudents = _students.where((student) => student.isPresent).length;

    // Hitung persentase
    double presentPercentage = (presentStudents / totalStudents) * 100;
    double absentPercentage = 100 - presentPercentage;

    return {
      'present': presentPercentage,
      'absent': absentPercentage
    };
  }

  // Fungsi untuk membersihkan semua rekaman absensi
  void clearAllRecords() {
    _records.clear(); // Hapus semua rekaman
    notifyListeners(); // Update UI
  }

  // Fungsi untuk mendapatkan total rekaman absensi
  int getTotalRecords() {
    return _records.length;
  }
}
