import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../survey_view_model.dart';
import 'components.dart';

class SurveyItems extends StatelessWidget {
  final List<SurveyViewModel> viewModels;

  SurveyItems({@required this.viewModels});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: CarouselSlider(
        options: CarouselOptions(
          enlargeCenterPage: true,
          aspectRatio: 1,
        ),
        items: viewModels.map((viewModel) => SurveysItem(viewModel)).toList(),
      ),
    );
  }
}
