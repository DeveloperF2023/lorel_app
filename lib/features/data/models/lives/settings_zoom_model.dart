import 'package:school_test_online/features/data/models/lives/continuous_meeting_chat.dart';

import 'approved_denied_countries_regions_model.dart';

class SettingsZoomModel {
  bool? hostVideo;
  bool? participantVideo;
  bool? cnMeeting;
  bool? inMeeting;
  bool? joinBeforeHost;
  int? jbhTime;
  bool? muteUponEntry;
  bool? watermark;
  bool? usePmi;
  int? approvalType;
  String? audio;
  String? autoRecording;
  bool? enforceLogin;
  String? enforceLoginDomains;
  String? alternativeHosts;
  bool? alternativeHostUpdatePolls;
  bool? closeRegistration;
  bool? showShareButton;
  bool? allowMultipleDevices;
  bool? registrantsConfirmationEmail;
  bool? waitingRoom;
  bool? requestPermissionToUnmuteParticipants;
  bool? registrantsEmailNotification;
  bool? meetingAuthentication;
  String? encryptionType;
  ApprovedOrDeniedCountriesOrRegionsModel? approvedOrDeniedCountriesOrRegions;
  ApprovedOrDeniedCountriesOrRegionsModel? breakoutRoom;
  bool? internalMeeting;
  ContinuousMeetingChatModel? continuousMeetingChats;
  bool? participantFocusedMeeting;
  bool? pushChangeToCalendar;
  bool? alternativeHostsEmailNotification;
  bool? showJoinInfo;
  bool? deviceTesting;
  bool? focusMode;
  bool? enableDedicatedGroupChat;
  bool? privateMeeting;
  bool? emailNotification;
  bool? hostSaveVideoOrder;
  ApprovedOrDeniedCountriesOrRegionsModel? signLanguageInterpretation;
  bool? emailInAttendeeReport;

  SettingsZoomModel(
      {this.hostVideo,
      this.participantVideo,
      this.cnMeeting,
      this.inMeeting,
      this.joinBeforeHost,
      this.jbhTime,
      this.muteUponEntry,
      this.watermark,
      this.usePmi,
      this.approvalType,
      this.audio,
      this.autoRecording,
      this.enforceLogin,
      this.enforceLoginDomains,
      this.alternativeHosts,
      this.alternativeHostUpdatePolls,
      this.closeRegistration,
      this.showShareButton,
      this.allowMultipleDevices,
      this.registrantsConfirmationEmail,
      this.waitingRoom,
      this.requestPermissionToUnmuteParticipants,
      this.registrantsEmailNotification,
      this.meetingAuthentication,
      this.encryptionType,
      this.approvedOrDeniedCountriesOrRegions,
      this.breakoutRoom,
      this.internalMeeting,
      this.continuousMeetingChats,
      this.participantFocusedMeeting,
      this.pushChangeToCalendar,
      this.alternativeHostsEmailNotification,
      this.showJoinInfo,
      this.deviceTesting,
      this.focusMode,
      this.enableDedicatedGroupChat,
      this.privateMeeting,
      this.emailNotification,
      this.hostSaveVideoOrder,
      this.signLanguageInterpretation,
      this.emailInAttendeeReport});

  factory SettingsZoomModel.fromJson(Map<String, dynamic> json) {
    return SettingsZoomModel(
      hostVideo: json['host_video'],
      participantVideo: json['participant_video'],
      cnMeeting: json['cn_meeting'],
      inMeeting: json['in_meeting'],
      joinBeforeHost: json['join_before_host'],
      jbhTime: json['jbh_time'],
      muteUponEntry: json['mute_upon_entry'],
      watermark: json['watermark'],
      usePmi: json['use_pmi'],
      approvalType: json['approval_type'],
      audio: json['audio'],
      autoRecording: json['auto_recording'],
      enforceLogin: json['enforce_login'],
      enforceLoginDomains: json['enforce_login_domains'],
      alternativeHosts: json['alternative_hosts'],
      alternativeHostUpdatePolls: json['alternative_host_update_polls'],
      closeRegistration: json['close_registration'],
      showShareButton: json['show_share_button'],
      allowMultipleDevices: json['allow_multiple_devices'],
      registrantsConfirmationEmail: json['registrants_confirmation_email'],
      waitingRoom: json['waiting_room'],
      requestPermissionToUnmuteParticipants:
          json['request_permission_to_unmute_participants'],
      registrantsEmailNotification: json['registrants_email_notification'],
      meetingAuthentication: json['meeting_authentication'],
      encryptionType: json['encryption_type'],
      approvedOrDeniedCountriesOrRegions:
          json['approved_or_denied_countries_or_regions'] != null
              ? ApprovedOrDeniedCountriesOrRegionsModel.fromJson(
                  json['approved_or_denied_countries_or_regions'])
              : null,
      breakoutRoom: json['breakout_room'] != null
          ? ApprovedOrDeniedCountriesOrRegionsModel.fromJson(
              json['breakout_room'])
          : null,
      internalMeeting: json['internal_meeting'],
      continuousMeetingChats: json['continuous_meeting_chat'] != null
          ? ContinuousMeetingChatModel.fromJson(json['continuous_meeting_chat'])
          : null,
      participantFocusedMeeting: json['participant_focused_meeting'],
      pushChangeToCalendar: json['push_change_to_calendar'],
      alternativeHostsEmailNotification:
          json['alternative_hosts_email_notification'],
      showJoinInfo: json['show_join_info'],
      deviceTesting: json['device_testing'],
      focusMode: json['focus_mode'],
      enableDedicatedGroupChat: json['enable_dedicated_group_chat'],
      privateMeeting: json['private_meeting'],
      emailNotification: json['email_notification'],
      hostSaveVideoOrder: json['host_save_video_order'],
      signLanguageInterpretation: json['sign_language_interpretation'] != null
          ? ApprovedOrDeniedCountriesOrRegionsModel.fromJson(
              json['sign_language_interpretation'])
          : null,
      emailInAttendeeReport: json['email_in_attendee_report'],
    );
  }
}
