// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:tera_tech_app/ui/labels/custom_labels.dart';

class HistoricoDeTicketsView extends StatelessWidget {
  const HistoricoDeTicketsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: const EdgeInsets.symmetric(horizontal: 20),
      margin: const EdgeInsets.only(top: 30, left: 50, right: 50),
      width: double.infinity,
      // height: double.infinity,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            child: Text(
              'Ticket',
              style: CustomLabels.h1,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 50),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
