import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_tdd/ui/pages/pages.dart';
import 'package:provider/provider.dart';

import '../survey_view_model.dart';

class SurveysItem extends StatelessWidget {
  final SurveyViewModel viewModel;
  SurveysItem(this.viewModel);

  @override
  Widget build(BuildContext context) {
    final SurveysPresenter presenter = Provider.of<SurveysPresenter>(context);
    return GestureDetector(
      onTap: () => presenter.goToSurveyResult(viewModel.id),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 5),
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: viewModel.didAnswer
                ? Theme.of(context).secondaryHeaderColor
                : Theme.of(context).primaryColorDark,
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 1),
                spreadRadius: 0,
                blurRadius: 2,
                color: Colors.black,
              ),
            ],
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                viewModel.date,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Text(
                viewModel.question,
                style: TextStyle(color: Colors.white, fontSize: 22),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
