import 'dart:math';
import 'package:furniture/home/models/product.dart';

class MockDataManager {
  List<Product> getProducts() {
    double randomPrice() {
      final rnd = Random();
      return rnd.nextInt(100) * 1.0;
    }

    const path = 'assets/mock/products_images';
    return <Product>[
      Product(
        name: 'Couch with humans',
        price: randomPrice(),
        image: '$path/couch_1.jpg',
        description: 'Good couch. I like it.',
        reviewsCount: 25,
        rating: 4.5,
      ),
      Product(
        name: 'Regular soft сouch',
        price: randomPrice(),
        image: '$path/couch_2.jpg',
        description: 'Just good soft couch. Nothing more.',
        reviewsCount: 6,
        rating: 5,
      ),
      Product(
        name: 'Old chair',
        price: randomPrice(),
        image: '$path/chair_1.jpg',
        description: 'My grandmother\'s chair',
        reviewsCount: 1,
        rating: 3.5,
      ),
      Product(
        name: 'Omega kit with omega description',
        price: randomPrice(),
        image: '$path/kit_1.jpg',
        description: 'Minimal Stand is made of by natural wood. '
            'The design that is very simple and minimal. This is truly '
            'one of the best furnitures in any family for now. With 3 '
            'different colors, you can easily select the best match for your '
            'home. ',
        reviewsCount: 15,
        rating: 4.5,
      ),
      Product(
        name: 'Blue lamp',
        price: randomPrice(),
        image: '$path/lamp_1.jpg',
        description: 'Blue lamp',
        reviewsCount: 10,
        rating: 4.5,
      ),
      Product(
        name: 'Red lamp',
        price: randomPrice(),
        image: '$path/lamp_2.jpg',
        description: 'Human beings have been making useful, attractive objects '
            'since time immemorial – including lighting.  Simple stone oil '
            'lamps emerged in the Neolithic era, and by the 7th century BC '
            'the Ancient Greeks were making elaborate decorative terracotta '
            'versions, with ornamentation extending far beyond the lamp’s '
            'practical purpose. The industrial revolution began in Britain and '
            'spread around the world in the late 18th and early 19th century. '
            'Before it, the person who conceived a product and the person who '
            'physically made it were usually one and the same.',
        reviewsCount: 9,
        rating: 1.5,
      ),
    ];
  }

  Future<void> get randomTimeout {
    final rnd = Random();
    return Future.delayed(Duration(milliseconds: 800 + rnd.nextInt(1500)));
  }
}
