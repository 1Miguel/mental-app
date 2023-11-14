import 'package:flutter/material.dart';
import 'package:flutter_intro/ui_views/course_module_psychosis.dart';
import 'package:flutter_intro/ui_views/course_module_seekinghelp.dart';
import 'package:flutter_intro/ui_views/course_module_trauma.dart';
import 'package:flutter_intro/ui_views/course_module_truthaboutstress.dart';
import 'package:flutter_intro/utils/colors_scheme.dart';

class CourseIntroPsychosis extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: ((context) => PsychosisSliderModule())));
      },
      child: Scaffold(
        backgroundColor: psychMainBg,
        resizeToAvoidBottomInset: false,
        body: Container(
          child: Column(
            children: [
              Image.asset(
                'images/course_intro_psychosis.png',
                width: MediaQuery.sizeOf(context).width,
                height: MediaQuery.sizeOf(context).height,
                fit: BoxFit.fitHeight,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CourseIntroTrauma extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: ((context) => TraumaSliderModule())));
      },
      child: Scaffold(
        backgroundColor: traumaMainBg,
        resizeToAvoidBottomInset: false,
        body: Container(
          child: Column(
            children: [
              Image.asset(
                'images/course_intro_trauma.png',
                width: MediaQuery.sizeOf(context).width,
                height: MediaQuery.sizeOf(context).height,
                fit: BoxFit.fitHeight,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CourseIntroSuicide extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {},
      child: Scaffold(
        backgroundColor: suicideMainBg,
        resizeToAvoidBottomInset: false,
        body: Container(
          child: Column(
            children: [
              Image.asset(
                'images/course_intro_suicide.png',
                width: MediaQuery.sizeOf(context).width,
                height: MediaQuery.sizeOf(context).height,
                fit: BoxFit.fitHeight,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CourseIntroSeekingHelp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: ((context) => SeekingHelpSliderModule())));
      },
      child: Scaffold(
        backgroundColor: helpMainBg,
        resizeToAvoidBottomInset: false,
        body: Container(
          child: Column(
            children: [
              Image.asset(
                'images/course_intro_seekhelp.png',
                width: MediaQuery.sizeOf(context).width,
                height: MediaQuery.sizeOf(context).height,
                fit: BoxFit.fitHeight,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CourseIntroTruthAboutStress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: ((context) => TruthAboutStressSliderModule())));
      },
      child: Scaffold(
        backgroundColor: truthStressMainBg,
        resizeToAvoidBottomInset: false,
        body: Container(
          child: Column(
            children: [
              Image.asset(
                'images/course_intro_truthaboutstress.png',
                width: MediaQuery.sizeOf(context).width,
                height: MediaQuery.sizeOf(context).height,
                fit: BoxFit.fitHeight,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
