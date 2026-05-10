class ItemModel {
  final String id;
  final String name;
  final String status;
  String lastWatered;
  bool isFavorite;
  final String imageUrl;
  final String waterAmount;
  final String sunlight;

  ItemModel({
    required this.id,
    required this.name,
    required this.status,
    required this.lastWatered,
    this.isFavorite = false,
    this.imageUrl = 'https://images.unsplash.com/photo-1485955900006-10f4d324d411...',
    this.waterAmount = 'متوسط',
    this.sunlight = 'إضاءة ساطعة غير مباشرة',
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'status': status,
      'lastWatered': lastWatered,
      'isFavorite': isFavorite,
      'imageUrl': imageUrl,
      'waterAmount': waterAmount,
      'sunlight': sunlight,
    };
  }

  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
      id: json['id'],
      name: json['name'],
      status: json['status'],
      lastWatered: json['lastWatered'],
      isFavorite: json['isFavorite'] ?? false,
      imageUrl: json['imageUrl'] ?? '...',
      waterAmount: json['waterAmount'] ?? 'متوسط',
      sunlight: json['sunlight'] ?? 'إضاءة ساطعة غير مباشرة',
    );
  }
}