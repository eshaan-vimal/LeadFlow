import 'package:flutter/material.dart';
import '../../data/models/lead_model.dart';
import '../screens/add_edit_lead_screen.dart';


class LeadListItem extends StatelessWidget 
{
  final Lead lead;

  const LeadListItem({super.key, required this.lead});


  @override
  Widget build(BuildContext context) 
  {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Card(
      elevation: 0,
      // Dynamic color: Dark Grey in dark mode, White in light mode
      color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        // Softer border in dark mode
        side: BorderSide(
          color: isDark ? Colors.grey[800]! : Colors.grey.shade100, 
          width: 1
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddEditLeadScreen(lead: lead),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                height: 48,
                width: 48,
                decoration: BoxDecoration(
                  color: _getStatusColor(lead.status).withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  _getStatusIcon(lead.status),
                  color: _getStatusColor(lead.status),
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      lead.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        // Text color adapts automatically, but we can enforce it
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.phone_outlined, size: 14, color: Colors.grey[500]),
                        const SizedBox(width: 4),
                        Text(
                          lead.contact,
                          style: TextStyle(color: Colors.grey[500], fontSize: 14),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              _StatusBadge(status: lead.status, color: _getStatusColor(lead.status)),
            ],
          ),
        ),
      ),
    );
  }


  Color _getStatusColor(String status) 
  {
    switch (status) 
    {
      case 'New': return Colors.blue;
      case 'Contacted': return Colors.orange;
      case 'Converted': return Colors.green;
      case 'Lost': return Colors.red;
      default: return Colors.grey;
    }
  }


  IconData _getStatusIcon(String status) 
  {
    switch (status) 
    {
      case 'New': return Icons.bolt;
      case 'Contacted': return Icons.perm_phone_msg;
      case 'Converted': return Icons.check_circle;
      case 'Lost': return Icons.cancel;
      default: return Icons.help_outline;
    }
  }
}


class _StatusBadge extends StatelessWidget 
{
  final String status;
  final Color color;
  const _StatusBadge({required this.status, required this.color});


  @override
  Widget build(BuildContext context) 
  {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15), // Slightly more visible in dark mode
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 12),
      ),
    );
  }
}