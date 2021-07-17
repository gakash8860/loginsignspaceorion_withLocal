// part of 'modeldefine.dart';
//
// // **************************************************************************
// // JsonSerializableGenerator
// // **************************************************************************
//
// import 'modeldefine.dart';
//
// // User _$usermodelFromJson(Map<String, dynamic> json) {
// //   return User(
// //     id: json['id'] as int,
// //     password: json['password'] as String,
// //     user_permissions: json['user_permissions'] as List,
// //     username: json['username'] as String,
// //     first_name: json['first_name'] as String,
// //     last_login: json['last_login'] as bool,
// //     date_joined: json['date_joined'] as String,
// //     email: json['email'] as String,
// //     groups: json['groups'] as List,
// //     is_active: json['is_active'] as bool,
// //     is_staff: json['is_staff'] as bool,
// //     is_superuser: json['is_superuser'] as bool,
// //     last_name: json['last_name'] as String,
// //   );
// // }
// //
// // Map<String, dynamic> _$usermodelToJson(User instance) => <String, dynamic>{
// //
// //   'password': instance.password1,
// //   'username': instance.username,
// //   'first_name': instance.first_name,
// //   'last_name': instance.last_name,
// //   'email': instance.email,
// //   'date_joined': instance.date_joined,
// //   'last_login': instance.last_login,
// //   'is_superuser': instance.is_superuser,
// //   'is_staff': instance.is_staff,
// //   'is_active': instance.is_active,
// //   'groups': instance.groups,
// //   'user_permissions': instance.user_permissions,
// // };
//
// // ignore: non_constant_identifier_names
// PlaceType _$place_typeFromJson(Map<String, dynamic> json) {
//   return PlaceType(
//
//     pId: json['p_id'] as String,
//     pType: json['p_type'] as String,
//     user: json['user'] as int,
//   );
// }
//
// // ignore: non_constant_identifier_names
// Map<String, dynamic> _$place_typeToJson(PlaceType instance) =>
//     <String, dynamic>{
//       'user': instance.user,
//
//       'p_id': instance.pId,
//       'p_type': instance.pType,
//     };
//
// FloorType _$floorFromJson(Map<String, dynamic> json) {
//   return FloorType(
//
//     json['user'] == null
//         ? null
//         : User.fromJson(json['user'] as Map<String, dynamic>),
//     json['p_id'] == null
//         ? null
//         : PlaceType.fromJson(json['p_id'] as Map<String, dynamic>),
//     json['f_id'] as String,
//     json['f_name'] as String,
//   );
// }
//
// Map<String, dynamic> _$floorToJson(FloorType instance) => <String, dynamic>{
//   'id': instance.id,
//   'user': instance.user?.toJson(),
//   'p_id': instance.pId?.toJson(),
//   'f_id': instance.fId,
//   'f_name': instance.fName,
// };
//
// Room _$roomFromJson(Map<String, dynamic> json) {
//   return Room(
//     json['f_id'] == null
//         ? null
//         : FloorType.fromJson(json['f_id']  as Map<String, dynamic>),
//     json['user'] == null
//         ? null
//         : Usermodel.fromJson(json['user'] as Map<String, dynamic>),
//     json['r_id'] as String,
//     json['r_name'] as String,
//   );
// }
//
// Map<String, dynamic> _$roomToJson(Room instance) => <String, dynamic>{
//   'user': instance.user?.toJson(),
//   'f_id': instance.fId?.toJson(),
//   'r_id': instance.rId,
//   'r_name': instance.rName,
// };
//
// Device _$deviceFromJson(Map<String, dynamic> json) {
//   return Device(
//     rId: json['r_id'] == null
//         ? null
//         : Room.fromJson(json['r_id'] as Map<String, dynamic>),
//     user: json['user'] == null
//         ? null
//         : Usermodel.fromJson(json['user'] as Map<String, dynamic>),
//     dId: json['d_id'] as String,
//     dateInstalled: json['date_installed'] as String,
//   );
// }
//
// Map<String, dynamic> _$deviceToJson(Device instance) => <String, dynamic>{
//
//   'user': instance.user?.toJson(),
//   'r_id': instance.rId?.toJson(),
//   'd_id': instance.dId,
//   'date_installed': instance.dateInstalled,
// };