import 'package:flutter/material.dart';

class LocationInfo {
  final String location, name;
  LocationInfo(this.location, this.name);
}

class BarberShop {
  final String name, location, rating, image;
  BarberShop(this.name, this.location, this.rating, this.image);
}

class CommonStyle {
  static TextStyle textStyle14(Color color) => TextStyle(
    fontFamily: 'Plus Jakarta Sans', fontSize: 14, color: color,
  );
  static TextStyle textStyle16Bold() => const TextStyle(
    fontFamily: 'Plus Jakarta Sans', fontWeight: FontWeight.w700, fontSize: 16,
  );
  static TextStyle textStyle18Bold() => const TextStyle(
    fontFamily: 'Plus Jakarta Sans', fontWeight: FontWeight.w700, fontSize: 18,
  );
}

class ReusableImage extends StatelessWidget {
  final String image;
  final double width, height;
  final BoxFit fit;
  const ReusableImage({super.key, required this.image, this.width = 40, this.height = 40, this.fit = BoxFit.cover});
  @override
  Widget build(BuildContext context) {
    return ClipRRect(borderRadius: BorderRadius.circular(8), child: Image.asset(image, width: width, height: height, fit: fit));
  }
}

class InfoCard extends StatelessWidget {
  final String location, name;
  final Widget? trailing;
  const InfoCard({super.key, required this.location, required this.name, this.trailing});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 339, height: 80,
      child: Stack(
        children: [
          Positioned(left: 16, top: 16, bottom: 16, child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  const ReusableImage(image: 'images/location.png', width: 16, height: 16),
                  const SizedBox(width: 8),
                  Text(location, style: CommonStyle.textStyle14(const Color(0xFF6B7280))),
                ],
              ),
              const SizedBox(height: 4),
              Text(name, style: CommonStyle.textStyle16Bold()),
            ],
          )),
          if (trailing != null) Positioned(right: 16, top: 16, bottom: 16, child: trailing!),
        ],
      ),
    );
  }
}

class HomeCard extends StatelessWidget {
  const HomeCard({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 339, height: 225,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.orange),
      child: Stack(
        children: [
          Positioned(top: 0, left: 0, right: 0, child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset('images/homepage-background.png', width: 339, height: 250, fit: BoxFit.cover),
          )),
          Positioned(top: 56, left: 100, child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset('images/homepage.png', width: 339, height: 220, fit: BoxFit.cover),
          )),
          Positioned(bottom: 16, left: 16, child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: const Color.fromRGBO(54, 48, 98, 1)),
            child: const Text('Booking Now', style: TextStyle(color: Colors.white, fontFamily: 'Plus Jakarta Sans', fontSize: 14)),
          )),
        ],
      ),
    );
  }
}

class BarberShopCard extends StatelessWidget {
  final BarberShop shop;
  final bool isFirst;
  const BarberShopCard(this.shop, {super.key, this.isFirst = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: SizedBox(
        width: 300,
        child: isFirst
            ? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ReusableImage(image: shop.image, width: 340, height: 240),
            const SizedBox(height: 12),
            Text(shop.name, style: CommonStyle.textStyle16Bold()),
            const SizedBox(height: 4),
            _buildPropertyRow(Icons.location_on, shop.location),
            _buildPropertyRow(Icons.star, shop.rating),
          ],
        )
            : Row(
          children: [
            ReusableImage(image: shop.image, width: 100, height: 100),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(shop.name, style: CommonStyle.textStyle16Bold()),
                  const SizedBox(height: 4),
                  _buildPropertyRow(Icons.location_on, shop.location),
                  _buildPropertyRow(Icons.star, shop.rating),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPropertyRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16, color: const Color(0xFF6B7280)),
        const SizedBox(width: 4),
        Text(text, style: CommonStyle.textStyle14(const Color(0xFF6B7280))),
      ],
    );
  }
}
class NearestBarbershopList extends StatelessWidget {
  final List<BarberShop> barbershops = [
    BarberShop('Alana BarberShop', 'Bangutapan (5 km)', '4.5', 'images/Alana.png'),
    BarberShop('Hercha Barbershop', 'Jalan Kaliurang (8 km)', '5', 'images/Hercha.png'),
    BarberShop('Barberking', 'Jogja Center (12 km)', '4.5', 'images/Barberking.png'),
  ];

  NearestBarbershopList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Nearest Barbershops', style: CommonStyle.textStyle18Bold()),
        const SizedBox(height: 12),

        Column(
          children: List.generate(barbershops.length, (index) {
            return _buildBarberShopItem(
              barbershops[index].name,
              barbershops[index].location,
              barbershops[index].rating,
              barbershops[index].image,
              false
            );
          }),
        ),

        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: const BorderSide(color: Color(0xFF36362E), width: 1),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('See All', style: CommonStyle.textStyle16Bold().copyWith(color: const Color(0xFF363032))),
              const SizedBox(width: 8),
              Image.asset('images/arrow-up.png', width: 16, height: 16),
            ],
          ),
        ),
      ],
    );
  }
}



class SearchBarWithButton extends StatelessWidget {
  final double top, left, width, height;
  final bool enabled;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;
  const SearchBarWithButton({super.key,
    required this.top, required this.left, this.width = 152, this.height = 45, this.enabled = true,
    this.controller, this.onChanged, this.onEditingComplete,
  });
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top, left: left, child: Container(
      width: width, height: height,
      decoration: BoxDecoration(color: const Color(0xFFEBF0F5), borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: [
          Expanded(child: TextField(
            enabled: enabled, controller: controller, onChanged: onChanged, onEditingComplete: onEditingComplete,
            decoration: const InputDecoration(border: InputBorder.none, contentPadding: EdgeInsets.symmetric(horizontal: 10), hintText: 'Search barbers haircut ser...'),
          )),
          GestureDetector(
            onTap: () {},
            child: Container(
              width: 45, height: height,
              decoration: BoxDecoration(color: const Color.fromRGBO(54, 48, 98, 1), borderRadius: BorderRadius.circular(8)),
              child: Center(child: Image.asset('images/setting.png', width: 24, height: 24)),
            ),
          ),
        ],
      ),
    ),
    );
  }
}

Widget _buildBarberShopItem(String name, String location, String rating, String imagePath, bool isFirst) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: SizedBox(
      width: 300,
      child: isFirst
          ? Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ReusableImage(image: imagePath, width: 340, height: 240),
          const SizedBox(height: 12),
          Text(name, style: CommonStyle.textStyle16Bold()),
          const SizedBox(height: 4),
          _buildPropertyRow(Icons.location_on, location),
          _buildPropertyRow(Icons.star, rating),
        ],
      )
          : Row(
        children: [
          ReusableImage(image: imagePath, width: 100, height: 100),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: CommonStyle.textStyle16Bold()),
                const SizedBox(height: 4),
                _buildPropertyRow(Icons.location_on, location),
                _buildPropertyRow(Icons.star, rating),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildPropertyRow(IconData icon, String text) {
  return Row(
    children: [
      Icon(icon, size: 16, color: const Color(0xFF6B7280)),
      const SizedBox(width: 4),
      Text(text, style: CommonStyle.textStyle14(const Color(0xFF6B7280))),
    ],
  );
}

class BarberShopList extends StatelessWidget {
  final List<BarberShop> barbershops = [
    BarberShop('Master piece Barbershop - Haircut styling', 'Joga Expo Center (2 km)', '5', 'images/Masterpiece.jpg'),
    BarberShop('Varcity Barbershop Jogja ex The Varcher', 'Condongcatur (10 km)', '4.5', 'images/Varcity.png'),
    BarberShop('Twinsky Monkey Berber & Men stuff', 'Jl Taman Siswa (8 km)', '5', 'images/Twinsky.png'),
    BarberShop('Barberman - Haricut styling & massage', 'J-Walk Centre (17 km)', '4.5', 'images/Barberman.png'),
  ];

  BarberShopList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Most Recommended', style: CommonStyle.textStyle18Bold()),
        const SizedBox(height: 12),

        Column(
          children: List.generate(barbershops.length, (index) {
            return _buildBarberShopItem(
              barbershops[index].name,
              barbershops[index].location,
              barbershops[index].rating,
              barbershops[index].image,
              index == 0,
            );
          }),
        ),
      ],
    );
  }
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(120), // Adjust the height as needed
          child: AppBar(
            automaticallyImplyLeading: false, // Hides the default back button
            backgroundColor: Colors.transparent, // Makes the background transparent
            elevation: 0, // Removes shadow
            flexibleSpace: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: InfoCard(
                location: 'Yogyakarta',
                name: 'Joe Samanta',
                trailing: ReusableImage(image: 'images/profile.png', width: 42, height: 42),
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const HomeCard(),
              const SizedBox(height: 24),
              const SearchBarWithButton(top: 24, left: 16, width: 320, height: 48),
              const SizedBox(height: 24),
              NearestBarbershopList(),
              const SizedBox(height: 24),
              BarberShopList(),
            ],
          ),
        ),
      ),
    );
  }
}



void main() {
  runApp(const MyApp());
}
