import 'package:flutter/material.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final TextEditingController _searchController = TextEditingController();

  List<String> recentSearches = [
    "Gejala Flu",
    "Pencegahan Diabetes",
    "Obat Batuk Alami",
    "Tips Hidrasi",
  ];

  List<String> recommendations = [
    "Demam",
    "Asma",
    "Diet Sehat",
    "Vitamin",
    "Imunisasi",
    "Kesehatan Mental",
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

                // ================= SEARCH BAR =================
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0C3B28),
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                        color: Colors.greenAccent.withOpacity(0.4)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.search, color: Colors.greenAccent),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          controller: _searchController,
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                            hintText:
                                "Cari info penyakit, obat, atau tips...",
                            hintStyle:
                                TextStyle(color: Colors.white54),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                // ================= PENCARIAN TERAKHIR =================
                const Text(
                  "PENCARIAN TERAKHIR",
                  style: TextStyle(
                    color: Colors.white54,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),

                const SizedBox(height: 15),

                ...recentSearches.map((item) => _buildHistoryItem(item)),

                const SizedBox(height: 15),

                // ================= HAPUS SEMUA =================
                if (recentSearches.isNotEmpty)
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        recentSearches.clear();
                      });
                    },
                    child: const Text(
                      "HAPUS SEMUA RIWAYAT",
                      style: TextStyle(
                        color: Colors.greenAccent,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                  ),

                const SizedBox(height: 30),

                // ================= REKOMENDASI =================
                const Text(
                  "REKOMENDASI PENCARIAN",
                  style: TextStyle(
                    color: Colors.white54,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),

                const SizedBox(height: 20),

                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: recommendations
                      .map(
                        (item) => Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 18, vertical: 10),
                          decoration: BoxDecoration(
                            color: const Color(0xFF0C3B28),
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                                color: Colors.greenAccent.withOpacity(0.3)),
                          ),
                          child: Text(
                            item,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ================= ITEM RIWAYAT =================
  Widget _buildHistoryItem(String title) {
    return Column(
      children: [
        Row(
          children: [
            const Icon(Icons.history,
                color: Colors.white54, size: 20),
            const SizedBox(width: 15),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  recentSearches.remove(title);
                });
              },
              child: const Icon(Icons.close,
                  color: Colors.white54),
            ),
          ],
        ),
        const SizedBox(height: 15),
        Divider(
          color: Colors.white.withOpacity(0.1),
          thickness: 1,
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}