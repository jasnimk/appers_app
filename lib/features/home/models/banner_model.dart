class BannerModel {
  final String id;
  final String title;
  final String subtitle;
  final String imageUrl;
  final String? actionUrl;

  BannerModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    this.actionUrl,
  });

  // Static method to get default banners using Lorem Picsum
  static List<BannerModel> getDefaultBanners() {
    return [
      BannerModel(
        id: '1',
        title: 'Summer Sale',
        subtitle: 'Up to 50% OFF',
        imageUrl: 'https://picsum.photos/seed/summer/800/400',
      ),
      BannerModel(
        id: '2',
        title: 'New Arrivals',
        subtitle: 'Explore Latest Collection',
        imageUrl: 'https://picsum.photos/seed/newarrivals/800/400',
      ),
      BannerModel(
        id: '3',
        title: 'Free Shipping',
        subtitle: 'On orders over \$50',
        imageUrl: 'https://picsum.photos/seed/shipping/800/400',
      ),
      BannerModel(
        id: '4',
        title: 'Flash Deals',
        subtitle: 'Limited Time Offers',
        imageUrl: 'https://picsum.photos/seed/flashdeals/800/400',
      ),
    ];
  }
}
