# FaceReader - AI 관상 분석 앱

AI 기반 관상 분석 웹 애플리케이션입니다. 사용자의 얼굴 사진을 분석하여 성격, 운세, 궁합을 제공합니다.

## 주요 기능

- **성격 분석**: AI가 얼굴 특징을 바탕으로 성격 특성과 기질을 분석
- **운세 예측**: 미래의 기운과 운명을 예측
- **궁합 보기**: 두 사람의 궁합을 분석하고 점수 제공

## 기술 스택

- Flutter Web
- Dart
- AI 기반 이미지 분석

## Vercel 배포

이 프로젝트는 Vercel에 배포되도록 설정되어 있습니다.

### 배포 방법

1. **GitHub에 코드 푸시**
   ```bash
   git add .
   git commit -m "Initial commit"
   git push origin main
   ```

2. **Vercel에서 프로젝트 연결**
   - [Vercel](https://vercel.com)에 로그인
   - "New Project" 클릭
   - GitHub 저장소 선택
   - 자동으로 설정이 적용됨

3. **배포 설정**
   - Framework Preset: `Other`
   - Build Command: `flutter build web --release`
   - Output Directory: `build/web`
   - Install Command: `flutter pub get`

### 환경 변수

특별한 환경 변수는 필요하지 않습니다.

### 빌드 설정

- **Node.js 버전**: 18.x 이상
- **Flutter 버전**: 3.x 이상

## 로컬 개발

```bash
# 의존성 설치
flutter pub get

# 웹 빌드
flutter build web

# 로컬 서버 실행
flutter run -d chrome
```

## 라이선스

이 프로젝트는 MIT 라이선스 하에 배포됩니다.
