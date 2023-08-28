part of 'add_permit_bloc.dart';

class AddPermitEvent {
  final String studentId;
  final String permitType;
  final DateTime dateStart;
  final DateTime dateEnd;
  final String notes;

  AddPermitEvent({
    required this.studentId,
    required this.permitType,
    required this.dateStart,
    required this.dateEnd,
    required this.notes,
  });
}
