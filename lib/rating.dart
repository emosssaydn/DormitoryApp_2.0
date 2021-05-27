import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoring/constants.dart';
import 'package:scoring/context_extension.dart';

class Rating extends StatefulWidget {
  final int maximumRating;
  final Function(int) onRatingSelected;
  Rating(this.onRatingSelected, [this.maximumRating = 5]);

  @override
  _Rating createState() => _Rating();
}

class _Rating extends State<Rating> {
  int _currentRating = 0;

  Widget _buildRatingStar(int index) {
    if (index < _currentRating) {
      return Icon(Icons.star, color: Colors.orange);
    } else {
      return Icon(Icons.star_border_outlined);
    }
  }

  Widget _buildBody() {
    final stars = List<Widget>.generate(this.widget.maximumRating, (index) {
      return GestureDetector(
          child: _buildRatingStar(index),
          onTap: () {
            setState(() {
              _currentRating = index + 1;
            });

            this.widget.onRatingSelected(_currentRating);
          });
    });

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: stars,
        ),
        SizedBox(width: 10),
        SizedBox(
          height: context.dynamicHeight(0.07),
          width: context.dynamicWidth(0.25),
          child: ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(primaryColor),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ))),
            onPressed: () {
              setState(() {
                _currentRating = 0;
              });
              this.widget.onRatingSelected(_currentRating);
            },
            child: Text("Clear", style: TextStyle(color: Colors.white)),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }
}
