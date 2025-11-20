import '../models/lead_model.dart';
import '../providers/database_helper.dart';


class LeadRepository 
{
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  Future<List<Lead>> getLeads() async 
  {
    return await _dbHelper.readAllLeads();
  }

  Future<void> addLead(Lead lead) async 
  {
    await _dbHelper.create(lead);
  }

  Future<void> updateLead(Lead lead) async 
  {
    await _dbHelper.update(lead);
  }

  Future<void> deleteLead(int id) async 
  {
    await _dbHelper.delete(id);
  }
}