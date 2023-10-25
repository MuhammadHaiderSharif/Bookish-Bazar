import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LowerBody extends StatelessWidget {
  const LowerBody({required this.total, super.key});

  final double total;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: (MediaQuery.of(context).size.height - 132) -
          ((MediaQuery.of(context).size.height * 0.165) * 3),
      padding: const EdgeInsets.only(
        left: 22,
        right: 22,
        top: 14,
      ),
      decoration: const BoxDecoration(
        // borderRadius: BorderRadius.circular(25),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey, // Shadow color
            blurRadius: 5, // Spread of the shadow
            offset: Offset(0, 1),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 4.5,
            width: 50,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(
                0.7,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          const SizedBox(
            height: 18,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    DateFormat.yMMM().format(
                      DateTime.now(),
                    ),
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 18,
                        ),
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: const Color(0xFF9D9D9D),
                            ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          '\$${total.toStringAsFixed(2)}',
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 26,
                                  ),
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      foregroundColor: const Color(0xff808080),
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'CHECKOUT',
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                          size: 16,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
