# Finance House Assessment

A Flutter application built for Finance House as part of a technical assessment. The app allows
users to manage top-up beneficiaries, view top-up options, and perform mobile credit top-up
transactions for UAE phone numbers.

---

# Features

- Add credit to UAE phone numbers.
- Manage up to 5 active top-up beneficiaries.
- Assign nicknames to beneficiaries (max 20 characters).
- View and choose from fixed top-up options:`AED 5, 10, 20, 30, 50, 75, 100`.
- Support for monthly top-up limits based on verification:
- Unverified: AED 500/month per beneficiary.
- Verified: AED 1,000/month per beneficiary.
- Total max: AED 3,000/month across all beneficiaries.
- AED 3 charge per transaction.
- Light & Dark mode support.
- Localization: English and Arabic 
- Clean architecture (data, domain, presentation layers).
- Mocked REST API integration.
- State management using `Bloc cubit`.
- Error handling.

---

# Tech Stack

- Flutter
- Dart
- Bloc & Cubit
- Dio** for networking
- Easy Localization**
- Flutter ScreenUtil for responsive UI
- Clean Architecture structure 

---

# Getting Started

Follow these steps to run the app locally:

# 1. Clone the repository

git clone https://github.com/your-username/finance_house_assessment.git
cd finance_house_assessment

# 2. Install dependencies
flutter pub get

# 3. Run the app
flutter run

# 4 . Run all tests
flutter test

# 5.  Run specific test file
flutter test test/unit-test-path

## 📱 Screenshots

<div align="center">
<img src="https://github.com/user-attachments/assets/8022db39-06b3-4b9a-8719-9b829f7d3566" width="200" alt="Screen 1" />
<img src="https://github.com/user-attachments/assets/01540788-7110-421a-952a-e16cc3887f2d" width="200" alt="Screen 2" />
<img src="https://github.com/user-attachments/assets/f6cb80d7-5221-4d99-8a70-6eec048918ce" width="200" alt="Screen 3" />
<img src="https://github.com/user-attachments/assets/c8f5fe77-7ada-4566-88c3-1407cc343cf6" width="200" alt="Screen 4" />
</div>
<br />
<div align="center">
<img src="https://github.com/user-attachments/assets/edcea404-175c-4c1d-8b04-babc171fe53f" width="200" alt="Screen 5" />
<img src="https://github.com/user-attachments/assets/ee80bdae-5e04-4b4a-a40e-4b021255ae9a" width="200" alt="Screen 6" />
<img src="https://github.com/user-attachments/assets/046e73e3-1a54-429a-a250-e306d25eb26a" width="200" alt="Screen 7" />
<img src="https://github.com/user-attachments/assets/6df008f8-a0cb-46b4-97cd-74380be29e38" width="200" alt="Screen 8" />
</div>


