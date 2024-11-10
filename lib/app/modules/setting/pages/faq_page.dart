import 'package:flutter/material.dart';
import 'package:frontend_mobile_tugasbesar/app/utils/themes/color.dart';

class FaqPage extends StatefulWidget {
  const FaqPage({Key? key}) : super(key: key);

  @override
  State<FaqPage> createState() => _FaqState();
}

class _FaqState extends State<FaqPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        leading: Padding(
          padding: const EdgeInsets.only(left: 30),
          child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              )),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColors.mainColor,
        child: const Icon(
          Icons.chat_rounded,
          color: Colors.white,
        )
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Container(
              height: 130,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.mainColor,
                    AppColors.secondaryColor,
                    AppColors.mainColor,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 90),
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(35),
                  topRight: Radius.circular(35),
                ),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 5,
                      spreadRadius: 1,
                      offset: const Offset(0, -2)),
                ],
              ),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    child: const Text(
                      'FAQ',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildFaqTile(
                    question: 'Apa itu SkinAssist?',
                    answer:
                        'SkinAssist adalah aplikasi mobile berbasis AI yang menganalisis kondisi kulit Anda, khususnya dalam mendeteksi jerawat, serta memberikan rekomendasi perawatan sesuai kebutuhan kulit.',
                  ),
                  _buildFaqTile(
                    question: 'Bagaimana cara menggunakan SkinAssist?',
                    answer:
                        'Untuk menggunakan SkinAssist, Anda dapat:\n1. Masuk atau daftar akun.\n2. Ambil foto kulit menggunakan kamera atau unggah foto dari galeri.\n3. Aplikasi akan menganalisis foto dan memberikan hasil deteksi jerawat beserta rekomendasi perawatan.\n4. Lacak perkembangan kondisi kulit Anda dari waktu ke waktu.',
                  ),
                  _buildFaqTile(
                    question:
                        'Apakah SkinAssist aman untuk digunakan dan melindungi privasi saya?',
                    answer:
                        'Ya, kami menjaga keamanan data Anda dengan baik. Foto dan informasi pribadi Anda aman dan tidak akan dibagikan kepada pihak ketiga tanpa persetujuan Anda.',
                  ),
                  _buildFaqTile(
                    question:
                        'Bagaimana cara meningkatkan akurasi deteksi jerawat di SkinAssist?',
                    answer:
                        'Pastikan untuk mengambil foto dalam pencahayaan yang baik, fokus pada area kulit yang ingin dianalisis, dan gunakan kamera dengan resolusi yang tinggi untuk hasil terbaik.',
                  ),
                  _buildFaqTile(
                    question:
                        'Apakah SkinAssist menggantikan konsultasi dokter kulit?',
                    answer:
                        'SkinAssist adalah alat bantu yang dapat membantu memahami kondisi kulit, namun hasilnya tidak menggantikan konsultasi dokter kulit. Untuk kondisi kulit yang serius atau tidak membaik, sebaiknya konsultasi dengan dokter kulit.',
                  ),
                  _buildFaqTile(
                    question:
                        'Apa yang harus saya lakukan jika aplikasi tidak berfungsi dengan baik?',
                    answer:
                        'Jika mengalami masalah, coba periksa koneksi internet, pastikan aplikasi dalam versi terbaru, atau restart aplikasi. Jika masalah tetap terjadi, hubungi dukungan melalui fitur Support di aplikasi.',
                  ),
                  _buildFaqTile(
                    question: 'Apakah SkinAssist gratis atau berbayar?',
                    answer:
                        'SkinAssist menawarkan versi gratis untuk fitur dasar. Untuk akses ke fitur premium, seperti konsultasi ahli dan rekomendasi perawatan khusus, tersedia opsi berlangganan melalui aplikasi.',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFaqTile({required String question, required String answer}) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey[300]!,
            width: 1,
          ),
        ),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: EdgeInsets.zero,
          title: Text(
            question,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Text(answer),
            ),
          ],
        ),
      ),
    );
  }
}
