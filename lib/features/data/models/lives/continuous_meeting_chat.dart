class ContinuousMeetingChatModel {
  bool? enable;
  bool? autoAddInvitedExternalUsers;
  bool? autoAddMeetingParticipants;

  ContinuousMeetingChatModel(
      {this.enable,
      this.autoAddInvitedExternalUsers,
      this.autoAddMeetingParticipants});
  factory ContinuousMeetingChatModel.fromJson(Map<String, dynamic> json) {
    return ContinuousMeetingChatModel(
      enable: json['enable'],
      autoAddInvitedExternalUsers: json['auto_add_invited_external_users'],
      autoAddMeetingParticipants: json['auto_add_meeting_participants'],
    );
  }
}
