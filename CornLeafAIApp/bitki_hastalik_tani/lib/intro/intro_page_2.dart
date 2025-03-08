import 'package:flutter/material.dart';

class IntroPage2 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.lightGreen.shade50,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              Icons.upload,
              size: 100,
              color: Colors.green,
            ),
            SizedBox(height: 20),
            Text(
              'Nasıl Kullanılır?',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(
              '1. Yaprak resmini yükleyin.\n2. Analizi başlatın.\n3. Sonuçları görüntüleyin.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}