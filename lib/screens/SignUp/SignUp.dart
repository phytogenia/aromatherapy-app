import 'package:flutter/material.dart';

class SignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: null,
      body: Stack(
        overflow: Overflow.visible,
        children: <Widget>[
          Container(
            height: 210.0,
            decoration: BoxDecoration(
              color: Colors.green,
              image: const DecorationImage(
                image: AssetImage('assets/images/intersect.jpg'),
                fit: BoxFit.fill,
              ),
              borderRadius: BorderRadius.vertical(
                  bottom: Radius.elliptical(
                      MediaQuery.of(context).size.width, 90.0)),
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Color(0XFF61BB46).withOpacity(0.6),
                borderRadius: BorderRadius.vertical(
                    bottom: Radius.elliptical(
                        MediaQuery.of(context).size.width, 90.0)),
              ),
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/logo2.png'),
                  ),
                ),
                alignment: Alignment.center,
              ),
            ),
            alignment: Alignment.topCenter,
          ),
          Column(
            children: [
              Expanded(
                child: Align(
                  alignment: FractionalOffset.bottomRight,
                  child: Container(
                    height: 300.0,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/bottom.png'),
                          alignment: Alignment.bottomRight),
                    ),
                  ),
                ),
              )
            ],
          ),
          Positioned(
              top: 150,
              right: 20,
              left: 20,
              bottom: 100,
              child: Card(
                elevation: 15,
                color: Colors.white,
                child: Column(
                  children: [
                    Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/logo.png')),
                    )),

                  ],
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40.0),
                ),
              )),
        ],
      ),
    );
  }
}
