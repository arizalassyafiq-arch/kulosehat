import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'providers/auth_provider.dart';
import 'screens/explore_screen.dart';
import 'screens/history_screen.dart';
import 'screens/profile_screen.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AuthProvider(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _HomePageScaffold();
  }
}

class _HomePageScaffold extends StatefulWidget {
  const _HomePageScaffold();

  @override
  State<_HomePageScaffold> createState() => _HomePageScaffoldState();
}

class _HomePageScaffoldState extends State<_HomePageScaffold> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    _DashboardBody(),
    HistoryScreen(),
    ExploreScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D5C46),
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),

      /// ======================
      /// BOTTOM NAVIGATION
      /// ======================
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF0D5C46),
        selectedItemColor: Colors.greenAccent,
        unselectedItemColor: Colors.white54,
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Beranda",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: "Pencarian",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: "Jelajah",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profil",
          ),
        ],
      ),
    );
  }
}

class _DashboardBody extends StatelessWidget {
  const _DashboardBody();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),

              /// ======================
              /// KATEGORI USIA
              /// ======================
              const Text(
                "KATEGORI USIA",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                  letterSpacing: 1,
                ),
              ),

              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ageItem(Icons.child_care, "Bayi", false),
                  ageItem(Icons.directions_run, "Remaja", false),
                  ageItem(Icons.person, "Dewasa", false),
                  ageItem(Icons.elderly, "Lansia", true),
                ],
              ),

              const SizedBox(height: 40),

              /// ======================
              /// PILIH PENYAKIT
              /// ======================
              const Text(
                "PILIH PENYAKIT",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                  letterSpacing: 1,
                ),
              ),

              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  diseaseItem(Icons.air, "Flu"),
                  diseaseItem(Icons.thermostat, "Demam"),
                  diseaseItem(Icons.sick, "Batuk"),
                  diseaseItem(Icons.water_drop, "Diabetes"),
                ],
              ),

              const SizedBox(height: 40),

              /// ======================
              /// CARD MENU
              /// ======================
              menuCard(
                Icons.shield,
                const Color(0xFF3C6FD1),
                "Pencegahan",
                "Tips hidup sehat & jadwal vaksinasi harian.",
              ),

              const SizedBox(height: 20),

              menuCard(
                Icons.medical_services,
                const Color(0xFF3FB98F),
                "Pengobatan",
                "Panduan pertolongan pertama & dosis obat.",
              ),

              const SizedBox(height: 20),

              menuCard(
                Icons.coronavirus,
                const Color(0xFFE09F3E),
                "Gejala Awal",
                "Deteksi dini tanda-tanda penyakit umum.",
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  /// ======================
  /// WIDGET KATEGORI USIA
  /// ======================
  Widget ageItem(IconData icon, String title, bool selected) {
    return Column(
      children: [
        Container(
          width: 65,
          height: 65,
          decoration: BoxDecoration(
            color: selected ? Colors.greenAccent : const Color(0xFF124E3B),
            borderRadius: BorderRadius.circular(18),
          ),
          child: Icon(
            icon,
            color: selected ? Colors.black : Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: const TextStyle(color: Colors.white70),
        )
      ],
    );
  }

  /// ======================
  /// WIDGET PENYAKIT
  /// ======================
  Widget diseaseItem(IconData icon, String title) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: const Color(0xFF124E3B),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Colors.white),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: const TextStyle(color: Colors.white70),
        )
      ],
    );
  }

  /// ======================
  /// WIDGET MENU CARD
  /// ======================
  Widget menuCard(
      IconData icon, Color iconColor, String title, String subtitle) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1F2E4A),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            width: 55,
            height: 55,
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(icon, color: iconColor),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward_ios,
              color: Colors.white54, size: 16),
        ],
      ),
    );
  }
}
