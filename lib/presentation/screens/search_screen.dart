import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/bloc/lead_bloc.dart';
import '../../logic/bloc/lead_state.dart';
import '../widgets/lead_list_item.dart';


class SearchScreen extends StatefulWidget 
{
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}


class _SearchScreenState extends State<SearchScreen> 
{
  final TextEditingController _searchCtrl = TextEditingController();
  String _query = '';


  @override
  void dispose() 
  {
    _searchCtrl.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) 
  {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: TextField(
          controller: _searchCtrl,
          autofocus: true,
          style: const TextStyle(fontSize: 18),
          decoration: const InputDecoration(
            hintText: "Search by name...",
            border: InputBorder.none,
          ),
          onChanged: (val) {
            setState(() {
              _query = val;
            });
          },
        ),
        actions: [
          if (_query.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                _searchCtrl.clear();
                setState(() => _query = '');
              },
            ),
          const SizedBox(width: 16),
        ],
      ),
      body: BlocBuilder<LeadBloc, LeadState>(
        builder: (context, state) 
        {
          // 1. Get ALL leads (ignore home screen filter)
          final allLeads = state.allLeads;
          
          // 2. Filter locally based on query
          final results = allLeads.where((lead) {
            final nameMatches = lead.name.toLowerCase().contains(_query.toLowerCase());
            return nameMatches;
          }).toList();

          if (results.isEmpty) 
          {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.search_off, size: 64, color: Colors.grey[400]),
                  const SizedBox(height: 16),
                  Text(
                    _query.isEmpty ? "Start typing to search" : "No results found",
                    style: TextStyle(color: Colors.grey[600], fontSize: 16),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: results.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: LeadListItem(lead: results[index]),
              );
            },
          );
        },
      ),
    );
  }
}