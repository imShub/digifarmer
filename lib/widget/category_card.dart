import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final String? imgSrc;
  final String? title;
  final double? fSize;
  final void Function()? press;
  const CategoryCard({
    Key? key,
    this.imgSrc,
    this.title,
    this.press,
    this.fSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(13),
      child: Container(
        padding: EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(13),
          boxShadow: [
            const BoxShadow(
              offset: Offset(0, 17),
              blurRadius: 17,
              spreadRadius: -23,
              color: Color.fromARGB(255, 229, 243, 213),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: press,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  const Spacer(),
                  Hero(
                    tag: imgSrc.toString(),
                    child: Image.asset(
                      imgSrc.toString(),
                      fit: BoxFit.cover,
                    ),
                  ),
                  const Spacer(flex: 4),
                  Text(
                    title.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color.fromARGB(255, 83, 128, 36),
                      fontSize: fSize == null ? 20 : fSize,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
