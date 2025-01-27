import 'dart:io';



abstract class ProfileUpdateEvent {}

class UploadImageEvent extends ProfileUpdateEvent {
  final File imagePath;
  UploadImageEvent(this.imagePath);
}

class AddDetailsEvent extends ProfileUpdateEvent {
  final String id;
  final String name;
  final String number;
  final String? imageUrl;
  AddDetailsEvent({required this.id,required this.name,required this.number,this.imageUrl});
}
