import 'dart:async';
import 'dart:math';

import '../models/chat_thread.dart';
import '../models/message.dart';

abstract class ChatRepository {
  Future<List<ChatThread>> fetchThreads();

  Future<List<Message>> fetchMessages(String chatId);

  Future<Message> sendMessage(String chatId, String text);

  Future<Message> addTailorMessage(String chatId, String text);
}

class MockChatRepository implements ChatRepository {
  /// Only user/appended messages are stored.
  final Map<String, List<Message>> _append = {};
  final Map<String, List<Message>> _store = {};

  /// How many base (generated) messages each thread has.
  /// You can tune these counts per thread to control “lengthiness”.
  final Map<String, int> _baseLen = const {
    't1': 120,
    't2': 100,
    't3': 140,
    't4': 80,
    't5': 110,
    't6': 95,
    't7': 130,
    't8': 90,
    't9': 105,
    't10': 115,
  };

  /// Ten strong, varied threads.
  final List<ChatThread> _threads = [
    ChatThread(
      id: 't1',
      title: 'Ahmed Couture',
      subtitle: 'Bespoke Suits • Lagos',
      online: true,
      pinned: true,
      unreadCount: 2,
      lastActivity: DateTime.now().subtract(const Duration(minutes: 2)),
      lastMessagePreview: 'Your fitting is confirmed for Saturday.',
      colorSeed: 1,
    ),
    ChatThread(
      id: 't2',
      title: 'Maison Kente',
      subtitle: 'Ankara & Kente Specialists',
      online: false,
      pinned: false,
      unreadCount: 0,
      lastActivity: DateTime.now().subtract(const Duration(hours: 1)),
      lastMessagePreview: 'We can source that emerald fabric.',
      colorSeed: 5,
    ),
    ChatThread(
      id: 't3',
      title: 'Black Tie Co.',
      subtitle: 'Tuxedo Rentals & Custom',
      online: true,
      pinned: false,
      unreadCount: 1,
      lastActivity: DateTime.now().subtract(const Duration(minutes: 35)),
      lastMessagePreview: 'Slim satin lapel works with your build.',
      colorSeed: 9,
    ),
    ChatThread(
      id: 't4',
      title: 'Linen Lab',
      subtitle: 'Minimal Linen Sets',
      online: false,
      pinned: false,
      unreadCount: 0,
      lastActivity: DateTime.now().subtract(const Duration(days: 1, hours: 3)),
      lastMessagePreview: 'Natural beige is back in stock.',
      colorSeed: 13,
    ),
    ChatThread(
      id: 't5',
      title: 'Pattern Haus',
      subtitle: 'Creative Patterns & Street',
      online: true,
      pinned: false,
      unreadCount: 0,
      lastActivity: DateTime.now().subtract(const Duration(minutes: 10)),
      lastMessagePreview: 'Sending mockups shortly.',
      colorSeed: 21,
    ),
    ChatThread(
      id: 't6',
      title: 'The Fit Studio',
      subtitle: 'Advanced Measurements',
      online: true,
      pinned: false,
      unreadCount: 3,
      lastActivity: DateTime.now().subtract(const Duration(minutes: 5)),
      lastMessagePreview: 'We’ll adjust the waist by 1.5cm.',
      colorSeed: 3,
    ),
    ChatThread(
      id: 't7',
      title: 'Silk & Wool',
      subtitle: 'Premium Fabrics',
      online: false,
      pinned: false,
      unreadCount: 0,
      lastActivity: DateTime.now().subtract(const Duration(hours: 3)),
      lastMessagePreview: 'The merino bundle just arrived.',
      colorSeed: 7,
    ),
    ChatThread(
      id: 't8',
      title: 'Noble Needle',
      subtitle: 'Bridal & Ceremonial',
      online: true,
      pinned: false,
      unreadCount: 0,
      lastActivity: DateTime.now().subtract(const Duration(minutes: 50)),
      lastMessagePreview: 'Your train length looked perfect.',
      colorSeed: 11,
    ),
    ChatThread(
      id: 't9',
      title: 'Urban Stitch',
      subtitle: 'Streetwear Tailoring',
      online: true,
      pinned: false,
      unreadCount: 0,
      lastActivity: DateTime.now().subtract(const Duration(minutes: 18)),
      lastMessagePreview: 'We can taper the joggers.',
      colorSeed: 17,
    ),
    ChatThread(
      id: 't10',
      title: 'Heritage Atelier',
      subtitle: 'Classic Menswear',
      online: false,
      pinned: true,
      unreadCount: 0,
      lastActivity: DateTime.now().subtract(const Duration(hours: 6, minutes: 10)),
      lastMessagePreview: 'Let’s review button stance options.',
      colorSeed: 19,
    ),
  ];

  
  @override
  Future<Message> addTailorMessage(String chatId, String text) async {
    final msg = Message(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      chatId: chatId,
      sender: MessageSender.tailor,
      text: text.trim(),
      timestamp: DateTime.now(),
      status: MessageStatus.sent,
    );
    _store.putIfAbsent(chatId, () => []).add(msg);
    return msg;
  }

  @override
  Future<List<ChatThread>> fetchThreads() async {
    await Future.delayed(const Duration(milliseconds: 240));
    // Optionally refresh previews from the last generated message:
    for (final t in _threads) {
      final msgs = _generateBase(t.id, _baseLen[t.id] ?? 80, seed: t.colorSeed);
      final latest = (msgs.isNotEmpty ? msgs.last : null) ?? Message(
        id: 'x',
        chatId: 'none',
        sender: MessageSender.tailor,
        text: '…',
        timestamp: DateTime.now(),
      );
      final idx = _threads.indexOf(t);
      if (idx != -1) {
        _threads[idx] = t.copyWith(
          lastActivity: latest.timestamp,
          lastMessagePreview: latest.text.length > 60 ? '${latest.text.substring(0, 60)}…' : latest.text,
        );
      }
    }
    // Sort by activity (desc)
    final sorted = [..._threads]..sort((a, b) => b.lastActivity.compareTo(a.lastActivity));
    return sorted;
  }

  @override
  Future<List<Message>> fetchMessages(String chatId) async {
    await Future.delayed(const Duration(milliseconds: 220));

    final base = _generateBase(chatId, _baseLen[chatId] ?? 80, seed: _seedFor(chatId));
    final appended = _append[chatId] ?? const <Message>[];

    // Combine, keep chronological order (oldest -> newest)
    final combined = <Message>[...base, ...appended]..sort((a, b) => a.timestamp.compareTo(b.timestamp));
    return combined;
  }

  @override
  Future<Message> sendMessage(String chatId, String text) async {
    final temp = Message(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      chatId: chatId,
      sender: MessageSender.customer,
      text: text.trim(),
      timestamp: DateTime.now(),
      status: MessageStatus.sending,
    );
    _append.putIfAbsent(chatId, () => []).add(temp);

    await Future.delayed(const Duration(milliseconds: 250));
    final sent = temp.copyWith(status: MessageStatus.sent);

    // Replace temp with sent
    final list = _append[chatId]!;
    final i = list.indexWhere((m) => m.id == temp.id);
    if (i != -1) list[i] = sent;

    // Update thread preview/activity
    final idx = _threads.indexWhere((t) => t.id == chatId);
    if (idx != -1) {
      final t = _threads[idx];
      _threads[idx] = t.copyWith(
        lastActivity: sent.timestamp,
        lastMessagePreview: sent.text.length > 60 ? '${sent.text.substring(0, 60)}…' : sent.text,
      );
    }

    return sent;
  }

  // -----------------------------
  // Below: deterministic generator
  // -----------------------------

  int _seedFor(String chatId) {
    // stable seeds per id for deterministic histories
    return chatId.codeUnits.fold<int>(0, (a, b) => (a * 131 + b) & 0x7fffffff);
  }

  List<Message> _generateBase(String chatId, int count, {required int seed}) {
    final rnd = Random(seed);
    final now = DateTime.now();
    final start = now.subtract(Duration(days: 30 + rnd.nextInt(25))); // history spanning ~1–2 months
    DateTime cursor = start.add(Duration(minutes: rnd.nextInt(180)));

    final List<_Scenario> script = _scriptFor(chatId, rnd);

    final List<Message> out = [];
    int idCounter = 1;

    Message _make(MessageSender s, String txt) {
      final msg = Message(
        id: 'g$idCounter',
        chatId: chatId,
        sender: s,
        text: txt,
        timestamp: cursor,
        status: s == MessageSender.customer ? MessageStatus.read : MessageStatus.read,
      );
      idCounter++;
      // next gap (2–45 mins, sometimes hours/days)
      final gapPick = rnd.nextDouble();
      if (gapPick < 0.80) {
        cursor = cursor.add(Duration(minutes: 2 + rnd.nextInt(43)));
      } else if (gapPick < 0.95) {
        cursor = cursor.add(Duration(hours: 2 + rnd.nextInt(8)));
      } else {
        cursor = cursor.add(Duration(days: 1 + rnd.nextInt(2), hours: rnd.nextInt(6)));
      }
      return msg;
    }

    // Build conversation by looping scenarios until we reach count
    while (out.length < count) {
      for (final scenario in script) {
        final lines = scenario.build(rnd);
        for (final l in lines) {
          out.add(_make(l.$1, l.$2));
          if (out.length >= count) break;
        }
        if (out.length >= count) break;
        // small pause between scenarios
        cursor = cursor.add(Duration(hours: 6 + rnd.nextInt(18)));
      }
    }

    // trim to exact count oldest->newest
    return out.take(count).toList();
  }

  /// Choose scenario order per thread to make each chat feel unique.
  List<_Scenario> _scriptFor(String chatId, Random rnd) {
    final negotiation = _Scenario.negotiation();
    final measurement = _Scenario.measurement();
    final complaint = _Scenario.complaint();
    final fixup = _Scenario.fixupApology();
    final referral = _Scenario.referral();
    final upsell = _Scenario.upsell();
    final logistics = _Scenario.logistics();
    final friendly = _Scenario.friendlyClosure();
    final haggling = _Scenario.haggling();
    final spicy = _Scenario.mildSpatResolve();

    final all = [
      negotiation, haggling, measurement, logistics,
      complaint, fixup, referral, upsell, spicy, friendly,
    ];

    // shuffle deterministically for the thread
    final list = [...all];
    list.shuffle(rnd);
    return list;
  }
}

/// Conversation building blocks.
/// Each scenario returns a list of (sender, text) pairs.
/// Texts are composed from small phrase banks (memory cheap),
/// and some are long paragraphs to simulate "lengthy chats."
class _Scenario {
  final List<(MessageSender, String)> Function(Random) build;
  _Scenario(this.build);

  static _Scenario negotiation() => _Scenario((rnd) {
    String customerNeed() => [
      'I need a navy two-piece for a conference in Abuja. Soft shoulders, slim but not tight. Can we do it?',
      'Looking for a power suit—clean lines, no sheen. I’ll be on stage; it has to sit perfectly.',
      'Wedding guest set—subtle texture, breathable. I sweat easily; please suggest a fabric that helps.',
    ][rnd.nextInt(3)];

    String tailorReply() => [
      'We can do a mid-weight wool blend—breathes well, drapes clean. I’ll send swatches.',
      'Yes. Half-canvas, light chest piece to keep structure without bulk.',
      'Absolutely. I’d recommend a tropical wool; crisp look, good airflow.',
    ][rnd.nextInt(3)];

    String longExplainer() => [
      'For the lapels, I suggest 7.5cm notch; slimmer reads trendy but ages quickly. Side adjusters instead of belt loops give a neater waist. We’ll add a 3cm hem allowance in case you want more break later.',
      'We’ll shape the waist subtly and keep armhole higher for mobility. I’ll reinforce the pocket welts; with microphones on stage, they get tugged a lot.',
      'I prefer horn buttons here—more depth than plastic. Lining only in the sleeves; body unlined to stay cool. You’ll still get clean structure.',
    ][rnd.nextInt(3)];

    final lines = <(MessageSender, String)>[
      (MessageSender.customer, customerNeed()),
      (MessageSender.tailor, tailorReply()),
      (MessageSender.tailor, longExplainer()),
      (MessageSender.customer, 'Sounds thoughtful. Timeline and ballpark pricing?'),
      (MessageSender.tailor, '5–7 working days after fitting. Budget ₦85k–₦110k depending on fabric choice.'),
      (MessageSender.customer, 'Alright. Let’s see swatches then lock it.'),
    ];
    return lines;
  });

  static _Scenario haggling() => _Scenario((rnd) {
    String pushBack() => [
      '₦110k is steep. I’m not trying to be difficult, but that’s high for me.',
      'Can we be realistic? My budget is closer to ₦70k.',
      'Hmm. I wasn’t ready for six figures. Help me out a bit.',
    ][rnd.nextInt(3)];
    String justify() => [
      'You’re paying for hand finishing and a durable canvas. It will outlast cheaper fusing by years.',
      'Fabric alone is premium—colorfast, low pilling. Finish is clean. I stand by the value.',
      'I don’t cut corners on pattern matching or buttonholes. The difference shows under lights.',
    ][rnd.nextInt(3)];
    String settle() => [
      'Okay, meet me at ₦92k and include the garment bag.',
      'Let’s close at ₦89k, and I’ll throw in a spare set of buttons.',
      'We can do ₦95k with expedited fitting on Saturday morning.',
    ][rnd.nextInt(3)];
    String acceptance() => [
      'Deal. Let’s do ₦92k with the bag. Thanks.',
      '₦89k and spare buttons works. Appreciate it.',
      'Alright, ₦95k with expedited fitting is fine.',
    ][rnd.nextInt(3)];

    return [
      (MessageSender.customer, pushBack()),
      (MessageSender.tailor, justify()),
      (MessageSender.tailor, settle()),
      (MessageSender.customer, acceptance()),
    ];
  });

  static _Scenario measurement() => _Scenario((rnd) {
    return [
      (MessageSender.tailor, 'Please share height, weight, and a quick front/side photo. This helps pre-draft before you arrive.'),
      (MessageSender.customer, 'Height 176cm, ~76kg. I’ll send photos later today.'),
      (MessageSender.tailor, 'Noted. I’ll block a 30-min fitting; you won’t be here long.'),
    ];
  });

  static _Scenario logistics() => _Scenario((rnd) {
    return [
      (MessageSender.tailor, 'Saturday 10:30 AM confirmed. Workshop is at Yaba—parking available.'),
      (MessageSender.customer, 'Great, I’ll be there. Do I bring shoes?'),
      (MessageSender.tailor, 'Yes, brings the pair you plan to wear—hem length depends on it.'),
    ];
  });

  static _Scenario complaint() => _Scenario((rnd) {
    String complaintText() => [
      'The trouser seat feels tight when I sit. Standing is fine, but sitting pinches.',
      'Sleeves are perfect, but the collar bites when I turn. Can we soften that?',
      'Love the fabric, but the waist is a touch snug after lunch.',
    ][rnd.nextInt(3)];
    String longCustomer() => [
      'I wore it for 6 hours at an event. Generally great, but after the first hour the seat kept reminding me it’s there. I’m probably between sizes.',
      'On camera it looked amazing; just that collar edge gets me when I turn quickly. Everything else sits premium.',
    ][rnd.nextInt(2)];
    return [
      (MessageSender.customer, complaintText()),
      (MessageSender.customer, longCustomer()),
      (MessageSender.tailor, 'Thanks for the honest feedback. I’ll let it out by 1.5cm at the seat and soften the collar edge. No charge.'),
      (MessageSender.customer, 'Legend. Appreciate that.'),
    ];
  });

  static _Scenario fixupApology() => _Scenario((rnd) {
    return [
      (MessageSender.tailor, 'Apologies for the discomfort earlier. I prefer you love it outright. Fixed the seat and collar—please try tomorrow.'),
      (MessageSender.customer, 'Tried it. Comfort is night and day. Stitching still looks crisp. Thank you.'),
    ];
  });

  static _Scenario referral() => _Scenario((rnd) {
    return [
      (MessageSender.customer, 'My friend Kelechi needs a 3-piece for a gala. Can I connect you both?'),
      (MessageSender.tailor, 'Please do. I’ll take good care of them—thank you for the trust.'),
      (MessageSender.customer, 'Shared your number. Expect a ping.'),
    ];
  });

  static _Scenario upsell() => _Scenario((rnd) {
    return [
      (MessageSender.tailor, 'If you liked the drape, I can do a travel blazer in the same family—wrinkle-resistant, lightweight.'),
      (MessageSender.customer, 'Tempting. Send options, I travel a lot this quarter.'),
    ];
  });

  static _Scenario mildSpatResolve() => _Scenario((rnd) {
    // “Insult” but kept safe + professional (mild heat, quick de-escalation)
    return [
      (MessageSender.customer, 'You’re moving slow today. Are you still on my order or juggling too much?'),
      (MessageSender.tailor, 'Fair question. Two urgent weddings crashed the queue. I won’t compromise your quality.'),
      (MessageSender.customer, 'I need it top-tier, not excuses.'),
      (MessageSender.tailor, 'Understood. Re-prioritized your piece; I’ll deliver as promised.'),
      (MessageSender.customer, 'Thanks. I was frustrated. Let’s keep it moving.'),
      (MessageSender.tailor, 'Appreciate the clarity—I’ll update you tonight.'),
    ];
  });

  static _Scenario friendlyClosure() => _Scenario((rnd) {
    return [
      (MessageSender.tailor, 'Final fit looked great. Wishing you a strong week ahead.'),
      (MessageSender.customer, 'Likewise. You earned a loyal customer.'),
      (MessageSender.tailor, 'Grateful. Cheers to more wins.'),
    ];
  });
}
