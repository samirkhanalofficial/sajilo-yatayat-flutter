import 'package:json_annotation/json_annotation.dart';
import 'package:tryapp/models/user_details.dart';
part 'bus_details.g.dart';

@JsonSerializable()
class BusDetails {
  @JsonKey(name: '_id')
  String id;
  String busnumber, yatayat, bustype, timestamp;
  int leftSeats, rightSeats, lastSeats;
  double balance;
  List<String> images, features;
  List<UserDetails> owners;

  BusDetails({
    required this.id,
    required this.busnumber,
    required this.yatayat,
    required this.bustype,
    required this.leftSeats,
    required this.rightSeats,
    required this.lastSeats,
    required this.images,
    required this.features,
    required this.owners,
    required this.timestamp,
    required this.balance,
  });
  factory BusDetails.fromJson(Map<String, dynamic> json) =>
      _$BusDetailsFromJson(json);
  Map<String, dynamic> toJson() => _$BusDetailsToJson(this);
}
