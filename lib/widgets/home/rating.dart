import 'package:flutter/material.dart';

class StarRating extends StatelessWidget {
  final double rating;

  const StarRating({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    int fullStars = rating.floor();
    bool hasHalfStar = (rating - fullStars) >= 0.5;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        5,
        (index) {
          if (index < fullStars) {
            return const Icon(
              Icons.star,
              size: 15,
              color: Color(0xFFFFC41F),
            );
          } else if (hasHalfStar && index == fullStars) {
            return const Icon(
              Icons.star_half,
              size: 15,
              color: Color(0xFFFFC41F),
            );
          } else {
            return const Icon(
              Icons.star_border,
              size: 15,
              color: Colors.grey,
            );
          }
        },
      ),
    );
  }
}
