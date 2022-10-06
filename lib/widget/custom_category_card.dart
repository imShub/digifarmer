import 'package:flutter/material.dart';

class CustomCourseCardExpand extends StatefulWidget {
  const CustomCourseCardExpand({
    Key? key,
    required this.thumbNail,
    required this.title,
  }) : super(key: key);

  final String thumbNail;
  final String title;

  @override
  _CustomCourseCardExpandState createState() => _CustomCourseCardExpandState();
}

class _CustomCourseCardExpandState extends State<CustomCourseCardExpand> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width * .6,
      alignment: Alignment.topCenter,
      padding: EdgeInsets.all(7.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(17.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10.0,
            offset: Offset(0, 5),
          )
        ],
      ),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Container(
                height: size.width * .6,
                width: size.width * .6,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Image.network(
                    widget.thumbNail,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 15.0),
          Container(
            padding: const EdgeInsets.only(
              left: 7.0,
              right: 7.0,
            ),
            child: Text(
              widget.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Color.fromARGB(255, 89, 109, 42),
                fontSize: 17.0,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(height: 15.0),
        ],
      ),
    );
  }
}

class CustomCourseCardShrink extends StatefulWidget {
  const CustomCourseCardShrink({
    Key? key,
    required this.thumbNail,
    required this.title,
    required this.userName,
    required this.price,
  }) : super(key: key);

  final String thumbNail;
  final String title;
  final String userName;
  final String price;

  @override
  _CustomCourseCardShrinkState createState() => _CustomCourseCardShrinkState();
}

class _CustomCourseCardShrinkState extends State<CustomCourseCardShrink> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.width * .2,
      padding: const EdgeInsets.all(15.0),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        children: [
          Container(
            height: size.width * .125,
            width: size.width * .125,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Image.network(
                widget.thumbNail,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
