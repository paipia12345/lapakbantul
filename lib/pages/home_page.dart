import 'package:flutter/material.dart';
import 'home_page2.dart';
import 'home_page5.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Align(
          alignment: Alignment.centerLeft,
          child: Text("Beranda"),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            icon: Image.asset("assets/images/Ellipse 6.png"),
            onPressed: () {},
          )
        ],
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 217,
            margin: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFF003566),
              borderRadius: BorderRadius.circular(16),
            ),

            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Text(
                          "LaPak Bantul",
                          style: TextStyle(
                            fontSize: 28,
                            color: Color(0xFFE9E7E5),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "Pusat Layanan Pajak Terpadu",
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFFE9E7E5),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                Container(
                  width: 80,
                  height: 80,
                  margin: const EdgeInsets.only(right: 20),
                  decoration: BoxDecoration(
                    color: Colors.yellow[500],
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.blue, width: 2),
                  ),
                  child: Image.asset(
                    "assets/images/toko.png",
                    width: 120,
                    height: 120,
                    fit: BoxFit.fill,
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: GridView.count(
              padding: const EdgeInsets.all(20),
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              physics: const AlwaysScrollableScrollPhysics(),
              children: [
  // 🔥 10.png → ke home_page4
  _buildMenuItem(
    const Color.fromARGB(255, 223, 224, 225),
    "assets/images/10.png",
    context,
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const PBBPage()),
      );
    },
  ),

  // 🔥 11.png → ke home_page2
  _buildMenuItem(
    const Color.fromARGB(255, 223, 224, 225),
    "assets/images/11.png",
    context,
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const HomePage2()),
      );
    },
  ),

   _buildMenuItem(
    const Color.fromARGB(255, 223, 224, 225),
    "assets/images/12.png",
    context,
    onPressed: () {
      
      
    },
  ),

   _buildMenuItem(
    const Color.fromARGB(255, 223, 224, 225),
    "assets/images/13.png",
    context,
    onPressed: () {
      
      
    },
  ),

   _buildMenuItem(
    const Color.fromARGB(255, 223, 224, 225),
    "assets/images/14.png",
    context,
    onPressed: () {
      
      
    },
  ),

   _buildMenuItem(
    const Color.fromARGB(255, 223, 224, 225),
    "assets/images/15.png",
    context,
    onPressed: () {
      
      
    },
  ),

],
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildMenuItem(Color color, String imagePath, BuildContext context, {VoidCallback? onPressed}) {
  Widget content = Container(
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(13),
          blurRadius: 10,
          offset: const Offset(0, 5),
        ),
      ],
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.asset(
        imagePath,
        fit: BoxFit.cover,
      ),
    ),
  );

  // Kalau ada onPressed → bungkus jadi TextButton
  if (onPressed != null) {
    return TextButton(
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
      ),
      onPressed: onPressed,
      child: content,
    );
  }

  return content;
}