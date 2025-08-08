import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class CompatibilityPhotoScreen extends StatefulWidget {
  const CompatibilityPhotoScreen({super.key});

  @override
  State<CompatibilityPhotoScreen> createState() =>
      _CompatibilityPhotoScreenState();
}

class _CompatibilityPhotoScreenState extends State<CompatibilityPhotoScreen> {
  File? _myImage;
  File? _partnerImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImageFromGallery(bool isMyPhoto) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );
      if (image != null) {
        setState(() {
          if (isMyPhoto) {
            _myImage = File(image.path);
          } else {
            _partnerImage = File(image.path);
          }
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('사진을 선택하는 중 오류가 발생했습니다.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _resetImages() {
    setState(() {
      _myImage = null;
      _partnerImage = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF2D1B69), Color(0xFF8B5CF6), Color(0xFFEC4899)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // 헤더
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      '궁합 분석',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              // 스크롤 가능한 메인 콘텐츠
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      // 설명 텍스트
                      const Text(
                        '나와 상대방의 사진을 업로드해주세요',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        '두 사람의 얼굴이 선명하게 보이는 사진을 선택해주세요',
                        style: TextStyle(color: Colors.white, fontSize: 14),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 32),
                      // 사진 업로드 영역
                      Row(
                        children: [
                          // 내 사진
                          Expanded(
                            child: _buildPhotoUploadSection(
                              title: '내 사진',
                              image: _myImage,
                              onTap: () => _pickImageFromGallery(true),
                              isMyPhoto: true,
                            ),
                          ),
                          const SizedBox(width: 16),
                          // 상대방 사진
                          Expanded(
                            child: _buildPhotoUploadSection(
                              title: '상대방 사진',
                              image: _partnerImage,
                              onTap: () => _pickImageFromGallery(false),
                              isMyPhoto: false,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),
                      // 버튼 영역
                      if (_myImage == null || _partnerImage == null) ...[
                        const Text(
                          '두 사람의 사진을 모두 업로드해주세요',
                          style: TextStyle(color: Colors.white, fontSize: 14),
                          textAlign: TextAlign.center,
                        ),
                      ] else ...[
                        // 궁합 분석하기 버튼
                        SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              // TODO: 궁합 분석 기능 연결
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('궁합 분석을 시작합니다...'),
                                  backgroundColor: Colors.green,
                                ),
                              );
                            },
                            icon: const Icon(
                              Icons.favorite,
                              color: Colors.white,
                            ),
                            label: const Text(
                              '궁합 분석하기',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF22C55E),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(28),
                              ),
                              elevation: 0,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        // 다시 선택하기 버튼
                        SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: OutlinedButton(
                            onPressed: _resetImages,
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(
                                color: Color(0xFF8B5CF6),
                                width: 2,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(28),
                              ),
                              backgroundColor: Colors.transparent,
                            ),
                            child: const Text(
                              '다시 선택하기',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                      const SizedBox(height: 32),
                      // 촬영 팁 섹션
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.2),
                            width: 1,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                  size: 20,
                                ),
                                const SizedBox(width: 8),
                                const Text(
                                  '궁합 분석 팁',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            _buildTipItem('정면을 바라보는 선명한 사진을 사용해주세요'),
                            _buildTipItem('두 사람 모두 얼굴이 잘 보이는 사진이 좋습니다'),
                            _buildTipItem('밝은 조명에서 촬영된 사진을 권장합니다'),
                            _buildTipItem('최근 사진을 사용하면 더 정확한 분석이 가능합니다'),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPhotoUploadSection({
    required String title,
    required File? image,
    required VoidCallback onTap,
    required bool isMyPhoto,
  }) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        AspectRatio(
          aspectRatio: 1,
          child: GestureDetector(
            onTap: onTap,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Colors.white.withOpacity(0.2),
                  width: 1,
                ),
              ),
              child: image != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.file(
                        image,
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          isMyPhoto ? Icons.person : Icons.favorite,
                          color: Colors.white,
                          size: 40,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          isMyPhoto ? '내 사진\n업로드' : '상대방 사진\n업로드',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTipItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('• ', style: TextStyle(color: Colors.white, fontSize: 14)),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
