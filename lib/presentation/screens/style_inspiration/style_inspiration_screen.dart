import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../data/repositories/inspiration_repository.dart';
import '../../../logic/blocs/style_inspiration/inspiration_cubit.dart';
import '../../../logic/blocs/style_inspiration/inspiration_state.dart';
import '../../widgets/style_inspiration/inspiration_masonry.dart';
import '../../widgets/style_inspiration/inspiration_search_filters.dart';

class StyleInspirationScreen extends StatelessWidget {
  const StyleInspirationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => InspirationCubit(MockInspirationRepository())..load(),
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F9FA),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: Text(
            'Style Inspiration',
            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18.sp, color: const Color(0xFF111827)),
          ),
        ),
        body: BlocBuilder<InspirationCubit, InspirationState>(
          builder: (context, state) {
            final cubit = context.read<InspirationCubit>();

            if (state.status == InspirationStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state.status == InspirationStatus.failure) {
              return Center(
                child: Text('Failed to load: ${state.error}', style: TextStyle(fontSize: 14.sp)),
              );
            }

            return Column(
              children: [
                InspirationSearchFilters(
                  categories: cubit.categories,
                  selected: state.selectedCategory,
                  onCategoryChanged: cubit.setCategory,
                  onQueryChanged: cubit.setQuery,
                  onOpenFilters: () {
                    // TODO: open filters sheet
                  },
                ),
                Expanded(
                  child: InspirationMasonry(
                    items: state.filtered,
                    accentStep: state.accentStep,
                    isSaved: (id) => state.savedIds.contains(id),
                    onToggleSave: cubit.toggleSave,
                    onTap: (_) {
                      // TODO: push detail page
                    },
                    onAccentStepChange: cubit.setAccentStep,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
