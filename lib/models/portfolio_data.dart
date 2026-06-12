// ─────────────────────────────────────────
//  PORTFOLIO DATA — Replace with your info
// ─────────────────────────────────────────

class PortfolioData {
  // ── Hero ──────────────────────────────
  static const String name = "Sunny Singh";
  static const String profileImage = "assets/images/profile.png";
  static const String tagline = "Flutter Developer";
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
    StatItem(value: "X+", label: "Years Exp"),
    StatItem(value: "20+", label: "Projects"),
    StatItem(value: "10+", label: "Clients"),
    StatItem(value: "5★", label: "Reviews"),
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
      company: "Company Name",
      role: "Senior Flutter Developer",
      duration: "2022 – Present",
      description:
          "Led development of cross-platform mobile apps. Architected scalable solutions "
          "using BLoC pattern and Firebase backend.",
      technologies: ["Flutter", "Firebase", "GetX", "CI/CD"],
    ),
    ExperienceItem(
      company: "Previous Company",
      role: "Flutter Developer",
      duration: "2020 – 2022",
      description:
          "Built and maintained multiple Flutter applications. Integrated REST APIs, "
          "payment gateways, and push notifications.",
      technologies: ["Flutter", "Dart", "REST API", "Firebase"],
    ),
    ExperienceItem(
      company: "Startup / Freelance",
      role: "Mobile Developer",
      duration: "2019 – 2020",
      description:
          "Delivered end-to-end mobile applications for clients across e-commerce "
          "and logistics domains.",
      technologies: ["Flutter", "Node.js", "MongoDB"],
    ),
  ];

  // ── Projects ──────────────────────────
  static const List<ProjectItem> projects = [
    ProjectItem(
      title: "E-Commerce App",
      description:
          "Full-featured shopping app with real-time inventory, cart management, "
          "payment gateway integration, and admin dashboard.",
      tags: ["Flutter", "Firebase", "GetX", "Stripe"],
      githubUrl: "https://github.com/yourusername/project1",
      liveUrl: "",
      emoji: "🛒",
    ),
    ProjectItem(
      title: "Logistics Tracker",
      description:
          "Real-time delivery tracking app with Google Maps SDK, live order updates, "
          "and driver management system.",
      tags: ["Flutter", "Google Maps", "Firebase", "BLoC"],
      githubUrl: "https://github.com/yourusername/project2",
      liveUrl: "",
      emoji: "📦",
    ),
    ProjectItem(
      title: "AI Chat App",
      description:
          "Conversational AI powered mobile app with voice input, chat history, "
          "and multiple AI model support.",
      tags: ["Flutter", "OpenAI API", "Firebase", "Provider"],
      githubUrl: "https://github.com/yourusername/project3",
      liveUrl: "",
      emoji: "🤖",
    ),
    ProjectItem(
      title: "Community Platform",
      description:
          "Social networking app with posts, stories, real-time messaging, "
          "and event management features.",
      tags: ["Flutter", "Supabase", "Riverpod", "Golang"],
      githubUrl: "https://github.com/yourusername/project4",
      liveUrl: "",
      emoji: "👥",
    ),
    ProjectItem(
      title: "Finance Manager",
      description:
          "Personal finance app with budget tracking, expense categorization, "
          "charts, and monthly reports.",
      tags: ["Flutter", "Hive", "fl_chart", "Provider"],
      githubUrl: "https://github.com/yourusername/project5",
      liveUrl: "",
      emoji: "💰",
    ),
    ProjectItem(
      title: "Fitness Tracker",
      description:
          "Workout tracking app with custom exercise builder, progress analytics, "
          "and health integrations.",
      tags: ["Flutter", "HealthKit", "Firebase", "BLoC"],
      githubUrl: "https://github.com/yourusername/project6",
      liveUrl: "",
      emoji: "💪",
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

  const ProjectItem({
    required this.title,
    required this.description,
    required this.tags,
    required this.githubUrl,
    required this.liveUrl,
    required this.emoji,
  });
}
