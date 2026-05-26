# InternshipTracker – Codex Starter Pack

Bu paket, SwiftUI + SwiftData ile geliştirilecek **Internship Tracker** uygulamasını Codex'e düzgün anlatmak için hazırlandı.

## Hedef

Üniversite öğrencilerinin staj/junior başvurularını takip edebileceği sade ama portfolyoda güçlü duran bir iOS uygulaması yapmak.

## Önerilen teknik tercih

- Platform: iOS 17+
- UI: SwiftUI
- Local persistence: SwiftData
- Notifications: UserNotifications
- Architecture: Basit MVVM'e yakın, ama gereksiz abstraction yok
- Backend: Yok, ilk sürüm tamamen local
- App Store MVP hedefi: Var

## Nasıl kullanılır?

1. Xcode'da yeni proje oluştur:
   - Product Name: `InternshipTracker`
   - Interface: SwiftUI
   - Language: Swift
   - Minimum iOS: 17.0 veya üstü
2. Bu dosyaları proje köküne koy:
   - `AGENTS.md`
   - `00_MAIN_CODEX_PROMPT.md`
   - `01_PRODUCT_BRIEF.md`
   - `02_FEATURE_SPEC.md`
   - `03_DATA_MODEL.md`
   - `04_UI_FLOW.md`
   - `05_IMPLEMENTATION_PLAN.md`
   - `06_TEST_CHECKLIST.md`
   - `07_FUTURE_ROADMAP.md`
3. VS Code/Codex'i proje klasöründe aç.
4. Önce `00_MAIN_CODEX_PROMPT.md` içeriğini Codex'e gönder.
5. Codex bitirince uygulamayı Xcode'da çalıştır.
6. Hata olursa hata mesajını Codex'e aynen gönder.
7. MVP çalıştıktan sonra feature feature ilerle.

## Önemli not

Codex'ten tek seferde devasa uygulama isteme. İlk hedef: çalışan, local veri kaydeden, temiz görünümlü MVP.
