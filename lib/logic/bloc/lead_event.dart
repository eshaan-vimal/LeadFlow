import 'package:equatable/equatable.dart';
import '../../data/models/lead_model.dart';


abstract class LeadEvent extends Equatable 
{
  const LeadEvent();

  @override
  List<Object> get props => [];
}


class LoadLeads extends LeadEvent {}


class AddLead extends LeadEvent 
{
  final Lead lead;

  const AddLead(this.lead);

  @override
  List<Object> get props => [lead];
}


class UpdateLead extends LeadEvent 
{
  final Lead lead;

  const UpdateLead(this.lead);

  @override
  List<Object> get props => [lead];
}


class DeleteLead extends LeadEvent 
{
  final int id;

  const DeleteLead(this.id);

  @override
  List<Object> get props => [id];
}


class FilterLeads extends LeadEvent 
{
  final String status;

  const FilterLeads(this.status);
  
  @override
  List<Object> get props => [status];
}
