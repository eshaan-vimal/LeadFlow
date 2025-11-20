import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/lead_repository.dart';
import '../../data/models/lead_model.dart';
import 'lead_event.dart';
import 'lead_state.dart';


class LeadBloc extends Bloc<LeadEvent, LeadState> 
{
  final LeadRepository _repository;

  LeadBloc({required LeadRepository repository})
      : _repository = repository, super(const LeadState()) 
  {  
    on<LoadLeads>(_onLoadLeads);
    on<AddLead>(_onAddLead);
    on<UpdateLead>(_onUpdateLead);
    on<DeleteLead>(_onDeleteLead);
    on<FilterLeads>(_onFilterLeads);
  }


  Future<void> _onLoadLeads(LoadLeads event, Emitter<LeadState> emit) async 
  {
    emit(state.copyWith(status: LeadStatus.loading));
    try 
    {
      final leads = await _repository.getLeads();
      emit(state.copyWith(
        status: LeadStatus.success,
        allLeads: leads,
        // On load, re-apply the current status filter
        visibleLeads: _applyFilters(leads, state.filter),
      ));
    } 
    catch (e) 
    {
      emit(state.copyWith(status: LeadStatus.failure, errorMessage: e.toString()));
    }
  }


  Future<void> _onAddLead(AddLead event, Emitter<LeadState> emit) async 
  {
    try 
    {
      await _repository.addLead(event.lead);
      add(LoadLeads());
    } 
    catch (e) 
    {
      emit(state.copyWith(status: LeadStatus.failure, errorMessage: "Failed to add lead"));
    }
  }


  Future<void> _onUpdateLead(UpdateLead event, Emitter<LeadState> emit) async 
  {
    try 
    {
      await _repository.updateLead(event.lead);
      add(LoadLeads());
    } 
    catch (e) 
    {
      emit(state.copyWith(status: LeadStatus.failure, errorMessage: "Failed to update lead"));
    }
  }


  Future<void> _onDeleteLead(DeleteLead event, Emitter<LeadState> emit) async 
  {
    try 
    {
      await _repository.deleteLead(event.id);
      add(LoadLeads());
    } 
    catch (e) 
    {
      emit(state.copyWith(status: LeadStatus.failure, errorMessage: "Failed to delete lead"));
    }
  }


  void _onFilterLeads(FilterLeads event, Emitter<LeadState> emit) 
  {
    final filtered = _applyFilters(state.allLeads, event.status);
    emit(state.copyWith(filter: event.status, visibleLeads: filtered));
  }


  List<Lead> _applyFilters(List<Lead> leads, String statusFilter) 
  {
    if (statusFilter == 'All') return leads;
    return leads.where((lead) => lead.status == statusFilter).toList();
  }
}