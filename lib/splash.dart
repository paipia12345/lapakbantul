import 'package:flutter/material.dart';
import 'dart:math' as math;

// Ganti path ini sesuai struktur proyek Anda
import 'halamanlogin.dart';

/// =====================================================
/// SPLASH SCREEN - LaPak Bantul
/// Pusat Layanan Pajak Terpadu Kabupaten Bantul
/// =====================================================

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  final PageController _controller = PageController();
  int _currentPage = 0;

  late AnimationController _bgAnimController;
  late AnimationController _contentAnimController;
  late Animation<double> _bgAnim;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;

  static const _pages = [
    _SplashData(
      title: 'Selamat Datang di\nLaPak Bantul',
      description:
          'Pusat Layanan Pajak Terpadu Kabupaten Bantul yang mudah, cepat, dan transparan.',
      icon: Icons.account_balance_rounded,
      gradientStart: Color(0xFF002244),
      gradientEnd: Color(0xFF004080),
      accentColor: Color(0xFF4FC3F7),
    ),
    _SplashData(
      title: 'Kelola Semua\nPajak Anda',
      description:
          'Bayar dan pantau PBB, Pajak Kendaraan, dan Pajak Usaha Anda dalam satu aplikasi.',
      icon: Icons.receipt_long_rounded,
      gradientStart: Color(0xFF003060),
      gradientEnd: Color(0xFF005A9E),
      accentColor: Color(0xFF81D4FA),
    ),
    _SplashData(
      title: 'Layanan Keliling\nHadir untuk Anda',
      description:
          'Kami hadir di dekat Anda melalui layanan pajak keliling. Cek jadwal dan lokasi terkini.',
      icon: Icons.directions_bus_filled_rounded,
      gradientStart: Color(0xFF004080),
      gradientEnd: Color(0xFF0077CC),
      accentColor: Color(0xFFB3E5FC),
    ),
  ];

  @override
  void initState() {
    super.initState();

    _bgAnimController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat(reverse: true);

    _bgAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _bgAnimController, curve: Curves.easeInOut),
    );

    _contentAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _fadeAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _contentAnimController,
        curve: const Interval(0.0, 0.7, curve: Curves.easeOut),
      ),
    );

    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _contentAnimController,
        curve: const Interval(0.0, 0.8, curve: Curves.easeOut),
      ),
    );

    _contentAnimController.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _bgAnimController.dispose();
    _contentAnimController.dispose();
    super.dispose();
  }

  void _onPageChanged(int i) {
    setState(() => _currentPage = i);
    _contentAnimController.reset();
    _contentAnimController.forward();
  }

  void _goToNext() {
    if (_currentPage < _pages.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      _navigateToLogin();
    }
  }

  void _skip() => _navigateToLogin();

  void _navigateToLogin() {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 500),
        pageBuilder: (_, animation, __) => FadeTransition(
          opacity: animation,
          // Ganti dengan LoginPage() Anda:
          child: const LoginPage(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final page = _pages[_currentPage];
    final isLast = _currentPage == _pages.length - 1;

    return Scaffold(
      body: AnimatedBuilder(
        animation: _bgAnim,
        builder: (context, _) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.lerp(page.gradientStart,
                      page.gradientEnd, _bgAnim.value * 0.4)!,
                  page.gradientEnd,
                  Color.lerp(page.gradientEnd,
                      page.gradientStart, _bgAnim.value * 0.3)!,
                ],
                stops: const [0.0, 0.55, 1.0],
              ),
            ),
            child: Stack(
              children: [
                // ── Dekorasi Lingkaran Latar ──
                _BackgroundDecoration(animValue: _bgAnim.value, page: page),

                // ── Konten Halaman ──
                PageView.builder(
                  controller: _controller,
                  onPageChanged: _onPageChanged,
                  itemCount: _pages.length,
                  itemBuilder: (_, i) => _SplashPage(
                    data: _pages[i],
                    fadeAnim: _fadeAnim,
                    slideAnim: _slideAnim,
                  ),
                ),

                // ── Header: Logo + Skip ──
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Logo teks
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'La',
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.white,
                                    letterSpacing: -0.5,
                                  ),
                                ),
                                TextSpan(
                                  text: 'Pak',
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w900,
                                    color: page.accentColor,
                                    letterSpacing: -0.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (!isLast)
                            TextButton(
                              onPressed: _skip,
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.white70,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                              ),
                              child: const Text(
                                'Lewati',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),

                // ── Indikator + Tombol Bawah ──
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(32, 0, 32, 32),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Dot indicator
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              _pages.length,
                              (i) => AnimatedContainer(
                                duration: const Duration(milliseconds: 350),
                                curve: Curves.easeInOut,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                width: _currentPage == i ? 28 : 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: _currentPage == i
                                      ? page.accentColor
                                      : Colors.white30,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 28),

                          // Tombol utama
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            width: double.infinity,
                            height: 56,
                            child: ElevatedButton(
                              onPressed: _goToNext,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: page.gradientStart,
                                elevation: 0,
                                shadowColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    isLast ? 'Mulai Sekarang' : 'Selanjutnya',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: page.gradientStart,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Icon(
                                    isLast
                                        ? Icons.rocket_launch_rounded
                                        : Icons.arrow_forward_rounded,
                                    size: 20,
                                    color: page.gradientStart,
                                  ),
                                ],
                              ),
                            ),
                          ),

                          if (isLast) ...[
                            const SizedBox(height: 12),
                            Text(
                              'Kabupaten Bantul · Dinas Pendapatan Daerah',
                              style: TextStyle(
                                color: Colors.white38,
                                fontSize: 11,
                                letterSpacing: 0.3,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// ──────────────────────────────────────────────────
// Data model
// ──────────────────────────────────────────────────

class _SplashData {
  final String title;
  final String description;
  final IconData icon;
  final Color gradientStart;
  final Color gradientEnd;
  final Color accentColor;

  const _SplashData({
    required this.title,
    required this.description,
    required this.icon,
    required this.gradientStart,
    required this.gradientEnd,
    required this.accentColor,
  });
}

// ──────────────────────────────────────────────────
// Halaman konten splash
// ──────────────────────────────────────────────────

class _SplashPage extends StatelessWidget {
  final _SplashData data;
  final Animation<double> fadeAnim;
  final Animation<Offset> slideAnim;

  const _SplashPage({
    required this.data,
    required this.fadeAnim,
    required this.slideAnim,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 80),

            // ── Ikon ──
            FadeTransition(
              opacity: fadeAnim,
              child: SlideTransition(
                position: slideAnim,
                child: _IconBadge(data: data),
              ),
            ),

            const SizedBox(height: 48),

            // ── Judul ──
            FadeTransition(
              opacity: fadeAnim,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 0.4),
                  end: Offset.zero,
                ).animate(fadeAnim),
                child: Text(
                  data.title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    height: 1.25,
                    letterSpacing: -0.3,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // ── Deskripsi ──
            FadeTransition(
              opacity: fadeAnim,
              child: Text(
                data.description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white.withValues(alpha: 0.75),
                  height: 1.65,
                  letterSpacing: 0.1,
                ),
              ),
            ),

            const Spacer(),
          ],
        ),
      ),
    );
  }
}

// ──────────────────────────────────────────────────
// Badge ikon dengan efek ring
// ──────────────────────────────────────────────────

class _IconBadge extends StatefulWidget {
  final _SplashData data;
  const _IconBadge({required this.data});

  @override
  State<_IconBadge> createState() => _IconBadgeState();
}

class _IconBadgeState extends State<_IconBadge>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseCtrl;
  late Animation<double> _pulse;

  @override
  void initState() {
    super.initState();
    _pulseCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _pulse = Tween<double>(begin: 0.95, end: 1.05).animate(
      CurvedAnimation(parent: _pulseCtrl, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _pulse,
      builder: (_, child) => Transform.scale(
        scale: _pulse.value,
        child: child,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Ring luar
          Container(
            width: 180,
            height: 180,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: widget.data.accentColor.withValues(alpha: 0.2),
                width: 2,
              ),
            ),
          ),
          // Ring tengah
          Container(
            width: 156,
            height: 156,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withValues(alpha: 0.08),
              border: Border.all(
                color: widget.data.accentColor.withValues(alpha: 0.35),
                width: 1.5,
              ),
            ),
          ),
          // Lingkaran ikon utama
          Container(
            width: 128,
            height: 128,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  Colors.white.withValues(alpha: 0.22),
                  Colors.white.withValues(alpha: 0.08),
                ],
              ),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.3),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: widget.data.accentColor.withValues(alpha: 0.25),
                  blurRadius: 30,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: Icon(
              widget.data.icon,
              size: 64,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

// ──────────────────────────────────────────────────
// Dekorasi lingkaran latar belakang
// ──────────────────────────────────────────────────

class _BackgroundDecoration extends StatelessWidget {
  final double animValue;
  final _SplashData page;

  const _BackgroundDecoration({
    required this.animValue,
    required this.page,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Stack(
      children: [
        // Lingkaran kanan atas
        Positioned(
          top: -size.width * 0.2,
          right: -size.width * 0.15,
          child: Transform.rotate(
            angle: animValue * math.pi * 0.1,
            child: Container(
              width: size.width * 0.7,
              height: size.width * 0.7,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.04),
                border: Border.all(
                  color: page.accentColor.withValues(alpha: 0.12),
                  width: 1,
                ),
              ),
            ),
          ),
        ),
        // Lingkaran kiri bawah
        Positioned(
          bottom: -size.width * 0.25,
          left: -size.width * 0.2,
          child: Container(
            width: size.width * 0.75,
            height: size.width * 0.75,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withValues(alpha: 0.03),
              border: Border.all(
                color: page.accentColor.withValues(alpha: 0.08),
                width: 1,
              ),
            ),
          ),
        ),
        // Titik-titik dekoratif kecil
        Positioned(
          top: size.height * 0.12,
          left: 28,
          child: _Dot(color: page.accentColor.withValues(alpha: 0.4)),
        ),
        Positioned(
          top: size.height * 0.18,
          left: 52,
          child: _Dot(color: page.accentColor.withValues(alpha: 0.25), size: 5),
        ),
        Positioned(
          bottom: size.height * 0.22,
          right: 32,
          child: _Dot(color: page.accentColor.withValues(alpha: 0.35)),
        ),
        Positioned(
          bottom: size.height * 0.28,
          right: 56,
          child: _Dot(color: page.accentColor.withValues(alpha: 0.2), size: 5),
        ),
      ],
    );
  }
}

class _Dot extends StatelessWidget {
  final Color color;
  final double size;
  const _Dot({required this.color, this.size = 7});

  @override
  Widget build(BuildContext context) => Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
        ),
      );
}

