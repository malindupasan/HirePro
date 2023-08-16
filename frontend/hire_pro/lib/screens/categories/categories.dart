class Categories {
  List<Map<String, String>> _categories = [
    {
      'Gardening': 'images/gardening-min.webp',
    },
    {
      'Plumbing': 'images/plumbing.jpg',
    },
    {
      'Cleaning': 'images/cleaning-min.webp',
    },
    {
      'Furniture Mounting': 'images/furnituremounting-min.webp',
    },
    {
      'Hair Cutting': 'images/haircut-min.webp',
    },
    {
      'Lawn Mowing': 'images/lawnmowing-min.webp',
    },
    {
      'Painting': 'images/painting-min.webp',
    },
  ];
  List<Map<String, String>> getCategories() {
    return _categories;
  }
}
