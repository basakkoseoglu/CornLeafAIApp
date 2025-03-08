import 'package:flutter/material.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFFE9F5DB),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Yeşil alanın üzerine başlık ekleniyor
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Text(
                      'Yaprak Sağlığı ve Çözümler',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF505C45),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                // Hastalık Bilgileri ve Tedaviler
                _buildDiseaseSolutionCard(
                  context,
                  'Kahverengi Leke',
                  'Bu hastalık yapraklarda kahverengi lekeler oluşturur. Nemli hava koşullarında yaygın görülür.',
                  'Çözüm: Düzenli havalandırma sağlayın. Mancozeb veya Chlorothalonil içeren fungisitler kullanabilirsiniz.',
                  'Önleme: Bitkiler arasındaki mesafeyi artırarak hava sirkülasyonunu geliştirin ve düzenli bakım yapın.',
                  'assets/kahve.jpg',
                ),
                _buildDiseaseSolutionCard(
                  context,
                  'Yaprak İsi',
                  'Yaprak yüzeyinde siyah, isli bir tabaka oluşur. Genellikle mantar enfeksiyonundan kaynaklanır.',
                  'Çözüm: Fungisit ilaçları kullanın ve etkilenen yaprakları budayın.',
                  'Önleme: Bitkilerde böcek kontrolü sağlayarak mantar oluşumunu engelleyebilirsiniz.',
                  'assets/yaprakisi.jpg',
                ),
                _buildDiseaseSolutionCard(
                  context,
                  'Bakteriyel Yaprak Yanıklığı',
                  'Yaprak kenarlarında sararma ve kahverengi yanıklık belirtileri görülür.',
                  'Çözüm: Bakır bazlı bakterisitler kullanın ve enfekte olmuş yaprakları temizleyin.',
                  'Önleme: Drenajı iyileştirin ve aşırı sulamadan kaçının.',
                  'assets/bakteri.jpg',
                ),
                const SizedBox(height: 20),
                // Tarım ve Bakım İpuçları
                const Text(
                  'Sağlıklı Yapraklar için İpuçları',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                _buildTipsSection(),
                const SizedBox(height: 20),
                // Geri Bildirim
                const Text(
                  'Geri Bildirim ve Öneriler',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Geri Bildirim'),
                        content: const TextField(
                          decoration: InputDecoration(
                            hintText:
                                'Önerilerinizi veya geri bildiriminizi buraya yazın...',
                          ),
                          maxLines: 5,
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text('Gönder'),
                          ),
                        ],
                      ),
                    );
                  },
                  child: const Text('Geri Bildirim Gönder'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDiseaseSolutionCard(
    BuildContext context,
    String title,
    String description,
    String solution,
    String prevention,
    String imagePath,
  ) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ExpansionTile(
        leading:
            Image.asset(imagePath, width: 50, height: 50, fit: BoxFit.cover),
        title: Text(title),
        subtitle: Text(description),
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Çözüm:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(solution),
                const SizedBox(height: 10),
                Text(
                  'Önleme:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(prevention),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTipsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          '1. Yapraklara zarar verebilecek böcekleri düzenli kontrol edin ve doğal ilaçlar kullanın.',
        ),
        SizedBox(height: 5),
        Text(
          '2. Sulama miktarını kontrol edin ve fazla nemden kaçının.',
        ),
        SizedBox(height: 5),
        Text(
          '3. Bitkiler arasında yeterli mesafeyi koruyarak hava dolaşımını iyileştirin.',
        ),
        SizedBox(height: 5),
        Text(
          '4. Düzenli olarak gübreleme yaparak bitkinin bağışıklığını güçlendirin.',
        ),
      ],
    );
  }
}
