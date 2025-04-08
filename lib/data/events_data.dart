import 'package:get/get_rx/src/rx_types/rx_types.dart';

class Event {
  final int id;
  final String title;
  final String location;
  final String details;
  final int participants;
  RxInt availableSpots; // Cambiado a RxInt para ser reactivo y mutable
  final String date;
  final String path;
  final String type;
  final RxBool isJoined; // Nuevo atributo

  Event({
    required this.id,
    required this.title,
    required this.location,
    required this.details,
    required int availableSpots, // Cambiado a int para inicialización
    required this.participants,
    required this.date,
    required this.path,
    required this.type,
    required bool isJoined,
  })  : availableSpots = RxInt(availableSpots),
        isJoined = RxBool(isJoined); // Inicializado como RxInt
}

List<Event> eventsList = [
// UNBOUND ------------------------------------------------------------------------------
  Event(
      id: 1,
      title: "The Things We Wish We’d Learned Sooner",
      location: "Reflection Room",
      details:
          "Why is it so hard to talk about intimacy, desire, or even basic information about our bodies? This session opens up a safe space to explore what we’re rarely taught — about respect, boundaries, pleasure, and honest communication.",
      participants: 40,
      availableSpots: 18,
      date: "April 27, 2025, 11:00 AM",
      path: "lib/assets/unbound01.jpeg",
      type: "Unbound",
      isJoined: false),
  Event(
      id: 2,
      title: "Consent Isn’t Just a Word: Rethinking Connection",
      location: "Youth Circle Room",
      details:
          "More than a rule — consent is about understanding, respect, and presence. This workshop invites us to reflect on the messages we’ve received (or not) and how to build healthier dynamics through active listening and mutual care.",
      participants: 50,
      availableSpots: 27,
      date: "April 27, 2025, 3:00 PM",
      path: "lib/assets/unbound02.png",
      type: "Unbound",
      isJoined: false),
  Event(
      id: 3,
      title: "Breaking the Ice: Naming the Unspoken Around Sex",
      location: "Open Dialogue Space",
      details:
          "A session for those who’ve ever felt confused, curious, or uncomfortable asking questions. We’ll talk about the cultural silence around sex, how it affects our relationships and self-esteem, and how to unlearn fear with empathy and facts.",
      participants: 45,
      availableSpots: 12,
      date: "April 4, 2025, 10:00 AM",// PRUEBA PARA PAST EVENTS 
      path: "lib/assets/unbound03.jpg",
      type: "Unbound",
      isJoined: false),
  Event(
      id: 4,
      title: "Gender, Body & Desire: Finding Your Own Voice",
      location: "Identity Room",
      details:
          "Exploring how social expectations around gender and sexuality influence how we see ourselves and others. This is a space to reflect on identity, pressure, freedom, and what it means to connect in ways that are truly our own.",
      participants: 50,
      availableSpots: 20,
      date: "April 1, 2025, 1:00 PM",// PRUEBA PARA PAST EVENTS
      path: "lib/assets/unbound04.jpg",
      type: "Unbound",
      isJoined: false),

// SEXED ----------------------------------------------------------------------------------
  Event(
      id: 5,
      title: "Pleasure is Political: Redefining Sex Ed",
      location: "Liberation Hall",
      details:
          "A participatory talk on how pleasure can be the core of a feminist, critical, and non-patriarchal approach to sex education.",
      participants: 65,
      availableSpots: 20,
      date: "April 25, 2025, 11:00 AM",
      path: "lib/assets/education01.png",
      type: "education",
      isJoined: false),
  Event(
      id: 6,
      title: "Consent Beyond 'Yes' and 'No'",
      location: "Empathy Studio",
      details:
          "An experiential workshop on consent through body awareness, mutual desire, and the power of authentic communication.",
      participants: 50,
      availableSpots: 15,
      date: "April 25, 2025, 3:00 PM",
      path: "lib/assets/education02.png",
      type: "education",
      isJoined: false),
  Event(
      id: 7,
      title: "Erotic Anatomy: Knowing Ourselves Deeply",
      location: "Body Wisdom Room",
      details:
          "We explore the anatomy of pleasure with an inclusive lens, debunking myths and incorporating intersectional knowledge.",
      participants: 55,
      availableSpots: 10,
      date: "April 26, 2025, 9:00 AM",
      path: "lib/assets/education03.jpg",
      type: "education",
      isJoined: false),
  Event(
      id: 8,
      title: "Sexuality Across the Lifespan",
      location: "Continuum Space",
      details:
          "A conversation about desire, relationships, and the evolving nature of sexuality from childhood to old age, with a caring and sensitive approach.",
      participants: 40,
      availableSpots: 8,
      date: "April 26, 2025, 1:00 PM",
      path: "lib/assets/education04.png",
      type: "education",
      isJoined: false),
  Event(
      id: 9,
      title: "Pleasure and Disability",
      location: "Accessible Love Room",
      details:
          "A workshop to highlight and celebrate pleasure in diverse bodies, breaking away from sexual ableism.",
      participants: 35,
      availableSpots: 5,
      date: "April 27, 2025, 10:00 AM",
      path: "lib/assets/education05.jpg",
      type: "education",
      isJoined: false),
  Event(
      id: 10,
      title: "Tools for Talking About Sex With Kids and Teens",
      location: "Circle of Care",
      details:
          "A space for parents, caregivers, and educators to explore how to foster open and honest conversations about sexuality from an early age.",
      participants: 45,
      availableSpots: 12,
      date: "April 27, 2025, 2:00 PM",
      path: "lib/assets/education06.webp",
      type: "education",
      isJoined: false),

  //BODY LITERACY

  Event(
      id: 11,
      title: "Getting to Know My Body Without Judgment",
      location: "Quiet Room",
      details:
          "A gathering to explore how we inhabit our bodies, dismantle myths, and encourage self-care.",
      participants: 20,
      availableSpots: 4,
      date: "May 10, 2025, 3:00 PM",
      path: "lib/assets/bodyliteracy01.jpg",
      type: "bodyliteracy",
      isJoined: false),
  Event(
      id: 12,
      title: "How to Talk About What I Feel",
      location: "Circle Space",
      details:
          "A workshop to practice expressing emotions and needs in intimate relationships with clarity and respect.",
      participants: 25,
      availableSpots: 6,
      date: "May 11, 2025, 5:30 PM",
      path: "lib/assets/bodyliteracy02.jpg",
      type: "bodyliteracy",
      isJoined: false),
  Event(
      id: 13,
      title: "Languages of Affection and Care",
      location: "Blue Room",
      details:
          "We explore how we give and receive care. A workshop centered on respect, boundaries, and honest communication.",
      participants: 22,
      availableSpots: 2,
      date: "May 12, 2025, 4:00 PM",
      path: "lib/assets/bodyliteracy03.jpg",
      type: "bodyliteracy",
      isJoined: false),
  Event(
      id: 14,
      title: "Intimacy Is Also Learned",
      location: "Inner Garden",
      details:
          "Guided conversations about sexuality, the body, and relationships from an educational and listening-based approach.",
      participants: 18,
      availableSpots: 5,
      date: "May 13, 2025, 6:00 PM",
      path: "lib/assets/bodyliteracy04.png",
      type: "bodyliteracy",
      isJoined: false),

  // CULTURE

  Event(
      id: 15,
      title: "A History of Desire: From Taboos to Liberation",
      location: "Heritage Hall",
      details:
          "Trace how societies across time have regulated desire, from repression to revolutions in sexual freedom.",
      participants: 70,
      availableSpots: 32,
      date: "April 26, 2025, 11:00 AM",
      path: "lib/assets/culture01.jpg",
      type: "culture",
      isJoined: false),
  Event(
      id: 16,
      title: "Colonialism, Gender, and the Body",
      location: "Decolonial Room",
      details:
          "Analyze how colonial power reshaped bodily autonomy, gender roles, and sexual expression — and paths to reclaim them.",
      participants: 50,
      availableSpots: 18,
      date: "April 26, 2025, 2:00 PM",
      path: "lib/assets/culture02.jpg",
      type: "culture",
      isJoined: false),
  Event(
      id: 17,
      title: "Spirituality and Sensuality Across Cultures",
      location: "Sacred Space",
      details:
          "Dive into diverse spiritual traditions that embrace or reject sensuality, exploring sacred paths of embodied connection.",
      participants: 40,
      availableSpots: 9,
      date: "April 26, 2025, 4:00 PM",
      path: "lib/assets/culture03.jpg",
      type: "culture",
      isJoined: false),
  Event(
      id: 18,
      title: "Erotic Myths and Ancient Rituals",
      location: "Temple Room",
      details:
          "Discover how myths and rituals from ancient cultures encoded sacred sexuality and archetypes of desire.",
      participants: 60,
      availableSpots: 27,
      date: "April 27, 2025, 11:00 AM",
      path: "lib/assets/culture04.jpg",
      type: "culture",
      isJoined: false),
  Event(
      id: 19,
      title: "Media, Pleasure, and Representation",
      location: "Cinema Hall",
      details:
          "How has pleasure been portrayed in film and media? Critical look at stereotypes and resistance through representation.",
      participants: 50,
      availableSpots: 10,
      date: "April 27, 2025, 2:00 PM",
      path: "lib/assets/culture05.jpg",
      type: "culture",
      isJoined: false),

  // CYBERTOUCH
  Event(
      id: 20,
      title: "Swipe Culture: Dating in the Digital Age",
      location: "Tech Lounge A",
      details:
          "From Tinder to Bumble, dating apps have transformed how we connect. This talk explores how technology shapes desire, expectations, and emotional labor in modern relationships. We’ll discuss the psychological effects of swipe culture and how to build healthier digital connections.",
      participants: 70,
      availableSpots: 25,
      date: "April 27, 2025, 10:00 AM",
      path: "lib/assets/cybertouch01.png",
      type: "Cybertouch",
      isJoined: false),

  Event(
      id: 21,
      title: "Consent in the Age of Screens",
      location: "Ethics Room C",
      details:
          "Digital spaces require new forms of consent. This session tackles the complexities of sharing images, sexting, and digital boundaries. We’ll unpack real-world cases and provide strategies for respectful, consensual digital intimacy.",
      participants: 60,
      availableSpots: 22,
      date: "April 27, 2025, 11:30 AM",
      path: "lib/assets/cybertouch02.png",
      type: "Cybertouch",
      isJoined: false),

  Event(
      id: 22,
      title: "Emotional Safety in Online Relationships",
      location: "Connection Hub",
      details:
          "Online relationships can foster closeness—but also risk manipulation, ghosting, or emotional abuse. This session explores how to recognize red flags, establish healthy communication, and prioritize well-being when navigating romantic and sexual relationships online.",
      participants: 50,
      availableSpots: 16,
      date: "April 27, 2025, 1:00 PM",
      path: "lib/assets/cybertouch03.jpg",
      type: "Cybertouch",
      isJoined: false),

  Event(
      id: 23,
      title: "Nudes and Trust: Ethics of Sexting",
      location: "Media Room B",
      details:
          "Sexting can be empowering or risky, depending on context. We’ll explore the ethical implications of sharing intimate content, what consent looks like in these exchanges, and how digital trust is built or broken.",
      participants: 45,
      availableSpots: 12,
      date: "April 27, 2025, 3:00 PM",
      path: "lib/assets/cybertouch04.png",
      type: "Cybertouch",
      isJoined: false),

  Event(
      id: 24,
      title: "Catfishing, Scams, and Digital Vulnerability",
      location: "Cybersecurity Hall",
      details:
          "What happens when online trust is exploited? This session examines catfishing, financial scams, and other forms of deception in digital relationships. Through real cases and expert input, we’ll explore prevention, resilience, and recovery.",
      participants: 60,
      availableSpots: 28,
      date: "April 28, 2025, 12:00 PM",
      path: "lib/assets/cybertouch06.png",
      type: "Cybertouch",
      isJoined: false),
  Event(
      id: 25,
      title: "Your Digital Footprint and Intimate Privacy",
      location: "Privacy Lab",
      details:
          "Our phones hold intimate details of our lives. This session investigates how metadata, cloud storage, and social media affect personal privacy. We’ll provide tips for safeguarding sensitive content and understanding digital risks in our connected world.",
      participants: 50,
      availableSpots: 19,
      date: "April 28, 2025, 2:00 PM",
      path: "lib/assets/cybertouch07.jpeg",
      type: "Cybertouch",
      isJoined: false),

  // GENDER IDENTITY
  Event(
      id: 26,
      title: "Understanding the Gender Spectrum",
      location: "Diversity Hall A",
      details:
          "Exploring gender diversity, including non-binary, genderqueer, and agender identities...",
      participants: 70,
      availableSpots: 28,
      date: "April 22, 2025, 9:00 AM",
      path: "lib/assets/identity01.png",
      type: "Identity",
      isJoined: false),
  Event(
      id: 27,
      title: "Trans and Non-Binary Healthcare Access",
      location: "Equality Room B",
      details:
          "Exploring the unique healthcare needs of transgender and non-binary individuals...",
      participants: 50,
      availableSpots: 21,
      date: "April 22, 2025, 11:00 AM",
      path: "lib/assets/identity02.png",
      type: "Identity",
      isJoined: false),
  Event(
      id: 28,
      title: "Gender Expression in Media and Art",
      location: "Art Lab Studio",
      details:
          "Exploring how gender expression is represented in visual art, performance, and film...",
      participants: 40,
      availableSpots: 18,
      date: "April 22, 2025, 2:00 PM",
      path: "lib/assets/identity03.png",
      type: "Identity",
      isJoined: false),
  Event(
      id: 29,
      title: "The Politics of Pronouns",
      location: "Room D1",
      details:
          "Exploring the importance of respecting chosen pronouns and their impact on inclusion...",
      participants: 60,
      availableSpots: 25,
      date: "April 23, 2025, 10:00 AM",
      path: "lib/assets/identity04.png",
      type: "Identity",
      isJoined: false),
  Event(
      id: 30,
      title: "Inclusive Language in Educational Spaces",
      location: "Education Center",
      details:
          "Learning inclusive language practices to create safe educational environments...",
      participants: 50,
      availableSpots: 20,
      date: "April 23, 2025, 12:00 PM",
      path: "lib/assets/identity05.jpeg",
      type: "Identity",
      isJoined: false),
  Event(
      id: 31,
      title: "Queer and Trans Youth Empowerment",
      location: "Youth Space",
      details:
          "Queer and trans youth empowerment through personal stories and guided activities...",
      participants: 45,
      availableSpots: 13,
      date: "April 23, 2025, 3:00 PM",
      path: "lib/assets/identity06.png",
      type: "Identity",
      isJoined: false),

  // SEXUAL HEALTH
  Event(
      id: 32,
      title: "Reproductive Justice: Rights and Realities",
      location: "Hall B1",
      details:
          "Exploring how reproductive justice intersects with social, economic, and racial equity...",
      participants: 60,
      availableSpots: 22,
      date: "April 19, 2025, 10:00 AM",
      path: "lib/assets/sexhealth01.png",
      type: "sexHealth",
      isJoined: false),
  Event(
      id: 33,
      title: "Understanding Contraceptive Options Today",
      location: "Room 2A",
      details:
          "Exploring modern contraceptive methods, how they work, and who benefits the most...",
      participants: 50,
      availableSpots: 17,
      date: "April 19, 2025, 12:00 PM",
      path: "lib/assets/sexhealth02.png",
      type: "sexHealth",
      isJoined: false),
  Event(
      id: 34,
      title: "Emergency Contraception: Myths and Facts",
      location: "Advocacy Center",
      details:
          "Debunking misconceptions about emergency contraception and discussing accessibility...",
      participants: 45,
      availableSpots: 19,
      date: "April 19, 2025, 2:00 PM",
      path: "lib/assets/sexhealth03.png",
      type: "sexHealth",
      isJoined: false),
  Event(
      id: 35,
      title: "Menstrual Equity and Public Policy",
      location: "Room C3",
      details:
          "Analyzing how menstrual poverty affects global communities and what public policies exist...",
      participants: 40,
      availableSpots: 12,
      date: "April 20, 2025, 9:00 AM",
      path: "lib/assets/sexhealth04.png",
      type: "sexHealth",
      isJoined: false),
  Event(
      id: 36,
      title: "Access to Safe Abortions: Legal and Medical Perspectives",
      location: "Main Auditorium",
      details:
          "Exploring access to safe abortions from legal and medical perspectives...",
      participants: 100,
      availableSpots: 38,
      date: "April 20, 2025, 11:00 AM",
      path: "lib/assets/sexhealth05.png",
      type: "sexHealth",
      isJoined: false),
  Event(
      id: 37,
      title: "Pregnancy, Parenthood, and Reproductive Choices",
      location: "Room A4",
      details:
          "Exploring complex decisions around pregnancy, parenthood, and available resources...",
      participants: 60,
      availableSpots: 24,
      date: "April 20, 2025, 2:00 PM",
      path: "lib/assets/sexhealth06.png",
      type: "sexHealth",
      isJoined: false),
];
