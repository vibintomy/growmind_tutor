import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class Cloudinary {
  final String cloudName;
  final String apiKey;
  final String apiSecret;

  Cloudinary(
      {required this.cloudName, required this.apiKey, required this.apiSecret});

  factory Cloudinary.signedConfig(
      {required String cloudName,
      required String apiKey,
      required String apiSecret}) {
    return Cloudinary(
        cloudName: cloudName, apiKey: apiKey, apiSecret: apiSecret);
  }

  Future<String> uploadFile(File file, {String? resourceType}) async {
    final extension = file.path.split('.').last.toLowerCase();

    final resourceType = (extension == 'pdf') ? 'raw' : 'image';

    final request = http.MultipartRequest(
      'POST',
      Uri.parse('https://api.cloudinary.com/v1_1/dj01ka9ga/$resourceType/upload'),
    )
      ..fields['upload_preset'] = 'document_preset'
      ..fields['api_key'] = apiKey
      ..fields['timestamp'] = DateTime.now().millisecondsSinceEpoch.toString()
      ..files.add(await http.MultipartFile.fromPath('file', file.path));

    final response = await request.send();

    if (response.statusCode == 200) {
      final responseData = await response.stream.bytesToString();
      final data = json.decode(responseData);
      return data['secure_url'];
    } else {
      throw Exception(
          'Failed to upload file to Cloudinary: ${response.statusCode}');
    }
  }

  Future<String> uploadImage(File imageFile) async {
    return await uploadFile(imageFile, resourceType: 'image');
  }

  Future<String> uploadPdf(File pdfFile) async {
    return await uploadFile(pdfFile, resourceType: 'raw');
  }
}


