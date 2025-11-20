import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/bloc/lead_bloc.dart';
import '../../logic/bloc/lead_event.dart';
import '../../logic/bloc/lead_state.dart';
import '../../logic/bloc/theme_cubit.dart';
import 'add_edit_lead_screen.dart';
import 'search_screen.dart';
import '../widgets/lead_list_item.dart';


class HomeScreen extends StatelessWidget 
{
  const HomeScreen({super.key});


  @override
  Widget build(BuildContext context) 
  {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            title: const Text(
              "Leads",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            actions: [
               IconButton(
                 icon: const Icon(Icons.search),
                 onPressed: () {
                   Navigator.push(
                     context, 
                     MaterialPageRoute(builder: (_) => const SearchScreen())
                   );
                 },
               ),
               IconButton(
                 icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
                 onPressed: () {
                   context.read<ThemeCubit>().toggleTheme();
                 },
               ),
            ],
          ),

          SliverToBoxAdapter(child: _buildFilterChips(context)),

          BlocBuilder<LeadBloc, LeadState>(
            builder: (context, state) {
              if (state.status == LeadStatus.loading) 
              {
                return const SliverFillRemaining(child: Center(child: CircularProgressIndicator()));
              }
              if (state.visibleLeads.isEmpty) 
              {
                return SliverFillRemaining(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.folder_open, size: 64, color: Colors.grey[500]),
                        const SizedBox(height: 16),
                        Text("No leads found", style: TextStyle(color: Colors.grey[500], fontSize: 16)),
                      ],
                    ),
                  ),
                );
              }
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    child: LeadListItem(lead: state.visibleLeads[index]),
                  ),
                  childCount: state.visibleLeads.length,
                ),
              );
            },
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AddEditLeadScreen())),
        label: const Text("New Lead"),
        icon: const Icon(Icons.add),
      ),
    );
  }


  Widget _buildFilterChips(BuildContext context) 
  {
    final statuses = ['All', 'New', 'Contacted', 'Converted', 'Lost'];
    return BlocBuilder<LeadBloc, LeadState>(
      buildWhen: (p, c) => p.filter != c.filter,
      builder: (context, state) {
        return Container(
          height: 60,
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: statuses.length,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              final status = statuses[index];
              final isSelected = state.filter == status;
              return FilterChip(
                label: Text(status),
                selected: isSelected,
                onSelected: (_) => context.read<LeadBloc>().add(FilterLeads(status)),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                checkmarkColor: isSelected ? Colors.white : null,
                backgroundColor: Theme.of(context).brightness == Brightness.dark 
                    ? Colors.grey[800] 
                    : null,
              );
            },
          ),
        );
      },
    );
  }
}