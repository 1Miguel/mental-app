import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_intro/utils/colors_scheme.dart';
import 'package:progress_stepper/progress_stepper.dart';

List<String> imageList = [
  'images/courses/stress/1.JPG',
  'images/courses/stress/2.JPG',
  'images/courses/stress/3.JPG',
  'images/courses/stress/4.JPG',
  'images/courses/stress/5.JPG'
];

final List<Widget> images = imageList
    .map(
      (item) => LayoutBuilder(builder: (context, constraint) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(4.0)),
            child: Container(
              //color: item.color,
              width: constraint.maxWidth,
              height: constraint.maxHeight,
              //height: item.height,
              child: SizedBox(
                width: constraint.maxWidth,
                height: constraint.maxHeight,
                child: Center(
                  child: Image.asset(
                    item,
                    width: constraint.maxWidth,
                    height: constraint.maxHeight - 10,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    )
    .toList();

class TruthAboutStressSliderModule extends StatefulWidget {
  const TruthAboutStressSliderModule({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _TruthAboutStressSliderModuleState();
  }
}

class _TruthAboutStressSliderModuleState
    extends State<TruthAboutStressSliderModule> {
  final CarouselController _controller = CarouselController();
  int _chevronCounter = 0;
  int _customCounter = 0;

  void _incrementChevronStepper() {
    setState(() {
      if (_chevronCounter != 4) {
        _chevronCounter++;
      }
    });
  }

  void _decrementChevronStepper() {
    setState(() {
      if (_chevronCounter != 0) {
        _chevronCounter--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      double bodyHeight = MediaQuery.sizeOf(context).height;
      double bodyWidth = MediaQuery.sizeOf(context).width;
      double imageHeight = bodyHeight / 2;
      return Scaffold(
        appBar: AppBar(
          toolbarHeight: 80,
          automaticallyImplyLeading: false,
          leading: SizedBox(
            width: 20,
            height: 20,
            child: Padding(
              padding: EdgeInsets.only(bottom: 3.0, left: 11.0),
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  size: 30,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: bodyWidth,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                        child: SizedBox(
                            width: bodyWidth,
                            child: Text(
                              "Course: \nTruth About Stress",
                              style: TextStyle(
                                  color: Colors.teal,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25),
                            )),
                      ),
                      Divider(),
                    ],
                  ),
                ),
                Expanded(
                  child: FlutterCarousel(
                    items: images,
                    options: CarouselOptions(
                      viewportFraction: 1.0,
                      autoPlay: false,
                      floatingIndicator: false,
                      enableInfiniteScroll: false,
                      controller: _controller,
                      slideIndicator: CircularWaveSlideIndicator(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 20.0),
                  child: Flexible(
                    child: ProgressStepper(
                      width: 300,
                      currentStep: _chevronCounter,
                      stepCount: 4,
                      progressColor: Colors.tealAccent,
                      onClick: (int index) {
                        setState(() {
                          _chevronCounter = index;
                        });
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 16.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        child: TextButton(
                          child: Row(
                            children: [
                              Icon(Icons.arrow_left, color: Colors.black),
                              Text(
                                'Previous',
                                style: TextStyle(
                                  fontFamily: 'Open Sans',
                                  fontWeight: FontWeight.w900,
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          onPressed: () {
                            _controller.previousPage();
                            _decrementChevronStepper();
                          },
                        ),
                      ),
                      SizedBox(
                        child: TextButton(
                          child: Row(
                            children: [
                              Text(
                                'Next',
                                style: TextStyle(
                                    fontFamily: 'Open Sans',
                                    fontWeight: FontWeight.w900,
                                    fontSize: 15,
                                    color: Colors.black),
                              ),
                              Icon(Icons.arrow_right, color: Colors.black),
                            ],
                          ),
                          onPressed: () {
                            _controller.nextPage();
                            _incrementChevronStepper();
                          },
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
