import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/attendance_provider.dart';
import 'screens/home_screen.dart';
import 'screens/history_screen.dart';
import 'theme/app_theme.dart';

// Fungsi utama untuk menjalankan aplikasi
void main() {
  // Memulai aplikasi Flutter
  runApp(MyApp());
}

// Kelas utama aplikasi - StatelessWidget
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Menggunakan ChangeNotifierProvider untuk manajemen state
    return ChangeNotifierProvider(
      // Membuat instance AttendanceProvider
      create: (_) => AttendanceProvider(),
      // Konfigurasi MaterialApp
      child: MaterialApp(
        // Judul aplikasi
        title: 'Student Attendance App',
        // Tema aplikasi dari AppTheme
        theme: AppTheme.theme,
        // Layar utama aplikasi
        home: MainScreen(),
      ),
    );
  }
}

// Layar Utama dengan navigasi bottom bar - StatefulWidget
class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => MainScreenState();
}

// State untuk MainScreen
class MainScreenState extends State<MainScreen> {
  // Index halaman yang aktif
  int _selectedIndex = 0;

  // Daftar layar yang dapat dipilih
  final List<Widget> _screens = [
    // Layar Pencatatan Absensi
    HomeScreen(),
    // Layar Riwayat Absensi
    HistoryScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // App Bar dinamis
      appBar: AppBar(
        // Judul berubah sesuai halaman
        title: Text(_selectedIndex == 0 ? 'Presensi Siswa' : 'Riwayat Kehadiran'),
        // Aksi tambahan di App Bar
        actions: [
          // Tombol toggle tema
          IconButton(
            icon: const Icon(Icons.lightbulb_outline),
            onPressed: () {
              // TODO: Implementasi toggle tema
              _toggleTheme();
            },
          ),
        ],
      ),

      // Body yang berganti sesuai navigasi
      body: _screens[_selectedIndex],

      // Bottom Navigation Bar dengan desain kustom
      bottomNavigationBar: Container(
        // Dekorasi bayangan untuk efek elevasi
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        // Membuat sudut melengkung pada navigation bar
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          child: BottomNavigationBar(
            // Index halaman aktif
            currentIndex: _selectedIndex,
            
            // Fungsi ketika item di-tap
            onTap: (index) {
              // Update state untuk mengganti halaman
              setState(() {
                _selectedIndex = index;
              });
            },
            
            // Item navigasi
            items: const [
              // Item Pencatatan Absensi
              BottomNavigationBarItem(
                icon: Icon(Icons.edit_note),
                label: 'Pencatatan',
              ),
              // Item Riwayat Absensi
              BottomNavigationBarItem(
                icon: Icon(Icons.history),
                label: 'Riwayat',
              ),
            ],
            
            // Konfigurasi warna dan gaya
            selectedItemColor: Colors.indigo,
            unselectedItemColor: Colors.grey,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            elevation: 0,
          ),
        ),
      ),
    );
  }

  // Metode untuk toggle tema (contoh implementasi)
  void _toggleTheme() {
    // TODO: Implementasi logic toggle tema
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Ganti Tema'),
        content: const Text('Fitur pergantian tema akan segera hadir!'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Tutup'),
          )
        ],
      ),
    );
  }
}

// Tambahan: Contoh implementasi AppTheme
class AppTheme {
  // Tema default aplikasi
  static ThemeData theme = ThemeData(
    // Pengaturan warna utama
    primarySwatch: Colors.indigo,
    // Gaya AppBar
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: Colors.indigo,
      foregroundColor: Colors.white,
    ),
    // Gaya Text
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    ),
    // Efek splash dan highlight
    splashColor: Colors.indigo.withOpacity(0.5),
  );
}
