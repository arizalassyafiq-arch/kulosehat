import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() =>
      _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController =
      TextEditingController();
  final TextEditingController passwordController =
      TextEditingController();

  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF0B3D2E),
              Color(0xFF051F17),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: auth.isLoading
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Colors.greenAccent,
                  ),
                )
              : ListView(
                  padding: const EdgeInsets.all(24),
                  children: [

                    const SizedBox(height: 40),

                    /// ===== ICON =====
                    Center(
                      child: Container(
                        padding:
                            const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.greenAccent
                              .withOpacity(0.15),
                          borderRadius:
                              BorderRadius.circular(
                                  20),
                        ),
                        child: const Icon(
                          Icons.health_and_safety,
                          size: 50,
                          color: Colors.greenAccent,
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    /// ===== TITLE =====
                    const Center(
                      child: Text(
                        "KuloSehat",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight:
                              FontWeight.bold,
                          color: Colors.greenAccent,
                        ),
                      ),
                    ),

                    const SizedBox(height: 8),

                    const Center(
                      child: Text(
                        "Selamat Datang Kembali",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight:
                              FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),

                    const SizedBox(height: 6),

                    const Center(
                      child: Text(
                        "Silakan masuk untuk akses info kesehatan terpercaya",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white70,
                        ),
                      ),
                    ),

                    const SizedBox(height: 40),

                    /// ===== EMAIL =====
                    const Text(
                      "EMAIL ATAU NOMOR HP",
                      style: TextStyle(
                        color: Colors.white54,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 8),
                    buildTextField(
                      controller: emailController,
                      hint: "nama@email.com",
                      icon: Icons.email,
                    ),

                    const SizedBox(height: 20),

                    /// ===== PASSWORD =====
                    const Text(
                      "KATA SANDI",
                      style: TextStyle(
                        color: Colors.white54,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 8),
                    buildTextField(
                      controller: passwordController,
                      hint: "********",
                      icon: Icons.lock,
                      obscure: obscurePassword,
                      suffix: IconButton(
                        icon: Icon(
                          obscurePassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.white54,
                        ),
                        onPressed: () {
                          setState(() {
                            obscurePassword =
                                !obscurePassword;
                          });
                        },
                      ),
                    ),

                    const SizedBox(height: 10),

                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Lupa Kata Sandi?",
                          style: TextStyle(
                            color:
                                Colors.greenAccent,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    /// ===== LOGIN BUTTON =====
                    ElevatedButton(
                      style: ElevatedButton
                          .styleFrom(
                        backgroundColor:
                            Colors.greenAccent,
                        padding:
                            const EdgeInsets
                                .symmetric(
                                    vertical:
                                        16),
                        shape:
                            RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius
                                  .circular(
                                      16),
                        ),
                      ),
                      onPressed: () async {
                        final authProvider =
                            context.read<AuthProvider>();
                        final ok = await authProvider
                            .loginWithEmail(
                          emailController.text,
                          passwordController.text,
                        );

                        if (!ok && mounted) {
                          final msg = authProvider
                                  .errorMessage ??
                              "Login gagal.";
                          ScaffoldMessenger.of(context)
                              .showSnackBar(
                            SnackBar(content: Text(msg)),
                          );
                        }
                      },
                      child: const Text(
                        "Masuk",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    /// ===== OR =====
                    const Center(
                      child: Text(
                        "ATAU MASUK DENGAN",
                        style: TextStyle(
                          color: Colors.white54,
                          fontSize: 12,
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    Row(
                      children: [
                        Expanded(
                          child: socialButton(
                            "Google",
                            Icons.g_mobiledata,
                            () {
                              ScaffoldMessenger.of(
                                      context)
                                  .showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      "Login Google belum tersedia."),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: socialButton(
                            "Apple",
                            Icons.apple,
                            () {},
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 30),

                    Center(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) =>
                                  const RegisterScreen(),
                            ),
                          );
                        },
                        child: const Text.rich(
                          TextSpan(
                            text: "Belum punya akun? ",
                            style: TextStyle(
                                color: Colors.white70),
                            children: [
                              TextSpan(
                                text: "Daftar sekarang",
                                style: TextStyle(
                                  color:
                                      Colors.greenAccent,
                                  fontWeight:
                                      FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  Widget buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool obscure = false,
    Widget? suffix,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(14),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        style: const TextStyle(
            color: Colors.white),
        decoration: InputDecoration(
          prefixIcon:
              Icon(icon, color: Colors.white54),
          suffixIcon: suffix,
          hintText: hint,
          hintStyle:
              const TextStyle(color: Colors.white38),
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(
                  vertical: 16),
        ),
      ),
    );
  }

  Widget socialButton(
      String text, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding:
            const EdgeInsets.symmetric(
                vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white10,
          borderRadius:
              BorderRadius.circular(14),
        ),
        child: Row(
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: [
            Icon(icon,
                color: Colors.white),
            const SizedBox(width: 8),
            Text(
              text,
              style: const TextStyle(
                  color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
