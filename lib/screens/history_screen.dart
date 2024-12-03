import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/attendance_provider.dart';
import 'package:intl/intl.dart';
import '../widgets/animated_list_item.dart';

class HistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //  Membangun layar riwayat kehadiran dengan desain modern
    return Consumer<AttendanceProvider>(
      builder: (context, provider, child) {
        return Container(
          //Membuat background gradient untuk estetika visual
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
              // Judul layar dengan styling yang menarik
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Riwayat Kehadiran',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo[800],
                  ),
                ),
              ),
              Expanded(
                child: provider.records.isEmpty
                    // Tampilan placeholder saat tidak ada riwayat
                    ? const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.history,
                              size: 64,
                              color: Colors.grey,
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Belum ada riwayat kehadiran',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      )
                    //  Membangun daftar riwayat kehadiran dengan animasi
                    : ListView.builder(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        itemCount: provider.records.length,
                        itemBuilder: (context, index) {
                          final record = provider.records[index];
                          return AnimatedListItem(
                            index: index,
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    //  Menampilkan tanggal dengan ikon kalender
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.calendar_today,
                                          color: Colors.indigo,
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          DateFormat('dd MMMM yyyy')
                                              .format(record.date),
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 12),
                                    // Menampilkan statistik kehadiran dengan desain menarik
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        _buildAttendanceStatus(
                                          'Hadir',
                                          record.present,
                                          Colors.green,
                                          Icons.check_circle,
                                        ),
                                        _buildAttendanceStatus(
                                          'Tidak Hadir',
                                          record.absent,
                                          Colors.red,
                                          Icons.cancel,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        );
      },
    );
  }

  //  Membuat widget status kehadiran dengan desain kustom
  Widget _buildAttendanceStatus(
      String label, int count, Color color, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          // Menampilkan ikon dan label status dengan warna berbeda
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                count.toString(),
                style: TextStyle(
                  color: color,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
