import 'package:flutter/material.dart';
import 'package:auto_waste/model/product.dart';

class ProductViewModel {
  
  List<Product> productsItems;

  ProductViewModel({this.productsItems});

  getProducts() => <Product>[
        Product(
            brand: "LarryCole",
            description: "Refuse Bin",
            image:
                "assets/bin.jpg",
            name: "THE PERFECT BIN",
            price: "10.99",
            rating: 4.0,
            colors: [
              ProductColor(
                color: Colors.red,
                colorName: "Red",
              ),
              ProductColor(
                color: Colors.green,
                colorName: "Green",
              ),
              ProductColor(
                color: Colors.blue,
                colorName: "Blue",
              ),
              ProductColor(
                color: Colors.cyan,
                colorName: "Cyan",
              )
            ],
            quantity: 0,
            sizes: ["S", "M", "L", "XL"],
            totalReviews: 170),
        Product(
            brand: "LarryCole",
            description: "Code Tag",
            image:
                "assets/code.png",
            name: "QR CODE",
            price: "1.49",
            rating: 5.0,
            colors: [
              ProductColor(
                color: Colors.red,
                colorName: "Red",
              ),
              ProductColor(
                color: Colors.green,
                colorName: "Green",
              ),
              ProductColor(
                color: Colors.blue,
                colorName: "Blue",
              ),
              ProductColor(
                color: Colors.cyan,
                colorName: "Cyan",
              )
            ],
            sizes: ["S", "M", "L", "XL"],
            quantity: 0,
            totalReviews: 10),
        Product(
            brand: "Produkt",
            description: "Men's Shirt",
            image:
                "https://mosaic01.ztat.net/vgs/media/pdp-zoom/PY/52/2D/01/FG/11/PY522D01F-G11@8.jpg",
            name: "ROBI CHECK",
            price: "16.49",
            rating: 4.5,
            totalReviews: 0),
        Product(
            brand: "adidas Originals",
            description: "Hoodie",
            image:
                "https://mosaic01.ztat.net/vgs/media/pdp-zoom/AD/12/2S/07/QN/11/AD122S07Q-N11@8.jpg",
            name: "TREF OVER HOOD",
            price: "34.99",
            rating: 4.0,
            totalReviews: 5),
        Product(
            brand: "ION",
            description: "Hydration rucksack",
            image:
                "https://mosaic01.ztat.net/vgs/media/packshot/pdp-zoom/N1/94/4E/00/4G/11/N1944E004-G11@10.jpg",
            name: "BACKPACK VILLAIN 4",
            price: "55.99",
            rating: 4.8,
            totalReviews: 12),
        Product(
            brand: "Diesel",
            description: "Straight leg jeans",
            image:
                "https://mosaic01.ztat.net/vgs/media/pdp-gallery/DI/12/2G/0H/5K/11/DI122G0H5-K11@10.jpg",
            name: "THYTAN",
            price: "83.99",
            rating: 4.2,
            totalReviews: 28),
        Product(
            brand: "YOURTURN",
            description: "Watch in budget",
            image:
                "https://mosaic02.ztat.net/vgs/media/packshot/pdp-zoom/YO/15/2M/00/6Q/11/YO152M006-Q11@6.jpg",
            name: "Watch",
            price: "11.99",
            rating: 4.7,
            totalReviews: 120),
        Product(
            brand: "Vero Moda",
            description: "Day dress - black/off",
            image:
                "https://mosaic01.ztat.net/vgs/media/pdp-zoom/VE/12/1C/1B/RQ/11/VE121C1BR-Q11@15.jpg",
            name: "VMKANA",
            price: "26.59",
            rating: 4.0,
            totalReviews: 33),
        Product(
            brand: "ONLY",
            description: "A-line skirt",
            image:
                "https://mosaic01.ztat.net/vgs/media/pdp-zoom/ON/32/1B/0B/JG/11/ON321B0BJ-G11@8.jpg",
            name: "ONLTHAI FRILL",
            price: "25.59",
            rating: 4.4,
            totalReviews: 44),
        Product(
            brand: "MAI PIÙ SENZA",
            description: "Awesome Heels",
            image:
                "https://mosaic01.ztat.net/vgs/media/pdp-zoom/M6/61/1B/02/9A/11/M6611B029-A11@13.jpg",
            name: "HIGH HEELS",
            price: "59.99",
            rating: 4.1,
            totalReviews: 22),
      ];
}
