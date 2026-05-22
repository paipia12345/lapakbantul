import 'package:flutter/material.dart';

class HomePage2 extends StatelessWidget {
  const HomePage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F8),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ================= HEADER BIRU =================
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 48, 20, 90),
              color: const Color(0xFF0A3560),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'LaPak Bantul',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Pusat layanan pajak terpadu',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: 50,
                    height: 50,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.yellow,
                    ),
                    child: ClipOval(
                      child: Padding(
                        padding: const EdgeInsets.all(1),
                        child: Image.asset(
                          "assets/images/Rectangle 4.png",
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ================= BODY PUTIH =================
            Container(
              width: double.infinity,
              transform: Matrix4.translationValues(0, -60, 0),
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 32),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(32),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ===== GRID BPHTB =====
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 4,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 14,
                      mainAxisSpacing: 14,
                      childAspectRatio: 1.25,
                    ),
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFEFF4FB),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                        Image.asset(
                          "assets/images/Card.png",
                          fit: BoxFit.contain,
                        ),
                        
                      ],
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 18),

                  // ===== LAYANAN KELILING =====
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0A3560),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Row(
                  children: [
                    Image.asset(
                      "assets/images/Vector.png",
                      width: 26,
                      height: 26,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Layanan keliling",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            "Lihat jadwal layanan keliling",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.chevron_right,
                        color: Colors.white, size: 24),
                  ],
                ),
                  ),

                  const SizedBox(height: 22),

                  // ===== INFORMASI PAJAK =====
                  const Text(
                    'Informasi pajak',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    height: 170,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE0E0E0),
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}