import 'package:equatable/equatable.dart';
import '../../data/models/lead_model.dart';


enum LeadStatus { initial, loading, success, failure }


class LeadState extends Equatable 
{
  final LeadStatus status;
  final List<Lead> allLeads;      // Master list
  final List<Lead> visibleLeads;  // List shown on Home Screen (filtered by Status)
  final String filter;            // Current Status Filter
  final String? errorMessage;


  const LeadState({
    this.status = LeadStatus.initial,
    this.allLeads = const [],
    this.visibleLeads = const [],
    this.filter = 'All',
    this.errorMessage,
  });


  LeadState copyWith({
    LeadStatus? status,
    List<Lead>? allLeads,
    List<Lead>? visibleLeads,
    String? filter,
    String? errorMessage,
  }) 
  {
    return LeadState(
      status: status ?? this.status,
      allLeads: allLeads ?? this.allLeads,
      visibleLeads: visibleLeads ?? this.visibleLeads,
      filter: filter ?? this.filter,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }


  @override
  List<Object?> get props => [status, allLeads, visibleLeads, filter, errorMessage];
}