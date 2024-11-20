import 'package:equatable/equatable.dart';

class ContinuousMeetingChat extends Equatable {
  final bool? enable;
  final bool? autoAddInvitedExternalUsers;
  final bool? autoAddMeetingParticipants;

  const ContinuousMeetingChat(
      {this.enable,
      this.autoAddInvitedExternalUsers,
      this.autoAddMeetingParticipants});
  @override
  // TODO: implement props
  List<Object?> get props =>
      [enable, autoAddInvitedExternalUsers, autoAddMeetingParticipants];
}
