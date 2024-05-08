import 'dart:typed_data';

/// A profile of a user.
class Profile {
  /// Creates a new [Profile] instance.
  Profile({
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.address,
    this.profileImage,
  });

  /// The name of the user
  final String name;

  /// The email address of the user.
  final String email;

  /// The phone number of the user.
  final String phoneNumber;

  /// The address of the user.
  final String address;

  /// The profile image of the user.
  final Uint8List? profileImage;

  /// Creates a copy of this entity with the option to override values.
  Profile copyWith({
    String? id,
    String? name,
    String? email,
    String? phoneNumber,
    String? address,
    Uint8List? profileImage,
  }) {
    return Profile(
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      address: address ?? this.address,
      profileImage: profileImage ?? this.profileImage,
    );
  }
}
