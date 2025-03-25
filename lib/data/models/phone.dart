import 'package:iconnect_crm/domain/entity/phone.dart';

class Phone extends PhoneEntity {
  Phone({super.id, required super.color, required super.batteryStatus});

  Map<String, dynamic> toMap() => {
    'color': color,
    'battery_status': batteryStatus,
  };

  factory Phone.fromMap(Map<String, dynamic> json) => Phone(
    id: json['id'] as int,
    color: json['color'],
    batteryStatus: json['battery_status'],
  );
}
