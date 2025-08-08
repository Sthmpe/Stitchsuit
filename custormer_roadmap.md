# 📱 Tailoring App: Customer Role Development Plan

This file outlines all features for the **Customer** role in the tailoring app built with Flutter + Firebase + BLoC.

## 🧱 Tech Architecture

- **State Management**: BLoC (with BlocProvider, BlocListener, BlocBuilder)
- **Routing**: Manual (`Get.to`, `Get.offAll`), no named routes
- **Backend**: Firebase Auth, Firestore, Firebase Storage
- **Payment Gateway**: Paystack
- **Architecture**: Repository Pattern (clean, testable)


---

## 🔀 Phases Overview

### ✅ Phase 1: Authentication & Dashboard Setup
- Sign Up / Login with Role = Customer
- Store role and user info in `/users`
- Forgot Password
- Show customer dashboard after login

### ✅ Phase 2: Tailor Discovery & Booking
- Browse tailor profiles
- View tailor designs
- Book appointment
- Add project description

### ✅ Phase 3: Fabric Selection & Measurement
- Browse & filter fabrics
- Add fabric to "My Project"
- Submit measurements (form + image/video upload)

### ✅ Phase 4: Order Tracking & Messaging
- View order timeline (Booked → In Progress → Completed)
- Cancel/reschedule if needed
- Chat with tailor (text + media)

### ✅ Phase 5: Payment & Reviews
- Pay for tailoring/fabrics via Paystack
- View payment receipts
- Leave reviews and ratings after completed service

### ✅ Phase 6: Profile Settings & Finishing
- Edit personal details
- Change password
- Upload/change profile photo
- Final UI/UX polish and loading/error states

---

## 🔁 Current Phase: Phase 1 – Authentication

🎯 Goal: Enable user registration and login with Firebase, store role info, and redirect to dashboard.

Next step: Implement `auth_repository.dart` and `auth_bloc.dart`, then create the login and signup screens.

