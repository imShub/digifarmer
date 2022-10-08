import 'package:flutter/material.dart';

class FeaturesCard extends StatefulWidget {
  final Icon icon;
  final String title;

  const FeaturesCard({super.key, required this.icon, required this.title});

  @override
  State<FeaturesCard> createState() => _FeaturesCardState();
}

class _FeaturesCardState extends State<FeaturesCard> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Card(
      color: Color.fromARGB(255, 250, 255, 246),
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40), // if you need this
        side: BorderSide(
          color: Colors.grey.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: SizedBox(
        width: size.width * 0.7,
        height: size.height * 0.1,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              widget.icon,
              Text(
                widget.title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 67, 97, 37),
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
