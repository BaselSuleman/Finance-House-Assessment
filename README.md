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




