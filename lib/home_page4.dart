import 'package:flutter/material.dart';

class PbbPage extends StatelessWidget {
  const PbbPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          'PBB',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // SEARCH FIELD
            TextField(
              decoration: InputDecoration(
                hintText: 'Masukan NOP...',
                prefixIcon: const Icon(Icons.search),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 14),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide:
                      BorderSide(color: Colors.grey.shade400),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide:
                      const BorderSide(color: Color(0xFF0B4A7D)),
                ),
              ),
            ),

            const SizedBox(height: 80),

            // ICON TENGAH (PERSIS KAYAK FIGMA)
            SizedBox(
              width: 100,
              height: 100,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Kotak biru
                  Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      color: const Color(0xFF0B4A7D),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),

                  // Icon dokumen
                  const Icon(
                    Icons.description_rounded,
                    color: Colors.white,
                    size: 44,
                  ),

                  // Icon search nempel kiri bawah (TANPA LINGKARAN)
                  const Positioned(
                    left: 18,
                    bottom: 18,
                    child: Icon(
                      Icons.search,
                      color: Colors.white,
                      size: 26,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // TEXT BAWAH
            const Text(
              'Masukan NOP untuk melihat\nrincian pajak.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}