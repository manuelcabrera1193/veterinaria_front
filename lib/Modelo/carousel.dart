class Carousel {
  int index;
  String title;
  String image;
  bool isSelected;

  Carousel({
    required this.index,
    required this.title,
    required this.image,
    required this.isSelected,
  });
}

List<Carousel> carousel = [
  Carousel(
      index: 0, title: '', image: 'assets/images/image1.jpg', isSelected: true),
  Carousel(
      index: 1,
      title: '',
      image: 'assets/images/image2.jpg',
      isSelected: false),
  Carousel(
      index: 2,
      title: '',
      image: 'assets/images/image3.jpg',
      isSelected: false),
];
