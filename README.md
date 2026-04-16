# Single Dogs' Club

> Find canine friends near you.

A cross-platform app (iOS, Android, Web) connecting dog owners for walks, playdates, cafe meet-ups, and lasting friendships.

## Tech Stack

| Layer | Technology |
|---|---|
| Framework | Flutter 3.x / Dart |
| State Management | Riverpod |
| Routing | GoRouter (deep linking, URL-based) |
| Backend | Firebase (Auth, Firestore, Storage, FCM) |
| Maps | Google Maps Flutter |
| Fonts | Google Fonts (Fraunces + DM Sans) |
| Animations | flutter_animate |
| Swipe Cards | flutter_card_swiper |
| Chat | flutter_chat_ui |

## Project Structure

```
lib/
  core/
    theme/          Brand colours, typography, Material theme
    router/         GoRouter config with auth redirects
    constants/      Spacing, breakpoints, string constants
    widgets/        Shared reusable widgets (buttons, headers)
  features/
    auth/           Login, Register, Onboarding screens
    home/           Landing page (marketing site) + shell with bottom nav
    discover/       Swipe cards, list view, filters, dog detail
    map/            Walk finder, dog-friendly places, nearby dogs
    services/       Local services directory (walkers, groomers, vets)
    chat/           Message list, conversation detail
    profile/        User profile, edit profile, add/edit dog
  models/           Data classes (DogProfile, UserProfile, DogWalk, Match)
  providers/        Riverpod providers (TODO: wire up)
  services/         API / Firebase service layer (TODO: implement)
```

## Getting Started

### Prerequisites

- Flutter SDK >= 3.2.0
- Dart >= 3.2.0
- Firebase project (for auth, database, storage)
- Google Maps API key (for map features)

### Setup

```bash
# Clone the repo
git clone <repo-url>
cd single_dogs_club

# Install dependencies
flutter pub get

# Run on web
flutter run -d chrome

# Run on iOS simulator
flutter run -d ios

# Run on Android emulator
flutter run -d android

# Build for web deployment
flutter build web --release
```

### Firebase Setup

1. Create a Firebase project at https://console.firebase.google.com
2. Enable Authentication (Email/Password + Google Sign-In)
3. Create a Firestore database
4. Enable Firebase Storage
5. Run `flutterfire configure` to generate config files
6. Uncomment the Firebase initialisation in `lib/main.dart`

### Google Maps Setup

1. Enable Maps SDK for Android, iOS, and JavaScript in Google Cloud Console
2. Add your API key to:
   - `android/app/src/main/AndroidManifest.xml`
   - `ios/Runner/AppDelegate.swift`
   - `web/index.html`

## Brand Colours

| Name | Hex | Usage |
|---|---|---|
| Coral | #E8837C | Primary actions, CTAs, accents |
| Coral Dark | #D4655F | Hover states, emphasis |
| Sage | #7AB68E | Secondary actions, success, nature |
| Sage Dark | #5A9E6E | Active states |
| Cream | #FDF8F4 | Background |
| Forest | #2D3A2E | Text primary, dark sections |

## Architecture Decisions

**Why Flutter?** Single codebase for iOS, Android, and Web. Pixel-perfect rendering via Skia/Impeller. Strong animation performance for swipe-card interactions.

**Why Riverpod?** Compile-safe, testable, scales well from simple state to complex async flows. No context dependency for accessing state.

**Why GoRouter?** URL-based routing essential for web deployment. Deep linking support for mobile. Clean nested route definitions with shell routes for bottom nav.

**Why Firebase?** Fastest path to production for auth, real-time database, file storage, and push notifications. Can migrate to a custom backend later if needed.

## Screens Overview

1. **Landing** - Marketing page with hero, features, testimonials, about, CTA
2. **Login / Register** - Email + Google auth
3. **Onboarding** - 3-step walkthrough for new users
4. **Discover** - Swipe cards or list view with filter sheet
5. **Dog Detail** - Full profile with photos, tags, owner info, match/message CTAs
6. **Walks (Map)** - Interactive map with walk list, places, nearby dogs
7. **Services** - Category grid + directory of local dog services
8. **Chat** - Matches row, conversation list, message detail with real-time chat
9. **Profile** - User info, dog cards, activity stats, settings menu

## TODO / Next Steps

- [ ] Wire up Firebase Auth (login, register, Google sign-in)
- [ ] Implement Firestore CRUD for dog profiles, matches, walks
- [ ] Add image upload with Firebase Storage + image_cropper
- [ ] Integrate Google Maps with custom markers
- [ ] Build real-time chat with Firestore streams
- [ ] Add push notifications via Firebase Cloud Messaging
- [ ] Implement matching algorithm (mutual likes = match)
- [ ] Add review/rating system for walks and places
- [ ] Write unit and widget tests
- [ ] Set up CI/CD (GitHub Actions or Codemagic)
- [ ] App Store and Play Store submission

## Authors

- **Sarah** - Ex-RSPCA Inspector, Animal Behaviour & Welfare
- **Ash** - Pipeline & App Development

## Contact

- Web: www.singledogsclub.co.uk
- Email: Contactus@singledogsclub.co.uk
