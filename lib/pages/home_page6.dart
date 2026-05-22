import 'package:flutter/material.dart';

class DetailSPPT extends StatelessWidget {
  const DetailSPPT({super.key});

  Widget item(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 14,
          ),
        ),
        SizedBox(height: 5),
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 15),
        Divider(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("detail-sppt"),
        backgroundColor: Colors.white,
        elevation: 1,
        leading: Icon(Icons.arrow_back, color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Text(
                "No. NOP 378429749820294337",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),

              SizedBox(height: 10),

              Text(
                "AHMAD NABIL BAHROIN\nROGER SUMATRA",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 10),

              Text(
                "Alamat Lengkap WP : Kab Bantul, Kec. Sewon, DS.\nNgireng-ireng, RT01/RW01",
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),

              SizedBox(height: 20),

              item("Lokasi", "DS. Ngireng-ireng, RT01/RW01"),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Status",
                    style: TextStyle(color: Colors.grey),
                  ),
                  SizedBox(height: 8),

                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      "Sudah Lunas",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),

                  SizedBox(height: 15),
                  Divider(),
                ],
              ),

              item("Denda", "Rp. 0"),
              item("NJOP Bumi", "Rp. 300,000"),
              item("NJOP Bangunan", "Rp. 0"),
              item("Luas Bumi", "227m"),
              item("Luas Bangunan", "0"),
              item("Tahun", "2020"),

            ],
          ),
        ),
      ),
    );
  }
}