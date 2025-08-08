import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'photo_capture_screen.dart';
import 'personality_analysis_screen.dart';
import 'fortune_prediction_screen.dart';

void main() {
  runApp(const FaceReaderApp());
}

class FaceReaderApp extends StatelessWidget {
  const FaceReaderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '신비로운 관상 분석',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late AnimationController _star1Controller;
  late AnimationController _star2Controller;
  late AnimationController _gemController;
  late AnimationController _moonController;

  late Animation<double> _star1Animation;
  late Animation<double> _star2Animation;
  late Animation<double> _gemAnimation;
  late Animation<double> _moonAnimation;

  @override
  void initState() {
    super.initState();

    // 별1 애니메이션 (위아래 움직임)
    _star1Controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _star1Animation = Tween<double>(begin: -10.0, end: 10.0).animate(
      CurvedAnimation(parent: _star1Controller, curve: Curves.easeInOut),
    );
    _star1Controller.repeat(reverse: true);

    // 별2 애니메이션 (위아래 움직임)
    _star2Controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _star2Animation = Tween<double>(begin: -10.0, end: 10.0).animate(
      CurvedAnimation(parent: _star2Controller, curve: Curves.easeInOut),
    );
    _star2Controller.repeat(reverse: true);

    // 보석 애니메이션 (제자리 회전)
    _gemController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    _gemAnimation = Tween<double>(
      begin: 0.0,
      end: 2 * math.pi,
    ).animate(CurvedAnimation(parent: _gemController, curve: Curves.linear));
    _gemController.repeat();

    // 달 애니메이션 (위아래 움직임)
    _moonController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _moonAnimation = Tween<double>(begin: -8.0, end: 8.0).animate(
      CurvedAnimation(parent: _moonController, curve: Curves.easeInOut),
    );
    _moonController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _star1Controller.dispose();
    _star2Controller.dispose();
    _gemController.dispose();
    _moonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF2D1B69), // 진한 보라색
              Color(0xFF8B5CF6), // 중간 보라색
              Color(0xFFEC4899), // 핑크색
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight:
                    MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.top -
                    MediaQuery.of(context).padding.bottom,
              ),
              child: IntrinsicHeight(
                child: Column(
                  children: [
                    // 상단 애니메이션 요소들
                    SizedBox(
                      height: 300,
                      child: Stack(
                        children: [
                          // 왼쪽 상단 별
                          Positioned(
                            top: 50,
                            left: 30,
                            child: AnimatedBuilder(
                              animation: _star1Animation,
                              builder: (context, child) {
                                return Transform.translate(
                                  offset: Offset(0, _star1Animation.value),
                                  child: const Icon(
                                    Icons.star,
                                    color: Colors.yellow,
                                    size: 30,
                                  ),
                                );
                              },
                            ),
                          ),
                          // 오른쪽 상단 별
                          Positioned(
                            top: 50,
                            right: 30,
                            child: AnimatedBuilder(
                              animation: _star2Animation,
                              builder: (context, child) {
                                return Transform.translate(
                                  offset: Offset(0, _star2Animation.value),
                                  child: const Icon(
                                    Icons.star,
                                    color: Colors.yellow,
                                    size: 30,
                                  ),
                                );
                              },
                            ),
                          ),
                          // 중앙 보석 (회전)
                          Center(
                            child: AnimatedBuilder(
                              animation: _gemAnimation,
                              builder: (context, child) {
                                return Transform.rotate(
                                  angle: _gemAnimation.value,
                                  child: const Icon(
                                    Icons.diamond,
                                    color: Colors.white,
                                    size: 80,
                                  ),
                                );
                              },
                            ),
                          ),
                          // 보석 아래 달 (위아래 움직임)
                          Positioned(
                            top: 200,
                            left: 0,
                            right: 0,
                            child: AnimatedBuilder(
                              animation: _moonAnimation,
                              builder: (context, child) {
                                return Transform.translate(
                                  offset: Offset(0, _moonAnimation.value),
                                  child: const Icon(
                                    Icons.nightlight_round,
                                    color: Colors.white,
                                    size: 40,
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    // 제목과 설명
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          const Text(
                            '신비로운 관상 분석',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            '당신의 얼굴에 숨겨진 운명과 성격을 AI가 분석해드립니다.',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            '신비로운 관상학의 세계로 떠나보세요.',
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                    // 기능 카드들
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const PersonalityAnalysisScreen(),
                                  ),
                                );
                              },
                              child: _buildFeatureCard(
                                icon: Icons.diamond,
                                title: '성격 분석',
                                description: '깊이 있는 성격 특성 파악',
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const FortunePredictionScreen(),
                                  ),
                                );
                              },
                              child: _buildFeatureCard(
                                icon: Icons.star,
                                title: '운세 예측',
                                description: '미래의 기운과 운명 해석',
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildFeatureCard(
                              icon: Icons.auto_awesome,
                              title: '맞춤 조언',
                              description: '개인별 운기 상승 방법',
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                    // 하단 버튼과 디스클레이머
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            height: 56,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFF8B5CF6), Color(0xFFEC4899)],
                              ),
                              borderRadius: BorderRadius.circular(28),
                            ),
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const PhotoCaptureScreen(),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(28),
                                ),
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.diamond,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    '관상 분석 시작하기',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            '* 이 서비스는 엔터테인먼트 목적으로 제공됩니다',
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    // 소프트웨어 버튼
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            '소프트웨어',
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureCard({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.2), width: 1),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white, size: 32),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            description,
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 10,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
