import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const DeepshikaPortfolioApp());
}

const Color navy = Color(0xFF101426);
const Color background = Color(0xFF151A30);
const Color purple = Color(0xFF9B8CFF);
const Color cyan = Color(0xFF66E3F2);
const Color white = Color(0xFFF4F5FF);
const Color muted = Color(0xFFABB1CC);

class DeepshikaPortfolioApp extends StatelessWidget {
  const DeepshikaPortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sheri Deepshika | Portfolio',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: navy,
        colorScheme: ColorScheme.fromSeed(
          seedColor: purple,
          brightness: Brightness.dark,
        ),
        fontFamily: 'Roboto',
      ),
      home: const PortfolioPage(),
    );
  }
}

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key});

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage>
    with TickerProviderStateMixin {
  late AnimationController _entranceController;
  late AnimationController _floatingController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  final ScrollController _scrollController = ScrollController();

  final GlobalKey homeKey = GlobalKey();
  final GlobalKey aboutKey = GlobalKey();
  final GlobalKey projectsKey = GlobalKey();
  final GlobalKey skillsKey = GlobalKey();
  final GlobalKey educationKey = GlobalKey();
  final GlobalKey achievementsKey = GlobalKey();
  final GlobalKey contactKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );

    _floatingController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);

    _fadeAnimation = CurvedAnimation(
      parent: _entranceController,
      curve: Curves.easeInOut,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.12),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _entranceController,
        curve: Curves.easeOutCubic,
      ),
    );

    Timer(const Duration(milliseconds: 150), () {
      if (mounted) _entranceController.forward();
    });
  }

  @override
  void dispose() {
    _entranceController.dispose();
    _floatingController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void goTo(GlobalKey key) {
    final context = key.currentContext;
    if (context == null) return;

    Scrollable.ensureVisible(
      context,
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeInOutCubic,
      alignment: 0.04,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: CustomPaint(
              painter: BackgroundPainter(),
            ),
          ),
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                _navigation(),
                _hero(),
                _about(),
                _projects(),
                _skills(),
                _education(),
                _certifications(),
                _achievements(),
                _contact(),
                _footer(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _navigation() {
    return Container(
      key: homeKey,
      padding: const EdgeInsets.symmetric(
        horizontal: 28,
        vertical: 18,
      ),
      decoration: BoxDecoration(
        color: navy.withValues(alpha: 0.92),
        border: const Border(
          bottom: BorderSide(
            color: Color(0xFF292E4B),
          ),
        ),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1150),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final compact = constraints.maxWidth < 700;

              return Row(
                children: [
                  const Icon(
                    Icons.auto_awesome,
                    color: purple,
                    size: 25,
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'deepshika.dev',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                      color: white,
                    ),
                  ),
                  const Spacer(),
                  if (!compact)
                    Wrap(
                      spacing: 4,
                      children: [
                        _navButton('About', aboutKey),
                        _navButton('Projects', projectsKey),
                        _navButton('Skills', skillsKey),
                        _navButton('Education', educationKey),
                        _navButton('Contact', contactKey),
                      ],
                    )
                  else
                    PopupMenuButton<String>(
                      icon: const Icon(
                        Icons.menu_rounded,
                        color: white,
                      ),
                      color: background,
                      onSelected: (value) {
                        final destinations = {
                          'About': aboutKey,
                          'Projects': projectsKey,
                          'Skills': skillsKey,
                          'Education': educationKey,
                          'Achievements': achievementsKey,
                          'Contact': contactKey,
                        };
                        goTo(destinations[value]!);
                      },
                      itemBuilder: (context) => [
                        'About',
                        'Projects',
                        'Skills',
                        'Education',
                        'Achievements',
                        'Contact',
                      ].map((item) {
                        return PopupMenuItem(
                          value: item,
                          child: Text(item),
                        );
                      }).toList(),
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _navButton(String label, GlobalKey destination) {
    return TextButton(
      onPressed: () => goTo(destination),
      child: Text(
        label,
        style: const TextStyle(
          color: muted,
          fontSize: 13,
        ),
      ),
    );
  }

  Widget _hero() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 28,
        vertical: 75,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final wide = constraints.maxWidth > 720;

                  final intro = Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 9,
                        ),
                        decoration: BoxDecoration(
                          color: purple.withValues(alpha: 0.10),
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            color: purple.withValues(alpha: 0.45),
                          ),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.circle,
                              color: cyan,
                              size: 8,
                            ),
                            SizedBox(width: 9),
                            Text(
                              'CS UNDERGRADUATE  •  AI & SOFTWARE',
                              style: TextStyle(
                                color: purple,
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                      const Text(
                        'Hello, I am',
                        style: TextStyle(
                          color: muted,
                          fontSize: 22,
                        ),
                      ),
                      const SizedBox(height: 7),
                      const Text(
                        'Sheri\nDeepshika.',
                        style: TextStyle(
                          fontSize: 65,
                          height: 1.08,
                          fontWeight: FontWeight.w900,
                          letterSpacing: -2,
                          color: white,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Building intelligent systems that solve\n'
                        'real-world problems.',
                        style: TextStyle(
                          color: purple,
                          fontSize: 21,
                          height: 1.55,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 18),
                      const Text(
                        'Computer Science undergraduate passionate about '
                        'machine learning, mathematical problem solving, '
                        'backend systems and AI-driven applications.',
                        style: TextStyle(
                          color: muted,
                          fontSize: 15,
                          height: 1.9,
                        ),
                      ),
                      const SizedBox(height: 30),
                      Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () => goTo(projectsKey),
                            icon: const Icon(
                              Icons.arrow_forward_rounded,
                              size: 18,
                            ),
                            label: const Text('Explore My Work'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: purple,
                              foregroundColor: navy,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 22,
                                vertical: 17,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                          OutlinedButton.icon(
                            onPressed: () => goTo(contactKey),
                            icon: const Icon(Icons.mail_outline),
                            label: const Text('Get in Touch'),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: white,
                              side: const BorderSide(
                                color: Color(0xFF454B6D),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 17,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 28),
                      Wrap(
                        spacing: 20,
                        runSpacing: 12,
                        children: [
                          _socialLink(
                            'GitHub',
                            'github.com/Deepshikareddy30',
                            'https://github.com/Deepshikareddy30',
                          ),
                          _socialLink(
                            'LinkedIn',
                            'deepshikareddy30',
                            'https://www.linkedin.com/in/deepshikareddy30',
                          ),
                        ],
                      ),
                    ],
                  );

                  final visual = AnimatedBuilder(
                    animation: _floatingController,
                    builder: (context, child) {
                      final offset =
                          8 * _floatingController.value;

                      return Transform.translate(
                        offset: Offset(0, -offset),
                        child: child,
                      );
                    },
                    child: _heroVisual(),
                  );

                  if (wide) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(flex: 6, child: intro),
                        const SizedBox(width: 45),
                        Expanded(flex: 4, child: visual),
                      ],
                    );
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      intro,
                      const SizedBox(height: 55),
                      Center(child: visual),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _heroVisual() {
    return Container(
      constraints: const BoxConstraints(maxWidth: 390),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF222744),
            Color(0xFF181D35),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(26),
        border: Border.all(
          color: purple.withValues(alpha: 0.4),
        ),
        boxShadow: [
          BoxShadow(
            color: purple.withValues(alpha: 0.10),
            blurRadius: 45,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              _windowDot(const Color(0xFFFF6B81)),
              _windowDot(const Color(0xFFFFC857)),
              _windowDot(const Color(0xFF59D9A5)),
              const Spacer(),
              const Text(
                'AI_LAB.py',
                style: TextStyle(
                  color: muted,
                  fontSize: 12,
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
          const SizedBox(height: 28),
          Container(
            height: 155,
            width: 155,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: [purple, cyan],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: purple.withValues(alpha: 0.30),
                  blurRadius: 35,
                ),
              ],
            ),
            child: const Icon(
              Icons.psychology_alt_rounded,
              color: navy,
              size: 85,
            ),
          ),
          const SizedBox(height: 25),
          const Text(
            'THINK  •  BUILD  •  INNOVATE',
            style: TextStyle(
              color: cyan,
              fontSize: 11,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 24),
          _codeLine('agent = AIEngineer()', purple),
          _codeLine('agent.learn()', cyan),
          _codeLine('agent.build(solution)', white),
          const SizedBox(height: 22),
          const Divider(color: Color(0xFF353B5C)),
          const SizedBox(height: 15),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _MiniStat(value: '3', label: 'Projects'),
              _MiniStat(value: '9.16', label: 'CGPA'),
              _MiniStat(value: 'AI', label: 'Focus'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _windowDot(Color color) {
    return Container(
      margin: const EdgeInsets.only(right: 6),
      width: 9,
      height: 9,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _codeLine(String text, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          const Text(
            '›  ',
            style: TextStyle(
              color: purple,
              fontSize: 17,
              fontFamily: 'monospace',
            ),
          ),
          Text(
            text,
            style: TextStyle(
              color: color,
              fontSize: 13,
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
    );
  }

  Widget _socialLink(String title, String subtitle, String url) {
    return InkWell(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Open $url in your browser.'),
            duration: const Duration(seconds: 2),
          ),
        );
      },
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              title == 'GitHub' ? Icons.code : Icons.work_outline,
              color: cyan,
              size: 18,
            ),
            const SizedBox(width: 9),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: muted,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _section({
    required GlobalKey key,
    required String eyebrow,
    required String title,
    required Widget child,
  }) {
    return Container(
      key: key,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 28,
        vertical: 65,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1050),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                eyebrow.toUpperCase(),
                style: const TextStyle(
                  color: cyan,
                  fontSize: 11,
                  letterSpacing: 2,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: const TextStyle(
                  color: white,
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.7,
                ),
              ),
              const SizedBox(height: 28),
              child,
            ],
          ),
        ),
      ),
    );
  }

  Widget _about() {
    return _section(
      key: aboutKey,
      eyebrow: 'Who I Am',
      title: 'Curious by nature. Builder by choice.',
      child: LayoutBuilder(
        builder: (context, constraints) {
          final wide = constraints.maxWidth > 700;

          final description = const Text(
            'I am a Computer Science and Engineering undergraduate at '
            'BVRIT Hyderabad College of Engineering for Women. I enjoy '
            'combining analytical thinking with software engineering to '
            'build intelligent, practical applications.\n\n'
            'My interests include machine learning, large language models, '
            'retrieval-augmented generation, backend development, and '
            'reliable AI systems. I am particularly interested in making '
            'AI applications more useful, transparent, and dependable.',
            style: TextStyle(
              color: muted,
              fontSize: 15,
              height: 2,
            ),
          );

          final highlights = Column(
            children: [
              _highlight(
                Icons.psychology_outlined,
                'AI & Machine Learning',
                'LLMs, RAG, LangGraph and intelligent agents.',
              ),
              const SizedBox(height: 14),
              _highlight(
                Icons.storage_rounded,
                'Backend Engineering',
                'Python, FastAPI, APIs and data pipelines.',
              ),
              const SizedBox(height: 14),
              _highlight(
                Icons.verified_user_outlined,
                'Responsible AI',
                'Human oversight, explainability and auditability.',
              ),
            ],
          );

          if (wide) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 6, child: description),
                const SizedBox(width: 45),
                Expanded(flex: 5, child: highlights),
              ],
            );
          }

          return Column(
            children: [
              description,
              const SizedBox(height: 25),
              highlights,
            ],
          );
        },
      ),
    );
  }

  Widget _highlight(IconData icon, String title, String subtitle) {
    return _card(
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(13),
            decoration: BoxDecoration(
              color: purple.withValues(alpha: 0.13),
              borderRadius: BorderRadius.circular(13),
            ),
            child: Icon(
              icon,
              color: purple,
              size: 25,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: muted,
                    height: 1.6,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _projects() {
    final projectData = [
      {
        'number': '01',
        'title': 'AP Invoice & Contract Exception Agent',
        'category': 'AGENTIC AI  •  RAG',
        'description':
            'An autonomous accounts-payable agent that auto-approves '
                'clean invoices and flags exceptions with quantified variance.',
        'details':
            'Built a contract-RAG pipeline using ChromaDB to validate '
                'invoice pricing against purchase orders and vendor contract '
                'terms. Added injection resistance, human approval gates, '
                'and field-level audit trails.',
        'tech': 'Python  •  LangGraph  •  Pydantic  •  ChromaDB  •  Streamlit',
      },
      {
        'number': '02',
        'title': 'HireScope',
        'category': 'GENERATIVE AI  •  INTERVIEW TECH',
        'description':
            'An AI-powered interview simulation platform for resume, '
                'technical, and HR interview practice.',
        'details':
            'Developed an LLM-driven resume analysis pipeline that extracts '
                'candidate skills, generates personalized questions, and '
                'provides contextual follow-ups. Integrated answer evaluation, '
                'performance scoring, and structured feedback.',
        'tech': 'FastAPI  •  Python  •  JavaScript  •  HTML  •  CSS  •  Groq API',
      },
      {
        'number': '03',
        'title': 'TrustLensAI',
        'category': 'EXPLAINABLE AI  •  PROTOTYPING',
        'description':
            'An explainable AI prototype for enterprise incident management '
                'with human-in-the-loop decision support.',
        'details':
            'Designed Trust Ledger, Decision Courtroom, approval workflows, '
                'and audit logging to improve transparency of AI-assisted '
                'decisions. Built interactive prototypes demonstrating '
                'evidence attribution and trust calibration.',
        'tech': 'HTML  •  CSS  •  JavaScript  •  Figma',
      },
    ];

    return _section(
      key: projectsKey,
      eyebrow: 'Selected Work',
      title: 'Projects that solve problems.',
      child: Column(
        children: projectData.asMap().entries.map((entry) {
          final index = entry.key;
          final project = entry.value;

          return _AnimatedProjectCard(
            index: index,
            project: project,
          );
        }).toList(),
      ),
    );
  }

  Widget _skills() {
    final skillData = [
      {
        'icon': '01',
        'title': 'Programming Languages',
        'skills': ['Java', 'Python', 'C', 'SQL', 'HTML', 'CSS'],
      },
      {
        'icon': '02',
        'title': 'Core Computer Science',
        'skills': [
          'Data Structures & Algorithms',
          'OOP',
          'DBMS',
          'Operating Systems',
        ],
      },
      {
        'icon': '03',
        'title': 'AI & LLMs',
        'skills': [
          'Prompt Engineering',
          'Large Language Models',
          'LangGraph',
          'RAG',
        ],
      },
      {
        'icon': '04',
        'title': 'Tools & Frameworks',
        'skills': [
          'FastAPI',
          'Streamlit',
          'ChromaDB',
          'Pydantic',
          'Git',
          'GitHub',
          'VS Code',
          'Java Swing',
        ],
      },
    ];

    return _section(
      key: skillsKey,
      eyebrow: 'Technical Toolkit',
      title: 'Skills I work with.',
      child: LayoutBuilder(
        builder: (context, constraints) {
          final columns = constraints.maxWidth > 750 ? 2 : 1;
          final width =
              (constraints.maxWidth - (columns - 1) * 18) / columns;

          return Wrap(
            spacing: 18,
            runSpacing: 18,
            children: skillData.map((category) {
              return SizedBox(
                width: width,
                child: _card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            category['icon'] as String,
                            style: const TextStyle(
                              color: purple,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              category['title'] as String,
                              style: const TextStyle(
                                color: white,
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Wrap(
                        spacing: 8,
                        runSpacing: 10,
                        children:
                            (category['skills'] as List<String>).map((skill) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 11,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFF282D49),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: const Color(0xFF373D5D),
                              ),
                            ),
                            child: Text(
                              skill,
                              style: const TextStyle(
                                color: Color(0xFFD9DDF1),
                                fontSize: 12,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }

  Widget _education() {
    final educationData = [
      {
        'year': '2024 – 2028',
        'degree': 'Bachelor of Technology',
        'course': 'Computer Science and Engineering',
        'college':
            'BVRIT Hyderabad College of Engineering for Women, Hyderabad',
        'score': '9.16 CGPA',
      },
      {
        'year': '2022 – 2024',
        'degree': 'Intermediate Public Examination',
        'course': 'MPC',
        'college': 'Sri Chaitanya Junior College, Hyderabad',
        'score': '98.6%',
      },
      {
        'year': '2022',
        'degree': 'Secondary Education',
        'course': 'School Education',
        'college': 'Montessori High School, Mahabubabad',
        'score': '9.8 CGPA',
      },
    ];

    return _section(
      key: educationKey,
      eyebrow: 'Academic Journey',
      title: 'Education.',
      child: Column(
        children: educationData.map((education) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: _card(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 46,
                    width: 46,
                    decoration: BoxDecoration(
                      color: purple.withValues(alpha: 0.13),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.school_outlined,
                      color: purple,
                    ),
                  ),
                  const SizedBox(width: 17),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          education['year']!,
                          style: const TextStyle(
                            color: cyan,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          education['degree']!,
                          style: const TextStyle(
                            color: white,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          education['course']!,
                          style: const TextStyle(
                            color: purple,
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          education['college']!,
                          style: const TextStyle(
                            color: muted,
                            fontSize: 13,
                            height: 1.6,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          education['score']!,
                          style: const TextStyle(
                            color: cyan,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _certifications() {
    final items = [
      {
        'title': 'Google Cloud Skills Boost',
        'description':
            'Introduction to Generative AI, LLMs, Responsible AI and Applying AI Principles',
        'year': '2026',
      },
      {
        'title': 'CodeChef',
        'description': 'Java, OOP & Data Structures',
        'year': '2025',
      },
      {
        'title': 'Infosys Springboard',
        'description': 'HTML, CSS3 & JavaScript',
        'year': '2026',
      },
    ];

    return _section(
      key: GlobalKey(),
      eyebrow: 'Continuous Learning',
      title: 'Certifications.',
      child: LayoutBuilder(
        builder: (context, constraints) {
          final columns = constraints.maxWidth > 750 ? 3 : 1;
          final width =
              (constraints.maxWidth - (columns - 1) * 16) / columns;

          return Wrap(
            spacing: 16,
            runSpacing: 16,
            children: items.map((item) {
              return SizedBox(
                width: width,
                child: _card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.workspace_premium_outlined,
                        color: cyan,
                        size: 30,
                      ),
                      const SizedBox(height: 18),
                      Text(
                        item['title']!,
                        style: const TextStyle(
                          color: white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        item['description']!,
                        style: const TextStyle(
                          color: muted,
                          fontSize: 13,
                          height: 1.7,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        item['year']!,
                        style: const TextStyle(
                          color: purple,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }

  Widget _achievements() {
    return _section(
      key: achievementsKey,
      eyebrow: 'Beyond Academics',
      title: 'Achievements & Leadership.',
      child: Column(
        children: [
          _achievement(
            Icons.groups_rounded,
            'Class Representative',
            'BVRIT Hyderabad College of Engineering for Women',
            '2024 – Present',
          ),
          const SizedBox(height: 15),
          _achievement(
            Icons.emoji_events_outlined,
            'BITS Pilani Hackathon',
            'Participated in the hackathon and explored collaborative problem-solving.',
            '2025',
          ),
        ],
      ),
    );
  }

  Widget _achievement(
    IconData icon,
    String title,
    String description,
    String date,
  ) {
    return _card(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: purple,
            size: 30,
          ),
          const SizedBox(width: 17),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 7),
                Text(
                  description,
                  style: const TextStyle(
                    color: muted,
                    height: 1.7,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 9),
                Text(
                  date,
                  style: const TextStyle(
                    color: cyan,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _contact() {
    return Container(
      key: contactKey,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 28,
        vertical: 75,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 850),
          child: Container(
            padding: const EdgeInsets.all(35),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color(0xFF252B4B),
                  Color(0xFF1B203B),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: purple.withValues(alpha: 0.4),
              ),
            ),
            child: Column(
              children: [
                const Icon(
                  Icons.waving_hand_rounded,
                  color: cyan,
                  size: 42,
                ),
                const SizedBox(height: 22),
                const Text(
                  'Let’s build something meaningful.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: white,
                    fontSize: 31,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 14),
                const Text(
                  'Interested in AI, software engineering, or collaborating '
                  'on an interesting idea? Let’s connect.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: muted,
                    fontSize: 14,
                    height: 1.8,
                  ),
                ),
                const SizedBox(height: 28),
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    _contactButton(
                      Icons.email_outlined,
                      'Email Me',
                      '24wh1a0571@bvrithyderabad.edu.in',
                    ),
                    _contactButton(
                      Icons.code,
                      'GitHub',
                      'https://github.com/Deepshikareddy30',
                    ),
                    _contactButton(
                      Icons.work_outline,
                      'LinkedIn',
                      'https://www.linkedin.com/in/deepshikareddy30',
                    ),
                  ],
                ),
                const SizedBox(height: 25),
                const Text(
                  '+91 9063605907',
                  style: TextStyle(
                    color: cyan,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _contactButton(
    IconData icon,
    String label,
    String destination,
  ) {
    return OutlinedButton.icon(
      onPressed: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Open $destination in your browser or email app.'),
            duration: const Duration(seconds: 2),
          ),
        );
      },
      icon: Icon(icon, size: 17),
      label: Text(label),
      style: OutlinedButton.styleFrom(
        foregroundColor: white,
        side: const BorderSide(
          color: Color(0xFF535B80),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 16,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(11),
        ),
      ),
    );
  }

  Widget _footer() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Color(0xFF292E4B),
          ),
        ),
      ),
      child: const Column(
        children: [
          Text(
            'SHERI DEEPSHIKA',
            style: TextStyle(
              color: white,
              fontSize: 13,
              letterSpacing: 2,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Designed with Flutter  •  Built with curiosity',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: muted,
              fontSize: 12,
            ),
          ),
          SizedBox(height: 8),
          Text(
            '© 2026 Sheri Deepshika',
            style: TextStyle(
              color: Color(0xFF747C9F),
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }

  Widget _card({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(23),
      decoration: BoxDecoration(
        color: const Color(0xFF1B203A).withValues(alpha: 0.94),
        borderRadius: BorderRadius.circular(17),
        border: Border.all(
          color: const Color(0xFF303654),
        ),
      ),
      child: child,
    );
  }
}

class _MiniStat extends StatelessWidget {
  final String value;
  final String label;

  const _MiniStat({
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: white,
            fontSize: 23,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          label,
          style: const TextStyle(
            color: muted,
            fontSize: 11,
          ),
        ),
      ],
    );
  }
}

class _AnimatedProjectCard extends StatefulWidget {
  final int index;
  final Map<String, String> project;

  const _AnimatedProjectCard({
    required this.index,
    required this.project,
  });

  @override
  State<_AnimatedProjectCard> createState() =>
      _AnimatedProjectCardState();
}

class _AnimatedProjectCardState extends State<_AnimatedProjectCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  bool _hovering = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    );

    Future.delayed(
      Duration(milliseconds: 180 * widget.index),
      () {
        if (mounted) _controller.forward();
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.14),
          end: Offset.zero,
        ).animate(_animation),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 18),
          child: MouseRegion(
            onEnter: (_) => setState(() => _hovering = true),
            onExit: (_) => setState(() => _hovering = false),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              curve: Curves.easeOut,
              transform: Matrix4.translationValues(
                0,
                _hovering ? -5 : 0,
                0,
              ),
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: const Color(0xFF1B203A),
                borderRadius: BorderRadius.circular(19),
                border: Border.all(
                  color: _hovering
                      ? purple.withValues(alpha: 0.75)
                      : const Color(0xFF303654),
                ),
                boxShadow: [
                  if (_hovering)
                    BoxShadow(
                      color: purple.withValues(alpha: 0.10),
                      blurRadius: 28,
                      spreadRadius: 1,
                    ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        widget.project['number']!,
                        style: const TextStyle(
                          color: purple,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      const Icon(
                        Icons.north_east_rounded,
                        color: cyan,
                        size: 23,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    widget.project['category']!,
                    style: const TextStyle(
                      color: cyan,
                      fontSize: 10,
                      letterSpacing: 1.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.project['title']!,
                    style: const TextStyle(
                      color: white,
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    widget.project['description']!,
                    style: const TextStyle(
                      color: muted,
                      fontSize: 14,
                      height: 1.8,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    widget.project['details']!,
                    style: const TextStyle(
                      color: Color(0xFF929AB9),
                      fontSize: 13,
                      height: 1.8,
                    ),
                  ),
                  const SizedBox(height: 22),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(13),
                    decoration: BoxDecoration(
                      color: navy,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      widget.project['tech']!,
                      style: const TextStyle(
                        color: purple,
                        fontSize: 12,
                        height: 1.8,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class BackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF252B4A).withValues(alpha: 0.36)
      ..strokeWidth = 1;

    const spacing = 48.0;

    for (double x = 0; x < size.width; x += spacing) {
      for (double y = 0; y < size.height; y += spacing) {
        canvas.drawCircle(
          Offset(x, y),
          1,
          paint,
        );
      }
    }

    final glowPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          purple.withValues(alpha: 0.11),
          purple.withValues(alpha: 0.0),
        ],
      ).createShader(
        Rect.fromCircle(
          center: Offset(size.width * 0.85, size.height * 0.10),
          radius: 350,
        ),
      );

    canvas.drawCircle(
      Offset(size.width * 0.85, size.height * 0.10),
      350,
      glowPaint,
    );

    final secondGlow = Paint()
      ..shader = RadialGradient(
        colors: [
          cyan.withValues(alpha: 0.055),
          cyan.withValues(alpha: 0.0),
        ],
      ).createShader(
        Rect.fromCircle(
          center: Offset(size.width * 0.08, size.height * 0.48),
          radius: 300,
        ),
      );

    canvas.drawCircle(
      Offset(size.width * 0.08, size.height * 0.48),
      300,
      secondGlow,
    );
  }

  @override
  bool shouldRepaint(covariant BackgroundPainter oldDelegate) => false;
}