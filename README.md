# 🚀 Flutter Portfolio — Web & Mobile

A beautiful, responsive personal portfolio built with Flutter. Works on **Web, Android, and iOS** from a single codebase.

---

## ✨ Features
- 🌙 Dark theme with electric violet/cyan palette
- 📱 Fully responsive (mobile, tablet, desktop)
- 🎭 Smooth animations & hover effects
- ⌨️ Animated typing text in Hero section
- 📍 Timeline for Experience section
- 🃏 Hover-lift Project cards
- 🧭 Smooth scroll navigation
- 🌐 Web-ready with Flutter Web support

---

## 📁 Project Structure

```
lib/
├── main.dart                    # App entry point
├── theme/
│   └── app_theme.dart           # Colors, typography
├── models/
│   └── portfolio_data.dart      # ⭐ YOUR DATA GOES HERE
├── utils/
│   └── responsive.dart          # Breakpoints & helpers
├── widgets/
│   ├── common_widgets.dart      # Reusable components
│   └── navbar.dart              # Navigation bar
└── screens/
    ├── portfolio_page.dart      # Main scaffold
    ├── hero_section.dart        # Landing / Hero
    ├── about_section.dart       # About + Stats
    ├── skills_section.dart      # Tech stack grid
    ├── experience_section.dart  # Work history timeline
    ├── projects_section.dart    # Project cards
    └── contact_section.dart     # Contact + Footer
```

---

## 🛠 Setup

### 1. Install Flutter
```bash
flutter --version   # should be 3.x+
```

### 2. Install Dependencies
```bash
cd flutter_portfolio
flutter pub get
```

### 3. Run on Mobile
```bash
flutter run
```

### 4. Run on Web
```bash
flutter run -d chrome
```

### 5. Build for Web (Deploy)
```bash
flutter build web --release
# Output in: build/web/
# Deploy to: Firebase Hosting / Vercel / Netlify
```

### 6. Deploy to Vercel
```bash
npm i -g vercel
cd build/web
vercel --prod
```

---

## ✏️ Customize Your Data

**Open `lib/models/portfolio_data.dart` and update:**

```dart
static const String name = "Your Real Name";
static const String email = "you@email.com";
static const String github = "https://github.com/yourhandle";
static const String linkedin = "https://linkedin.com/in/yourhandle";
```

- **Stats** → `stats` list (Years, Projects, Clients, Rating)
- **About** → `aboutText` string
- **Skills** → `skills` list (categories + tech chips)
- **Experience** → `experience` list (company, role, duration, description)
- **Projects** → `projects` list (title, desc, tags, emoji, links)

---

## 🔗 Adding URL Launcher

In `contact_section.dart` and project cards, replace `onTap: () {}` with:

```dart
import 'package:url_launcher/url_launcher.dart';

onTap: () async {
  final uri = Uri.parse(PortfolioData.github);
  if (await canLaunchUrl(uri)) await launchUrl(uri);
},
```

---

## 🎨 Change Theme

In `lib/theme/app_theme.dart`:
```dart
static const Color primary = Color(0xFF7C3AED);     // Violet → change to your color
static const Color accent  = Color(0xFF06B6D4);     // Cyan
static const Color background = Color(0xFF0A0A0F);  // Near-black
```

---

## 📦 Dependencies

| Package | Use |
|---------|-----|
| `google_fonts` | Space Grotesk + Inter typography |
| `animated_text_kit` | Typing animation in Hero |
| `url_launcher` | Open links |
| `flutter_svg` | SVG support |
| `font_awesome_flutter` | Social icons |

---

## 🚀 Deploy

| Platform | Command |
|----------|---------|
| Firebase | `firebase deploy` |
| Vercel | `vercel build/web --prod` |
| Netlify | Drag `build/web` to Netlify |

---

Built with 💙 Flutter
