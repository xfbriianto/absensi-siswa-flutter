import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/attendance_provider.dart';
import '../widgets/animated_list_item.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //  Membangun layar utama dengan manajemen state provider
    return Consumer<AttendanceProvider>(
      builder: (context, provider, child) {
        return Container(
          // Desain background gradient untuk estetika visual
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.indigo.withOpacity(0.1),
                Colors.purple.withOpacity(0.05),
              ],
            ),
          ),
          child: Column(
            children: [
              //  Header layar dengan judul yang eye-catching
              _buildScreenHeader(),
              
              //  Daftar siswa dengan interaksi dinamis
              _buildStudentList(provider),
              
              //  Tombol simpan kehadiran dengan validasi
              _buildSaveAttendanceButton(context, provider),
            ],
          ),
        );
      },
    );
  }

  //  Membuat header layar dengan desain modern
  Widget _buildScreenHeader() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        'Daftar Kehadiran',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.indigo[800],
        ),
      ),
    );
  }

  //  Membangun daftar siswa dengan animasi dan interaksi
  Widget _buildStudentList(AttendanceProvider provider) {
    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: provider.students.length,
        itemBuilder: (context, index) {
          final student = provider.students[index];
          return AnimatedListItem(
            index: index,
            child: _buildStudentCard(student, index, provider),
          );
        },
      ),
    );
  }

  //  Membuat kartu siswa dengan status kehadiran
  Widget _buildStudentCard(student, int index, AttendanceProvider provider) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        //  Toggle kehadiran dengan sentuhan atau switch
        onTap: () => provider.toggleAttendance(index),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              //  Indikator visual status kehadiran
              _buildAttendanceIndicator(student),
              const SizedBox(width: 16),
              _buildStudentInfo(student),
              _buildAttendanceSwitch(student, index, provider),
            ],
          ),
        ),
      ),
    );
  }

  //  Membuat indikator visual status kehadiran
  Widget _buildAttendanceIndicator(student) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: student.isPresent
            ? Colors.green.withOpacity(0.2)
            : Colors.red.withOpacity(0.2),
        shape: BoxShape.circle,
      ),
      child: Icon(
        student.isPresent ? Icons.check_circle : Icons.person_outline,
        color: student.isPresent ? Colors.green : Colors.red,
        size: 28,
      ),
    );
  }

  // Fungsi: Membuat informasi detail siswa
  Widget _buildStudentInfo(student) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            student.name,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            student.isPresent ? 'Hadir' : 'Tidak Hadir',
            style: TextStyle(
              color: student.isPresent ? Colors.green : Colors.red,
            ),
          ),
        ],
      ),
    );
  }

  // Fungsi: Membuat switch untuk toggle kehadiran
  Widget _buildAttendanceSwitch(student, int index, AttendanceProvider provider) {
    return Switch(
      value: student.isPresent,
      onChanged: (_) => provider.toggleAttendance(index),
      activeColor: Colors.green,
    );
  }

  // Fungsi: Membuat tombol simpan kehadiran dengan validasi
  Widget _buildSaveAttendanceButton(BuildContext context, AttendanceProvider provider) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: ElevatedButton(
        // Command: Disable tombol jika tidak ada siswa
        onPressed: provider.students.isEmpty ? null : () => _saveAttendance(context, provider),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.save),
            SizedBox(width: 8),
            Text('Simpan Kehadiran'),
          ],
        ),
      ),
    );
  }

  // Fungsi: Logika penyimpanan kehadiran dengan notifikasi
  void _saveAttendance(BuildContext context, AttendanceProvider provider) {
    provider.saveAttendance();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          children: [
            Icon(Icons.check_circle, color: Colors.white),
            SizedBox(width: 8),
            Text('Kehadiran berhasil disimpan!'),
          ],
        ),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
