import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'login_screen.dart';
import '../providers/auth_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AuthProvider? auth;
    try {
      auth = context.read<AuthProvider>();
    } catch (_) {
      auth = null;
    }

    return Scaffold(
      backgroundColor: const Color(0xFF062E1E),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [

              // ================= HEADER =================
              const SizedBox(height: 20),
              const Text(
                "Profil Pengguna",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 25),

              // ================= FOTO PROFIL =================
              Stack(
                children: [
                  CircleAvatar(
                    radius: 65,
                    backgroundColor: Colors.green,
                    child: const CircleAvatar(
                      radius: 60,
                      backgroundImage: NetworkImage(
                        "https://i.pravatar.cc/300",
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.greenAccent,
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(8),
                      child: const Icon(
                        Icons.edit,
                        color: Colors.black,
                        size: 18,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // ================= NAMA & EMAIL =================
              const Text(
                "Budi Santoso",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                "budisantoso@email.com",
                style: TextStyle(
                  color: Colors.greenAccent,
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 20),

              // ================= BUTTON EDIT =================
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  side: const BorderSide(color: Colors.greenAccent),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {},
                child: const Text(
                  "Edit Profil",
                  style: TextStyle(color: Colors.greenAccent),
                ),
              ),

              const SizedBox(height: 30),

              // ================= CARD INFO =================
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _infoCard(Icons.monitor_weight, "BERAT\nBADAN", "70 kg"),
                    _infoCard(Icons.height, "TINGGI\nBADAN", "175 cm"),
                    _infoCard(Icons.medical_services, "KONSULTASI", "12"),
                  ],
                ),
              ),

              const SizedBox(height: 35),

              // ================= SECTION TITLE =================
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "PENGATURAN & INFORMASI",
                    style: TextStyle(
                      color: Colors.white54,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 15),

              // ================= MENU LIST =================
              _menuItem(Icons.person, "Informasi Pribadi",
                  "Detail akun dan data kesehatan"),
              _menuItem(Icons.history, "Riwayat Konsultasi",
                  "Daftar chat dokter sebelumnya"),
              _menuItem(Icons.bookmark, "Artikel Tersimpan",
                  "Artikel yang telah disimpan"),
              _menuItem(
                Icons.logout,
                "Logout Akun",
                "Keluar dari akun Anda",
                onTap: () {
                  auth?.logout();
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (_) => const LoginScreen(),
                    ),
                    (route) => false,
                  );
                },
                iconBgColor: Colors.redAccent,
              ),

              const SizedBox(height: 20),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  // ================= INFO CARD WIDGET =================
  Widget _infoCard(IconData icon, String title, String value) {
    return Container(
      width: 105,
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: const Color(0xFF0C3B28),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.greenAccent.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.greenAccent),
          const SizedBox(height: 10),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // ================= MENU ITEM WIDGET =================
  Widget _menuItem(
    IconData icon,
    String title,
    String subtitle, {
    VoidCallback? onTap,
    Color iconBgColor = Colors.green,
    Color iconColor = Colors.white,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF0C3B28),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: iconBgColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: iconColor, size: 20),
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
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: Colors.white60,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios,
                  color: Colors.white38, size: 16)
            ],
          ),
        ),
      ),
    );
  }
}
