class Categories {
  List<Map<String, String>> _categories = [
    {
      'Gardening': 'images/gardener.png',
    },
    {
      'Plumbing': 'images/plumber.png',
    },
    {
      'Cleaning': 'images/cleaning.png',
    },
    {
      'Furniture': 'images/workspace.png',
    },
    {
      'Hair Cutting': 'images/hair-cut.png',
    },
    {
      'Lawn Mowing': 'images/lawn-mower.png',
    },
    {
      'Painting': 'images/painting.png',
    },
  ];
  List<Map<String, String>> getCategories() {
    return _categories;
  }
  
}
