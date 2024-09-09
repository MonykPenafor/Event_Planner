enum PaymentTypes {
  venueRental,
  catering,
  decoration,
  entertainment,
}

extension PaymentTypesExtension on PaymentTypes {
  String get description {
    switch (this) {
      case PaymentTypes.venueRental:
        return 'Venue Rental';
      case PaymentTypes.catering:
        return 'Catering';
      case PaymentTypes.decoration:
        return 'Decoration';
      case PaymentTypes.entertainment:
        return 'Entertainment';
      default:
        return '';
    }
  }
}