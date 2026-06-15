// ─────────────────────────────────────────
//  PORTFOLIO DATA — Replace with your info
// ─────────────────────────────────────────

class PortfolioData {
  // ── Hero ──────────────────────────────
  static const String name = "Sunny Singh";
  static const String profileImage = "assets/images/profile.png";
  static const String tagline = "Flutter Developer";
  // Store badge image paths — assets/images/ mein daalo
  static const String playStoreBadge = "assets/images/play-store.png";
  static const String appStoreBadge = "assets/images/app-store.png";

  static const List<String> roles = [
    "Flutter Developer",
    "Mobile App Developer",
    "Firebase Expert",
    "UI/UX Enthusiast",
  ];

  static const String heroDescription =
      "I build high-performance, beautiful mobile & web applications "
      "using Flutter & Dart. Passionate about clean architecture and "
      "delivering pixel-perfect experiences.";

  // ── Contact ───────────────────────────
  static const String email = "ns613017@email.com";
  static const String github = "https://github.com/flutterbysunny";
  static const String linkedin = "https://www.linkedin.com/in/sunny-singh-83496218b/";
  static const String twitter = "https://x.com/imthesunnym";
  static const String resumeUrl = "https://drive.google.com/file/d/1Rk7sh5YZuAY6yfBEkDzP36T8cO1pd4Rl/view?usp=sharing";


  static const String phone = "+91 9725020716";
  static const String contactImage = "assets/images/contact.jpeg";
  static const String contactDescription =
      "I'm a Flutter developer with 5+ years of experience building scalable, high-performance mobile and web applications using clean architecture and modern state management like GetX, Bloc, Provider, Riverpod. I specialize in delivering user-friendly, API integration, and end-to-end app development.";
  static const String whatsapp = "https://wa.me/919725020716";

  // ── About ─────────────────────────────
  static const String aboutText =
      "Hello! I'm a passionate Flutter developer with 5+ years of experience "
      "building scalable, high-performance mobile applications. I specialize in "
      "Flutter (Dart), Firebase, REST APIs, and clean architecture patterns.\n\n"
      "I enjoy solving complex problems and turning ideas into polished, "
      "user-friendly apps. When I'm not coding, I explore new technologies "
      "and contribute to open-source projects.";

  static const List<StatItem> stats = [
    StatItem(value: "5+", label: "Years Exp"),
    StatItem(value: "20+", label: "Projects"),
    StatItem(value: "10+", label: "Clients"),
    StatItem(value: "4.5★", label: "Reviews"),
  ];

  // ── Skills ────────────────────────────
  static const List<SkillCategory> skills = [
    SkillCategory(
      title: "Mobile",
      icon: "📱",
      skills: ["Flutter", "Dart", "iOS", "Android"],
    ),
    SkillCategory(
      title: "Backend",
      icon: "⚡",
      skills: ["Firebase", "Supabase", "REST API", "GraphQL"],
    ),
    SkillCategory(
      title: "State Management",
      icon: "🔄",
      skills: ["GetX", "BLoC", "Provider", "Riverpod"],
    ),
    SkillCategory(
      title: "Tools",
      icon: "🛠",
      skills: ["Git", "CI/CD", "Figma", "Postman", "Jira"],
    ),
    SkillCategory(
      title: "Other",
      icon: "🌐",
      skills: [
        "Socket.io",
        "Node.js",
        "Google Maps SDK",
        "Payment Gateways",
      ],
    ),
  ];

  // ── Experience ────────────────────────
  static const List<ExperienceItem> experience = [
    ExperienceItem(
      company: "TechupR",
      role: "Senior Flutter Developer",
      duration: "2024 – 2026",
      description:
          "Led development of cross-platform mobile apps. Architected scalable solutions "
          "using BLoC pattern and Firebase backend.",
      technologies: ["Flutter", "Firebase", "GetX", "Bloc", "Provider", "Agora", "Twilio", "CI/CD", "Socket.IO", "Node Js", "Graph QL"],
    ),
    ExperienceItem(
      company: "Appuno IT Solutions",
      role: "Flutter Developer",
      duration: "2023 – 2024",
      description:
          "Built and maintained multiple Flutter applications. Integrated REST APIs, "
          "payment gateways, and push notifications.",
      technologies: ["Flutter", "Dart", "REST API", "Firebase", "GetX", "Socket.IO", "Payment Integration"],
    ),
    ExperienceItem(
      company: "Devkrushna Technology Pvt Ltd",
      role: "Flutter Developer",
      duration: "2022 – 2023",
      description:
          "Delivered end-to-end mobile applications for clients across e-commerce "
          "and logistics domains.",
      technologies: ["Flutter", "Rest API", "SQLITE", "GetX", "Firebase"],
    ),
    ExperienceItem(
      company: "TriState Technology",
      role: "Intern & Flutter Developer",
      duration: "2021 – 2022",
      description:
      "Delivered end-to-end mobile applications for clients across e-commerce "
          "and logistics domains.",
      technologies: ["Flutter", "Dart","Firebase"],
    ),
  ];

  // ── Projects ──────────────────────────
  static const List<ProjectItem> projects = [
    ProjectItem(
      title: "Universal EV",
      description:
          "A complete electric vehicle marketplace app for both Android and iOS. Users can browse an extensive product catalog, manage their cart, make secure Stripe payments, track orders in real-time, and leave reviews. The app features real-time inventory updates via Firebase Firestore and a clean, intuitive UI built entirely in Flutter.",
      tags: ["Flutter", "Firebase", "GetX", "Stripe"],
      githubUrl: "https://github.com/yourusername/project1",
      liveUrl: "",
      emoji: "🛒",
      playStoreUrl: "https://play.google.com/store/apps/details?id=com.universalev.android&hl=en_IN",  // default empty
      appStoreUrl: "https://apps.apple.com/in/app/universal-ev/id6479500968",   // default empty

    ),
    ProjectItem(
      title: "DateNite",
      description:
          "DateNite is a mobile dating application that allows users to discover, connect, and interact with potential matches. The app offers swipe-based matching, real-time chat, and profile management, providing a smooth and interactive dating experience.",
      tags: ["Flutter", "Google Maps", "Firebase", "BLoC"],
      githubUrl: "https://github.com/yourusername/project2",
      liveUrl: "",
      emoji: "📦",
      playStoreUrl: "https://play.google.com/store/apps/details?id=uk.co.datenite.app&hl=en_IN",  // default empty
      appStoreUrl: "https://apps.apple.com/in/app/datenite-dating-matches/id1592597688",   // default empty
    ),
    ProjectItem(
      title: "The Urrbanify",
      description:
          "Urbanify is a real estate mobile application developed completely from scratch using Flutter Dart.The app allows users to explore property listings, view project details, interactive maps, and get real-time information related to real estate projects.",
      tags: ["Flutter", "OpenAI API", "Firebase", "Provider"],
      githubUrl: "https://github.com/yourusername/project3",
      liveUrl: "",
      emoji: "🤖",
      playStoreUrl: "https://play.google.com/store/apps/details?id=com.theurbanify&hl=en_IN",  // default empty
      appStoreUrl: "https://apps.apple.com/in/app/the-urrbanify/id6742242837",   // default empty
    ),
    ProjectItem(
      title: "MyRajasthan Club",
      description:
          "MyRajasthan Club is a social media application that enables users to chat, communicate  in groups, and interact with each other. The app supports real-time chat, social login, in-app purchases, and push notifications",
      tags: ["Flutter", "Supabase", "Riverpod", "Rest API"],
      githubUrl: "https://github.com/yourusername/project4",
      liveUrl: "",
      emoji: "👥",
      playStoreUrl: "",  // default empty
      appStoreUrl: "https://apps.apple.com/in/app/myrajasthan-club/id1545374835",   // default empty
    ),
    ProjectItem(
      title: "Finance Jobs Int",
      description:
          "Finance Jobs is a career-focused mobile application developed from scratch using Flutter and GetX, designed to help users search, apply, and track finance-related job opportunities through a smooth and scalable architecture.",
      tags: ["Flutter", "Hive", "fl_chart", "Provider"],
      githubUrl: "https://github.com/yourusername/project5",
      liveUrl: "",
      emoji: "💰",
      playStoreUrl: "https://play.google.com/store/apps/details?id=com.app.financejobs&hl=en_IN",  // default empty
      appStoreUrl: "https://apps.apple.com/us/app/finance-jobs-int/id6754635760",   // default empty
    ),
    ProjectItem(
      title: "Conteudo Local",
      description:
          "Conteudo is a content-driven mobile application developed completely from scratch using Flutter and GetX. The app is designed to deliver structured digital content to users with a clean UI, smooth navigation, and scalable architecture.",
      tags: ["Flutter", "HealthKit", "Firebase", "BLoC"],
      githubUrl: "https://github.com/yourusername/project6",
      liveUrl: "",
      emoji: "💪",
      playStoreUrl: "https://play.google.com/store/apps/details?id=com.conteudo.app&hl=en",  // default empty
      appStoreUrl: "https://apps.apple.com/us/app/conteudo/id6755385342",   // default empty
    ),

    ProjectItem(
      title: "Blkem",
      description:
        "An actionable social networking platform designed for the black community, allowing users to create posts, interact, and engage socially.",
         tags: ["Flutter", "Social", "Firebase", "BLoC", "REST API"],
      githubUrl: "https://github.com/yourusername/project6",
      liveUrl: "",
      emoji: "💪",
      playStoreUrl: "https://blkem.updatestar.com/en",  // default empty
      appStoreUrl: "https://blkem.updatestar.com/en",   // default empty
    ),
    ProjectItem(
      title: "Atlantis My App",
      description:
        "Atlantis CRM is a mobile CRM application designed to help businesses manage customer interactions, leads, contacts, and sales activities on the go. It provides real-time access to customer data, communication tools, and business processes directly from mobile devices, improving productivity and field force efficiency.",
         tags: ["Flutter", "Dart", "CRM Backend", "BLoC"],
      githubUrl: "https://github.com/yourusername/project6",
      liveUrl: "",
      emoji: "💪",
      playStoreUrl: "https://play.google.com/store/apps/details?id=com.atlantis.crm.app&hl=en_IN",  // default empty
      appStoreUrl: "https://blkem.updatestar.com/en",   // default empty
    ),
  ];
}

// ── Data Models ───────────────────────────
class StatItem {
  final String value;
  final String label;

  const StatItem({required this.value, required this.label});
}

class SkillCategory {
  final String title;
  final String icon;
  final List<String> skills;

  const SkillCategory(
      {required this.title, required this.icon, required this.skills});
}

class ExperienceItem {
  final String company;
  final String role;
  final String duration;
  final String description;
  final List<String> technologies;

  const ExperienceItem({
    required this.company,
    required this.role,
    required this.duration,
    required this.description,
    required this.technologies,
  });
}

class ProjectItem {
  final String title;
  final String description;
  final List<String> tags;
  final String githubUrl;
  final String liveUrl;
  final String emoji;
  final String playStoreUrl;
  final String appStoreUrl;


  const ProjectItem({
    required this.title,
    required this.description,
    required this.tags,
    required this.githubUrl,
    required this.liveUrl,
    required this.emoji,
    required this.playStoreUrl,
    required this.appStoreUrl,
  });
}
