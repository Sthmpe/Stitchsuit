import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../data/repositories/chat_repository.dart';
import '../../../logic/blocs/chats/conversation_bloc.dart';
import '../../../logic/blocs/chats/threads_bloc.dart';
import '../../widgets/chat/chat_tile.dart';
import 'conversation_screen.dart';

class ChatsListScreen extends StatelessWidget {
  const ChatsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ThreadsBloc(repo: context.read<ChatRepository>())..add(const ThreadsRequested()),
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F9FA),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: Text('Chats', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18.sp, color: const Color(0xFF111827))),
        ),
        body: Column(
          children: [
            const _SearchAndFilterBar(),
            Expanded(
              child: BlocBuilder<ThreadsBloc, ThreadsState>(
                builder: (context, state) {
                  if (state.isLoading) return const Center(child: CircularProgressIndicator());
                  if (state.error != null) return Center(child: Text('Failed to load: ${state.error}'));

                  final items = state.visible;
                  if (items.isEmpty) {
                    return Center(
                      child: Text('No chats', style: TextStyle(fontSize: 14.sp, color: const Color(0xFF6B7280))),
                    );
                  }

                  return ListView.separated(
                    padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 16.h),
                    itemCount: items.length,
                    separatorBuilder: (_, __) => SizedBox(height: 8.h),
                    itemBuilder: (_, i) {
                      final thread = items[i];
                      return ChatTile(
                        thread: thread,
                        onTap: () {
                          final repo = context.read<ChatRepository>();
                          final threads = context.read<ThreadsBloc>();

                          Get.to(
                            () => BlocProvider(
                              create: (_) => ConversationBloc(
                                repo: repo,
                                threadsBloc: threads,
                                chatId: thread.id,
                              )..add(const ConversationStarted()),
                              child: ConversationScreen(thread: thread),
                            ),
                          );
                        },
                        onLongPress: () => context.read<ThreadsBloc>().add(ThreadPinToggled(thread.id)), // toggle pin
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SearchAndFilterBar extends StatelessWidget {
  const _SearchAndFilterBar();

  @override
  Widget build(BuildContext context) {
    final brand = Theme.of(context).primaryColor;
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14.r),
              border: Border.all(color: const Color(0xFFE5E7EB)),
            ),
            child: TextField(
              textInputAction: TextInputAction.search,
              cursorColor: brand,
              onChanged: (v) => context.read<ThreadsBloc>().add(ThreadsQueryChanged(v)),
              style: TextStyle(fontSize: 14.sp),
              decoration: InputDecoration(
                hintText: 'Search tailor or chats…',
                hintStyle: TextStyle(color: const Color(0xFF9AA0A6), fontSize: 14.sp),
                prefixIcon: Icon(Icons.search, color: brand, size: 20.sp),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 14.h),
              ),
            ),
          ),
        ),
        SizedBox(height: 10.h),
        SizedBox(
          height: 36.h,
          child: BlocBuilder<ThreadsBloc, ThreadsState>(
            buildWhen: (p, c) => p.filter != c.filter,
            builder: (context, state) {
              return ListView(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                scrollDirection: Axis.horizontal,
                children: [
                  _chip(context, 'All', state.filter == ChatListFilter.all, () {
                    context.read<ThreadsBloc>().add(const ThreadsFilterChanged(ChatListFilter.all));
                  }),
                  SizedBox(width: 8.w),
                  _chip(context, 'Unread', state.filter == ChatListFilter.unread, () {
                    context.read<ThreadsBloc>().add(const ThreadsFilterChanged(ChatListFilter.unread));
                  }),
                  SizedBox(width: 8.w),
                  _chip(context, 'Pinned', state.filter == ChatListFilter.pinned, () {
                    context.read<ThreadsBloc>().add(const ThreadsFilterChanged(ChatListFilter.pinned));
                  }),
                ],
              );
            },
          ),
        ),
        SizedBox(height: 6.h),
      ],
    );
  }

  Widget _chip(BuildContext context, String label, bool selected, VoidCallback onTap) {
    final brand = Theme.of(context).primaryColor;
    return ChoiceChip(
      label: Text(label, style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w800, color: selected ? brand : const Color(0xFF374151))),
      selected: selected,
      backgroundColor: Colors.white,
      selectedColor: brand.withOpacity(.10),
      shape: StadiumBorder(side: BorderSide(color: selected ? brand.withOpacity(.35) : const Color(0xFFE5E7EB))),
      onSelected: (_) => onTap(),
    );
  }
}
