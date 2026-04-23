import 'package:flutter/material.dart';

class ArticleDetailScreen extends StatelessWidget {
  const ArticleDetailScreen({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.category,
    required this.readTime,
  });

  final String title;
  final String imageUrl;
  final String category;
  final String readTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF062E1E),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.greenAccent,
        onPressed: () {},
        child: const Icon(Icons.chat_bubble, color: Colors.black),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _headerImage(),
                _content(),
              ],
            ),
          ),
          Positioned(
            top: 44,
            left: 16,
            child: _circleIcon(
              icon: Icons.arrow_back,
              onTap: () => Navigator.pop(context),
            ),
          ),
          Positioned(
            top: 44,
            right: 16,
            child: _circleIcon(
              icon: Icons.share,
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _headerImage() {
    return Stack(
      children: [
        Container(
          height: 320,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: _resolveImage(imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          height: 320,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.transparent,
                Color(0xFF062E1E),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ],
    );
  }

  ImageProvider _resolveImage(String path) {
    if (path.startsWith('http')) {
      return NetworkImage(path);
    }
    return AssetImage(path);
  }

  Widget _content() {
    return Transform.translate(
      offset: const Offset(0, -24),
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 24, 20, 40),
        decoration: const BoxDecoration(
          color: Color(0xFF061E1A),
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.greenAccent,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    category,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  readTime,
                  style: const TextStyle(
                    color: Colors.white60,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                const CircleAvatar(
                  radius: 16,
                  backgroundImage: NetworkImage(
                    "https://images.unsplash.com/photo-1500648767791-00dcc994a43e",
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "dr. Andi Setiawan",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      "Spesialis Penyakit Dalam • 24 Okt 2023",
                      style: TextStyle(
                        color: Colors.white54,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 22),
            const Text(
              "Musim hujan seringkali membawa risiko penyakit yang lebih tinggi, terutama flu dan infeksi saluran pernapasan. Udara yang lembab dan perubahan suhu yang drastis dapat melemahkan sistem imun tubuh jika kita tidak waspada.",
              style: TextStyle(
                color: Colors.white70,
                fontSize: 14,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Mengapa Kita Mudah Terserang Flu?",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Virus influenza lebih mudah menyebar di lingkungan yang lembab dan dingin. Selain itu, kurangnya paparan sinar matahari selama musim hujan dapat menurunkan kadar vitamin D dalam tubuh.",
              style: TextStyle(
                color: Colors.white70,
                fontSize: 14,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Langkah Praktis Pencegahan",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 10),
            _bullet(
              "Cuci Tangan Teratur: Gunakan sabun dan air mengalir minimal 20 detik setelah beraktivitas.",
            ),
            _bullet(
              "Nutrisi Mikro: Pastikan asupan Vitamin C dan D dari buah-buahan segar atau suplemen pendukung.",
            ),
            _bullet(
              "Istirahat Berkualitas: Tidur 7-8 jam sangat penting untuk regenerasi sel imun tubuh.",
            ),
            _bullet(
              "Gunakan Masker: Proteksi tambahan di ruang publik untuk meminimalkan paparan droplet.",
            ),
          ],
        ),
      ),
    );
  }

  Widget _bullet(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle,
              color: Colors.greenAccent, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 14,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _circleIcon({required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.35),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: Colors.white24),
        ),
        child: Icon(icon, color: Colors.white, size: 18),
      ),
    );
  }
}
