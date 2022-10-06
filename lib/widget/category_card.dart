import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final String? imgSrc;
  final String? title;
  final Function? press;
  const CategoryCard({
    Key? key,
    this.imgSrc,
    this.title,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(13),
      child: Container(
        // padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(13),
          boxShadow: [
            BoxShadow(
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
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: <Widget>[
                  Spacer(),
                  Image.asset(imgSrc.toString()),
                  Spacer(),
                  Text(
                    title.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color.fromARGB(255, 59, 80, 36), fontSize: 20),
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
