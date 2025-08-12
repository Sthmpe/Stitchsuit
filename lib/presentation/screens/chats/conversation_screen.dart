import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../data/models/chat_thread.dart';
import '../../../logic/blocs/chats/conversation_bloc.dart';
import '../../widgets/chat/date_divider.dart';
import '../../widgets/chat/input_bar.dart';
import '../../widgets/chat/message_bubble.dart';
import '../../widgets/chat/typing_indicator.dart';

class ConversationScreen extends StatefulWidget {
  final ChatThread thread;
  const ConversationScreen({super.key, required this.thread});

  @override
  State<ConversationScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  final _controller = TextEditingController();
  final _listCtrl = ScrollController();

  @override
  void dispose() {
    _controller.dispose();
    _listCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final brand = Theme.of(context).primaryColor;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        titleSpacing: 0,
        title: Row(
          children: [
            SizedBox(width: 8.w),
            CircleAvatar(
              radius: 18.r,
              backgroundColor: brand.withOpacity(.12),
              child: Text(
                widget.thread.title[0],
                style: TextStyle(color: brand, fontWeight: FontWeight.w800, fontSize: 14.sp),
              ),
            ),
            SizedBox(width: 10.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.thread.title, style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14.sp, color: const Color(0xFF111827))),
                SizedBox(height: 2.h),
                Text(widget.thread.online ? 'Online' : 'Typically replies in 1 hr',
                    style: TextStyle(fontSize: 11.sp, color: widget.thread.online ? const Color(0xFF10B981) : const Color(0xFF6B7280), fontWeight: FontWeight.w700)),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(icon: const Icon(Icons.call_outlined), onPressed: () {}),
          IconButton(icon: const Icon(Icons.videocam_outlined), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          // MESSAGES + TYPING (inside list)
          Expanded(
            child: BlocListener<ConversationBloc, ConversationState>(
              listenWhen: (p, c) =>
                  p.messages.length != c.messages.length ||
                  p.tailorTyping != c.tailorTyping ||
                  p.isLoading != c.isLoading,
              listener: (_, __) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (_listCtrl.hasClients) {
                    _listCtrl.jumpTo(_listCtrl.position.maxScrollExtent);
                  }
                });
              },
              child: BlocBuilder<ConversationBloc, ConversationState>(
                builder: (context, state) {
                  if (state.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final msgs = state.messages; // oldest -> newest
                  final itemCount = msgs.length + (state.tailorTyping ? 1 : 0);

                  return ListView.builder(
                    controller: _listCtrl,
                    padding: EdgeInsets.fromLTRB(12.w, 12.h, 12.w, 12.h + 64.h),
                    itemCount: itemCount,
                    itemBuilder: (_, index) {
                      if (index == msgs.length) return TypingIndicator();

                      // normal messages
                      if (index < msgs.length) {
                        final bubble = MessageBubble(message: msgs[index]);

                        if (index == 0) {
                          return Column(
                            children: [
                              DateDivider(date: msgs[index].timestamp),
                              SizedBox(height: 8.h),
                              bubble,
                            ],
                          );
                        }

                        final prev = msgs[index - 1].timestamp;
                        final curr = msgs[index].timestamp;
                        final needDivider = prev.year != curr.year || prev.month != curr.month || prev.day != curr.day;

                        if (needDivider) {
                          return Column(
                            children: [
                              SizedBox(height: 10.h),
                              DateDivider(date: curr),
                              SizedBox(height: 8.h),
                              bubble,
                            ],
                          );
                        }
                        return bubble;
                      }

                      // last slot: typing indicator
                      return Padding(
                        padding: EdgeInsets.only(left: 6.w, right: 60.w, top: 8.h, bottom: 4.h),
                        child: const TypingIndicator(),
                      );
                    },
                  );
                },
              ),
            ),
          ),

          // input
          InputBar(
            controller: _controller,
            // REMOVE: onChanged -> ConversationTyping
            onSend: () {
              final text = _controller.text;
              _controller.clear();
              context.read<ConversationBloc>().add(
                ConversationMessageSent(text),
              );
              Future.delayed(const Duration(milliseconds: 80), () {
                if (_listCtrl.hasClients) {
                  _listCtrl.jumpTo(_listCtrl.position.maxScrollExtent);
                }
              });
            },
            onAttach: () {},
            onCamera: () {},
          ),
        ],
      ),
    );
  }
}
