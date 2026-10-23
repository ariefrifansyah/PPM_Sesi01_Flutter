import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PPM Sesi 1',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF4F7F6), // Background abu-abu kehijauan lembut
      ),
      home: const CounterPage(),
    );
  }
}

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() => _counter++);
  }

  void _decrementCounter() {
    if (_counter > 0) {
      setState(() => _counter--);
    } else {
      _showLimitSnackBar();
    }
  }

  void _resetCounter() {
    setState(() => _counter = 0);
  }

  void _showLimitSnackBar() {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Nilai counter tidak boleh kurang dari 0!'),
        backgroundColor: Colors.redAccent,
        duration: Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isEven = _counter % 2 == 0;
    final Color counterColor = isEven ? Colors.teal : Colors.deepOrange;
    final String statusText = isEven ? 'Status: Angka Genap' : 'Status: Angka Ganjil';

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'PPM Sesi 1 - Mohamad Arief Rifansyah (20240040194)',
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.teal.shade700,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 1. KARTU PROFIL PREMIUM
            const _ProfileCard(
              nama: 'Mohamad Arief Rifansyah',
              nim: '20240040194',
              prodi: 'Teknik Informatika',
              kelas: 'TI24B',
            ),
            const SizedBox(height: 20),
            
            // 2. DISPLAY COUNTER UTAMA
            _CounterDisplay(
              counter: _counter,
              counterColor: counterColor,
              statusText: statusText,
            ),
            const SizedBox(height: 24),
            
            // 3. TOMBOL KONTROL MULTI-FUNGSI
            _CounterControls(
              onIncrement: _incrementCounter,
              onDecrement: _decrementCounter,
              onReset: _resetCounter,
            ),
          ],
        ),
      ),
    );
  }
}

// =============================================================================
// MODULAR WIDGETS (PREMIUM UI DESIGN)
// =============================================================================

class _ProfileCard extends StatelessWidget {
  final String nama;
  final String nim;
  final String prodi;
  final String kelas;

  const _ProfileCard({
    required this.nama,
    required this.nim,
    required this.prodi,
    required this.kelas,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.teal.withValues(alpha: 0.08),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Avatar dengan efek border ganda yang elegan
            Container(
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.teal.shade200, width: 2),
              ),
              child: CircleAvatar(
                radius: 34,
                backgroundColor: Colors.teal.shade50,
                child: Icon(Icons.person, size: 40, color: Colors.teal.shade700),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              nama,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2D3748),
              ),
            ),
            const SizedBox(height: 12),
            Divider(color: Colors.grey.shade200, thickness: 1, indent: 10, endIndent: 10),
            const SizedBox(height: 12),
            
            // Baris Informasi Terstruktur dengan Desain Chip/Row
            _buildInfoRow(Icons.badge_outlined, 'NIM', nim),
            const SizedBox(height: 8),
            _buildInfoRow(Icons.school_outlined, 'Program Studi', prodi),
            const SizedBox(height: 8),
            _buildInfoRow(Icons.meeting_room_outlined, 'Kelas', kelas),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: Colors.teal.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 16, color: Colors.teal.shade700),
        ),
        const SizedBox(width: 12),
        Text(
          '$label:',
          style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.w500, fontSize: 13),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              color: Color(0xFF2D3748),
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }
}

class _CounterDisplay extends StatelessWidget {
  final int counter;
  final Color counterColor;
  final String statusText;

  const _CounterDisplay({
    required this.counter,
    required this.counterColor,
    required this.statusText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 20.0),
        child: Column(
          children: [
            const Text(
              'JUMLAH HITUNGAN',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '$counter',
              style: TextStyle(
                fontSize: 60,
                fontWeight: FontWeight.w900,
                color: counterColor,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                color: counterColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: counterColor.withValues(alpha: 0.3)),
              ),
              child: Text(
                statusText,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: counterColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CounterControls extends StatelessWidget {
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final VoidCallback onReset;

  const _CounterControls({
    required this.onIncrement,
    required this.onDecrement,
    required this.onReset,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: onDecrement,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent.shade400,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              elevation: 2,
            ),
            icon: const Icon(Icons.remove, size: 16),
            label: const Text('Kurang', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: OutlinedButton.icon(
            onPressed: onReset,
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              side: BorderSide(color: Colors.grey.shade300, width: 1.5),
              backgroundColor: Colors.white,
            ),
            icon: const Icon(Icons.refresh, size: 16, color: Colors.black87),
            label: const Text('Reset', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black87)),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: ElevatedButton.icon(
            onPressed: onIncrement,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal.shade600,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              elevation: 2,
            ),
            icon: const Icon(Icons.add, size: 16),
            label: const Text('Tambah', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
          ),
        ),
      ],
    );
  }
}