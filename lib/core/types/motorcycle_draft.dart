class MotorcycleDraft {
  const MotorcycleDraft({
    required this.brand,
    required this.model,
    required this.year,
    required this.plateNumber,
    required this.odometerKm,
    this.nickname = '',
    this.hasPhoto = false,
  });

  const MotorcycleDraft.empty()
    : brand = '',
      model = '',
      year = '',
      plateNumber = '',
      odometerKm = 0,
      nickname = '',
      hasPhoto = false;

  final String brand;
  final String model;
  final String year;
  final String plateNumber;
  final int odometerKm;
  final String nickname;
  final bool hasPhoto;
}
