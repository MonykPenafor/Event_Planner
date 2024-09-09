enum EventType {
  weddingEvent,
  birthdayParty,
  corporateMeeting,
  other,
}

extension EventTypeExtension on EventType {
  String get description {
    switch (this) {
      case EventType.weddingEvent:
        return 'Wedding';
      case EventType.birthdayParty:
        return 'Birthday Party';
      case EventType.corporateMeeting:
        return 'Corporate Meeting';
      case EventType.other:
        return 'Other';
      default:
        return '';
    }
  }


}