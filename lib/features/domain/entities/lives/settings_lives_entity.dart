import 'package:equatable/equatable.dart';
import 'package:school_test_online/features/domain/entities/lives/approved_denied_countries_regions_entity.dart';
import 'package:school_test_online/features/domain/entities/lives/continuous_meeting_chat.dart';

class SettingsLivesEntity extends Equatable {
  final bool? hostVideo;
  final bool? participantVideo;
  final bool? cnMeeting;
  final bool? inMeeting;
  final bool? joinBeforeHost;
  final int? jbhTime;
  final bool? muteUponEntry;
  final bool? watermark;
  final bool? usePmi;
  final int? approvalType;
  final String? audio;
  final String? autoRecording;
  final bool? enforceLogin;
  final String? enforceLoginDomains;
  final String? alternativeHosts;
  final bool? alternativeHostUpdatePolls;
  final bool? closeRegistration;
  final bool? showShareButton;
  final bool? allowMultipleDevices;
  final bool? registrantsConfirmationEmail;
  final bool? waitingRoom;
  final bool? requestPermissionToUnmuteParticipants;
  final bool? registrantsEmailNotification;
  final bool? meetingAuthentication;
  final String? encryptionType;
  final ApprovedOrDeniedCountriesOrRegions? approvedOrDeniedCountriesOrRegions;
  final ApprovedOrDeniedCountriesOrRegions? breakoutRoom;
  final bool? internalMeeting;
  final ContinuousMeetingChat? continuousMeetingChat;
  final bool? participantFocusedMeeting;
  final bool? pushChangeToCalendar;
  final List<Null>? resources;
  final bool? alternativeHostsEmailNotification;
  final bool? showJoinInfo;
  final bool? deviceTesting;
  final bool? focusMode;
  final List<Null>? meetingInvitees;
  final bool? enableDedicatedGroupChat;
  final bool? privateMeeting;
  final bool? emailNotification;
  final bool? hostSaveVideoOrder;
  final ApprovedOrDeniedCountriesOrRegions? signLanguageInterpretation;
  final bool? emailInAttendeeReport;

  SettingsLivesEntity(
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
      this.continuousMeetingChat,
      this.participantFocusedMeeting,
      this.pushChangeToCalendar,
      this.resources,
      this.alternativeHostsEmailNotification,
      this.showJoinInfo,
      this.deviceTesting,
      this.focusMode,
      this.meetingInvitees,
      this.enableDedicatedGroupChat,
      this.privateMeeting,
      this.emailNotification,
      this.hostSaveVideoOrder,
      this.signLanguageInterpretation,
      this.emailInAttendeeReport});
  @override
  // TODO: implement props
  List<Object?> get props => [
        hostVideo,
        participantVideo,
        cnMeeting,
        inMeeting,
        joinBeforeHost,
        jbhTime,
        muteUponEntry,
        watermark,
        usePmi,
        approvalType,
        audio,
        autoRecording,
        enforceLogin,
        enforceLoginDomains,
        alternativeHosts,
        alternativeHostUpdatePolls,
        closeRegistration,
        showShareButton,
        allowMultipleDevices,
        registrantsConfirmationEmail,
        waitingRoom,
        requestPermissionToUnmuteParticipants,
        registrantsEmailNotification,
        meetingAuthentication,
        encryptionType,
        approvedOrDeniedCountriesOrRegions,
        breakoutRoom,
        internalMeeting,
        continuousMeetingChat,
        participantFocusedMeeting,
        pushChangeToCalendar,
        resources,
        alternativeHostsEmailNotification,
        showJoinInfo,
        deviceTesting,
        focusMode,
        meetingInvitees,
        enableDedicatedGroupChat,
        privateMeeting,
        emailNotification,
        hostSaveVideoOrder,
        signLanguageInterpretation,
        emailInAttendeeReport
      ];
}
