import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/lead_model.dart';
import '../../logic/bloc/lead_bloc.dart';
import '../../logic/bloc/lead_event.dart';


class AddEditLeadScreen extends StatefulWidget 
{
  final Lead? lead;
  const AddEditLeadScreen({super.key, this.lead});

  @override
  State<AddEditLeadScreen> createState() => _AddEditLeadScreenState();
}

class _AddEditLeadScreenState extends State<AddEditLeadScreen> 
{
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameCtrl;
  late TextEditingController _contactCtrl;
  late TextEditingController _notesCtrl;
  String _status = 'New';


  @override
  void initState() 
  {
    super.initState();
    _nameCtrl = TextEditingController(text: widget.lead?.name ?? '');
    _contactCtrl = TextEditingController(text: widget.lead?.contact ?? '');
    _notesCtrl = TextEditingController(text: widget.lead?.notes ?? '');
    _status = widget.lead?.status ?? 'New';
  }


  @override
  Widget build(BuildContext context) 
  {
    final isEditing = widget.lead != null;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? "Edit Lead" : "New Lead"),
        actions: [
          if (isEditing)
            IconButton(
              icon: const Icon(Icons.delete_outline, color: Colors.red),
              onPressed: _confirmDelete,
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildCard(context, [
                _buildTextField("Name", _nameCtrl, Icons.person_outline),
                Divider(height: 30, color: isDark ? Colors.grey[800] : Colors.grey[200]),
                _buildTextField("Contact Info", _contactCtrl, Icons.phone_outlined),
              ]),
              const SizedBox(height: 20),
              _buildCard(context, [
                _buildDropdown(isDark),
                Divider(height: 30, color: isDark ? Colors.grey[800] : Colors.grey[200]),
                _buildTextField("Notes", _notesCtrl, Icons.edit_note, maxLines: 3),
              ]),
              const SizedBox(height: 30),
              FilledButton(
                onPressed: _save,
                style: FilledButton.styleFrom(
                  minimumSize: const Size(double.infinity, 56),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                child: Text(
                  "Save Lead",
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildCard(BuildContext context, List<Widget> children) 
  {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.03), 
            blurRadius: 10, 
            offset: const Offset(0,4)
          )
        ],
      ),
      child: Column(children: children),
    );
  }


  Widget _buildTextField(String label, TextEditingController controller, IconData icon, {int maxLines = 1}) 
  {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      validator: (v) => v == null || v.isEmpty ? 'Required' : null,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.grey),
        border: InputBorder.none,
        contentPadding: const EdgeInsets.symmetric(vertical: 8),
      ),
    );
  }


  Widget _buildDropdown(bool isDark) 
  {
    return DropdownButtonFormField<String>(
      value: _status,
      dropdownColor: isDark ? const Color(0xFF2C2C2C) : Colors.white,
      decoration: const InputDecoration(
        labelText: "Status",
        prefixIcon: Icon(Icons.flag_outlined, color: Colors.grey),
        border: InputBorder.none,
      ),
      items: ['New', 'Contacted', 'Converted', 'Lost'].map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
      onChanged: (v) => setState(() => _status = v!),
    );
  }


  void _save() 
  {
    if (!_formKey.currentState!.validate()) return;

    final lead = widget.lead?.copyWith(
      name: _nameCtrl.text,
      contact: _contactCtrl.text,
      status: _status,
      notes: _notesCtrl.text,
    ) ?? Lead(
      name: _nameCtrl.text,
      contact: _contactCtrl.text,
      status: _status,
      notes: _notesCtrl.text,
      createdTime: DateTime.now(),
    );

    if (widget.lead == null) 
    {
      context.read<LeadBloc>().add(AddLead(lead));
    } 
    else 
    {
      context.read<LeadBloc>().add(UpdateLead(lead));
    }
    Navigator.pop(context);
  }


  void _confirmDelete() 
  {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Delete?"),
        content: const Text("This cannot be undone."),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("Cancel")),
          TextButton(
            onPressed: () {
              context.read<LeadBloc>().add(DeleteLead(widget.lead!.id!));
              Navigator.pop(ctx); 
              Navigator.pop(context); 
            },
            child: const Text("Delete", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}