class MotorcycleData {
  const MotorcycleData({
    required this.brand,
    required this.model,
    required this.plateNumber,
    required this.odometerKm,
    this.imageAsset,
    this.isActive = false,
  });

  final String brand;
  final String model;
  final String plateNumber;
  final int odometerKm;
  final String? imageAsset;
  final bool isActive;
}
