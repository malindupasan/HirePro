class Categories {
  List<Map<String, String>> _categories = [
    {
      'Gardening': 'images/gardening.jpeg',
    },
    {
      'Plumbing': 'images/plumbing.jpeg',
    },
    {
      'Cleaning': 'images/cleaning.jpeg',
    },
    // {
    //   'Furniture Mounting': 'images/furnituremounting-min.webp',
    // },
    {
      'Hair Cutting': 'images/hair_cutting.jpeg',
    },
    {
      'Lawn Mowing': 'images/Lawn Mowing.jpeg',
    },
    {
      'Painting': 'images/painting.jpeg',
    },
  ];
  List<Map<String, String>> getCategories() {
    return _categories;
  }
}
