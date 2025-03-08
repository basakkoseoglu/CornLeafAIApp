import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HerbPage extends StatefulWidget {
  const HerbPage({Key? key}) : super(key: key);

  @override
  State<HerbPage> createState() => _HerbPageState();
}

class _HerbPageState extends State<HerbPage> {
  File? _image;
  String? _result;
  bool _isLoading = false;
  final ImagePicker _picker = ImagePicker();

  // Fotoğraf Çekme
  Future<void> _pickImageFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        _result = null;
      });
    }
  }

  // Galeriden Fotoğraf Seçme
  Future<void> _pickImageFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        _result = null;
      });
    }
  }

  // Tahmin Yapma
  Future<void> _uploadImage() async {
    if (_image == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Lütfen bir görüntü seçin!')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final uri = Uri.parse('http://172.20.10.3:5000/predict');
    final request = http.MultipartRequest('POST', uri);
    request.files.add(await http.MultipartFile.fromPath('file', _image!.path));

    try {
      final response = await request.send();
      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        final jsonResponse = json.decode(responseData);
        setState(() {
          _result = jsonResponse['prediction'];
        });
      } else {
        setState(() {
          _result = 'Bir hata oluştu: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        _result = 'Hata: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFFE9F5DB),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // "Bitkinizi Tarayın" Başlığı
              Text(
                'Bitki Analizi ',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF505C45),
                ),
              ),
              const SizedBox(height: 75),

              // Görüntü Önizleme
              Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 3,
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: _image == null
                    ? Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: const [
                            Icon(
                              Icons.image,
                              size: 90,
                              weight: 50,
                              color: Colors.grey,
                            ),
                            SizedBox(height: 45),
                            Text(
                              'Henüz bir fotoğraf seçilmedi.',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.grey),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.file(
                          _image!,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                      ),
              ),
              const SizedBox(height: 30),

              // Fotoğraf Seçme Butonları
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: _pickImageFromCamera,
                    icon: const Icon(Icons.camera_alt),
                    label: const Text('Fotoğraf Çek'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF718355),
                      minimumSize: const Size(140, 50),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: _pickImageFromGallery,
                    icon: const Icon(Icons.photo),
                    label: const Text('Galeriden Seç'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF718355),
                      minimumSize: const Size(140, 50),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Tahmin Yap Butonu
              ElevatedButton.icon(
                onPressed: _uploadImage,
                icon: const Icon(Icons.cloud_upload),
                label: const Text('Tahmin Yap'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF505C45),
                  minimumSize: const Size(double.infinity, 50),
                ),
              ),
              const SizedBox(height: 20),

              // Yükleme Göstergesi veya Tahmin Sonucu
              if (_isLoading)
                const CircularProgressIndicator()
              else if (_result != null)
                Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        const Text(
                          'Tahmin Sonucu:',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          _result!,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
