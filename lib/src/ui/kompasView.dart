import 'package:daikita/src/ui/utils/colorses.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'dart:math' as math;

import 'package:flutter_svg/svg.dart';

class CompassView extends StatefulWidget {
  @override
  _CompassViewState createState() => _CompassViewState();
}

class _CompassViewState extends State<CompassView> {
  double _direction;

  @override
  void initState() {
    super.initState();
    _getDirection();
  }

  void _getDirection() {
    FlutterCompass.events.listen((double direction) {
      if(mounted)
      setState(() {
        _direction = direction;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height,
                color: colorses.hijaudasar,
                child: Stack(
                  children: <Widget>[
                    Container(
                      height: MediaQuery.of(context).size.height /5 ,
                      color: colorses.hijaudasar,
                      child: Stack(
                        children: <Widget>[
                          SvgPicture.asset('assets/bg.svg',
                              color: Colors.green,
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width,
                              fit: BoxFit.cover),
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [colorses.colorCustom[100], colorses.hijaudasar]),
                            ),
                          )
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: SvgPicture.asset('assets/masjid.svg',
                          color: colorses.biru2,
                          alignment: Alignment.centerLeft,
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height/2,
                          fit: BoxFit.cover),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: MediaQuery.of(context).size.height/3,
                        color: colorses.biru2,
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: SafeArea(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              InkWell(
                                onTap: (){
                                  Navigator.of(context).pop();
                                },
                                child: Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "ARAH KIBLAT",
                                style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "",
                                style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    _verticalSpace(32.0),
                    _verticalSpace(32.0),
                    _verticalSpace(16.0),
                    Align(
                      alignment: Alignment.center,
                      child: Transform.rotate(
                          angle: ((_direction != null ? _direction + 65 : 0) *
                              (math.pi / 180) *
                              -1),
                          child: _compass()),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _verticalSpace(double height) {
    return Container(height: height);
  }

  Widget _compass() {
    return Image.asset('assets/kompas.png');
  }
}