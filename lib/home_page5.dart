import 'package:flutter/material.dart';

class PBBPage extends StatefulWidget {
  const PBBPage({super.key});

  @override
  State<PBBPage> createState() => _PBBPageState();
}

class _PBBPageState extends State<PBBPage> {
  TextEditingController nopController = TextEditingController();
  bool showData = false;
  
// ...existing code...
  void cekNOP() {
    final input = nopController.text.trim();
    if (input == '764177342178410') {
      setState(() {
        showData = true;
      });
    } else {
      setState(() {
        showData = false;
      });
      // optional: notify user that the NOP is invalid
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('NOP tidak dikenali')),
      );
    }
  }
// ...existing code...

  Widget cardSPPT({
    required String tahun,
    required String alamat,
    required String harga,
    required String status,
    required Color warnaStatus,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.grey.shade300, blurRadius: 6)
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// STATUS
          Align(
            alignment: Alignment.topRight,
            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: warnaStatus,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                status,
                style: const TextStyle(
                    color: Colors.white, fontSize: 12),
              ),
            ),
          ),

          const SizedBox(height: 4),

          /// TAHUN
          Text(
            "SPPT $tahun",
            style: const TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 8),

          Row(
            children: [
              const Icon(Icons.location_on_outlined,
                  size: 18, color: Colors.grey),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  alamat,
                  style: const TextStyle(color: Colors.grey),
                ),
              ),
            ],
          ),

          const SizedBox(height: 6),

          Row(
            children: [
              const Icon(Icons.monetization_on_outlined,
                  size: 18, color: Colors.grey),
              const SizedBox(width: 6),
              const Text("NJOP Bumi dan Bangunan"),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xff0B4A7D),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  harga,
                  style: const TextStyle(
                      color: Colors.white, fontSize: 12),
                ),
              )
            ],
          ),

          const SizedBox(height: 10),

          const Center(
            child: Text(
              "Lihat Detail >",
              style: TextStyle(color: Colors.grey),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],

      /// APPBAR
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: const Icon(Icons.arrow_back, color: Colors.black),
        title: const Text(
          "PBB",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),

      /// BODY
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            /// SEARCH NOP
            TextField(
              controller: nopController,
              onSubmitted: (value) => cekNOP(),
              decoration: InputDecoration(
                hintText: "Masukan NOP...",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(
                      color: Color(0xff0B4A7D), width: 2),
                ),
              ),
            ),

            const SizedBox(height: 20),

            /// DATA MUNCUL
            if (showData)
              Expanded(
                child: ListView(
                  children: [

                    /// CARD 1
                    cardSPPT(
                      tahun: "2021",
                      alamat:
                          "DS. Ngireng-ireng RT01/RW01",
                      harga: "200.000",
                      status: "Belum lunas",
                      warnaStatus: Colors.red,
                    ),

                    /// CARD 2
                    cardSPPT(
                      tahun: "2020",
                      alamat:
                          "DS. Ngireng-ireng RT01/RW01",
                      harga: "376.000",
                      status: "Lunas",
                      warnaStatus: Colors.green,
                    ),
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }
}