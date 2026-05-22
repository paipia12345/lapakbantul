import 'package:flutter/material.dart';

class LayananKelilingPage extends StatelessWidget {
  const LayananKelilingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: const Icon(Icons.arrow_back, color: Colors.black),
        title: const Text(
          'Layanan Keliling',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),

            // === DATE SELECTOR ===
            SizedBox(
              height: 44,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _dateChip(
                    text: '21/01/2024',
                    selected: true,
                  ),
                  _dateChip(text: '25/01/2024'),
                  _dateChip(text: '28/01/2024'),
                ],
              ),
            ),

            const SizedBox(height: 16),

            const Text(
              'Hari ini, 21 Januari 2024',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),

            const SizedBox(height: 16),

            // === CARD MOBIL 01 ===
            _mobilCard(
              title: 'Mobil 01',
              time: '08:00 - 16:00',
              location: 'Mangir lor & Manager tengah, sendang',
            ),

            const SizedBox(height: 12),

            // === CARD MOBIL 02 ===
            _mobilCard(
              title: 'Mobil 02',
              time: '08:00 - 16:00',
              location: 'Mangir lor & Manager tengah, sendang',
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // ===== DATE CHIP =====
  Widget _dateChip({required String text, bool selected = false}) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: selected ? const Color(0xFF0B4A7D) : const Color(0xFFF1F4F8),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(
            Icons.calendar_today,
            size: 16,
            color: selected ? Colors.white : Colors.grey,
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
              color: selected ? Colors.white : Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  // ===== MOBIL CARD =====
  Widget _mobilCard({
    required String title,
    required String time,
    required String location,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFF0B4A7D),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  time,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Icon(
                Icons.location_on_outlined,
                size: 18,
                color: Colors.grey,
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  location,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}