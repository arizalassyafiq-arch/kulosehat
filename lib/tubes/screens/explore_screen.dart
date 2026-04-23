import 'package:flutter/material.dart';
import 'article_detail_screen.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {

  int selectedIndex = 0;

  final List<String> categories = [
    "Terbaru",
    "Populer",
    "Nutrisi",
    "Kesehatan"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF062E1E),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                const SizedBox(height: 20),

                // ================= TITLE =================
                const Text(
                  "Jelajahi",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 20),

                // ================= SEARCH =================
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0C3B28),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const TextField(
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      icon: Icon(Icons.search, color: Colors.white54),
                      hintText: "Cari artikel kesehatan...",
                      hintStyle: TextStyle(color: Colors.white54),
                      border: InputBorder.none,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // ================= CATEGORY TAB =================
                SizedBox(
                  height: 45,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      bool isSelected = selectedIndex == index;

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedIndex = index;
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.only(right: 12),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? Colors.greenAccent
                                : const Color(0xFF0C3B28),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Text(
                            categories[index],
                            style: TextStyle(
                              color: isSelected
                                  ? Colors.black
                                  : Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 25),

                // ================= ARTICLE LIST =================
                _articleCard(
                  label: "DEWASA",
                  labelColor: Colors.greenAccent,
                  image:
                      "assets/images/articles/article_flu.jpg",
                  title: "10 Cara Mencegah Flu di Musim Hujan",
                  desc:
                      "Pelajari langkah-langkah praktis untuk menjaga daya tahan tubuh agar tetap bugar saat cuaca tidak menentu.",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const ArticleDetailScreen(
                          title: "10 Cara Mencegah Flu di Musim Hujan",
                          imageUrl:
                              "assets/images/articles/article_flu.jpg",
                          category: "DEWASA",
                          readTime: "5 Menit Membaca",
                        ),
                      ),
                    );
                  },
                ),

                _articleCard(
                  label: "BAYI",
                  labelColor: Colors.blueAccent,
                  image:
                      "assets/images/articles/article_baby.png",
                  title: "Panduan Gizi MPASI untuk Bayi 6 Bulan",
                  desc:
                      "Memulai MPASI pertama dengan bahan alami yang kaya nutrisi esensial untuk tumbuh kembang bayi.",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const ArticleDetailScreen(
                          title: "Panduan Gizi MPASI untuk Bayi 6 Bulan",
                          imageUrl:
                              "assets/images/articles/article_baby.png",
                          category: "BAYI",
                          readTime: "4 Menit Membaca",
                        ),
                      ),
                    );
                  },
                ),

                _articleCard(
                  label: "DEWASA",
                  labelColor: Colors.greenAccent,
                  image:
                      "assets/images/articles/article_stress.jpg",
                  title: "Mengelola Stress di Lingkungan Kerja",
                  desc:
                      "Teknik relaksasi sederhana dan manajemen waktu untuk menjaga kesehatan mental di tengah tekanan kerja.",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const ArticleDetailScreen(
                          title: "Mengelola Stress di Lingkungan Kerja",
                          imageUrl:
                              "assets/images/articles/article_stress.jpg",
                          category: "DEWASA",
                          readTime: "6 Menit Membaca",
                        ),
                      ),
                    );
                  },
                ),

                _articleCard(
                  label: "LANSIA",
                  labelColor: Colors.orangeAccent,
                  image:
                      "assets/images/articles/article_heart.jpg",
                  title: "Olahraga Aman untuk Kesehatan Jantung",
                  desc:
                      "Pilihan aktivitas fisik yang rendah risiko namun efektif untuk memperkuat otot jantung di usia lanjut.",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const ArticleDetailScreen(
                          title: "Olahraga Aman untuk Kesehatan Jantung",
                          imageUrl:
                              "assets/images/articles/article_heart.jpg",
                          category: "LANSIA",
                          readTime: "5 Menit Membaca",
                        ),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ================= ARTICLE CARD =================
  Widget _articleCard({
    required String label,
    required Color labelColor,
    required String image,
    required String title,
    required String desc,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              SizedBox(
                height: 180,
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    image,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: const Color(0xFF0C3B28),
                        child: const Center(
                          child: Icon(
                            Icons.broken_image,
                            color: Colors.white54,
                            size: 40,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Positioned(
                top: 12,
                left: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 5),
                  decoration: BoxDecoration(
                    color: labelColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    label,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            desc,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
