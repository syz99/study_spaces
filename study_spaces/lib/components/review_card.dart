import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:study_spaces/components/space_card.dart';
import 'package:study_spaces/data_models/reviews.dart';

class ReviewCard extends StatelessWidget {
  ReviewCard(this.review);

  final Review review;

  Widget _buildDetails() {
    return FrostyBackground(
        color: Colors.blueAccent.withOpacity(0.7),
        child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
                children: [
                  SizedBox(height: 16),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 9,
                        bottom: 4,
                      ),
                      child: Text(
                        'Study Session',
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xffb0b0b0)),
                    ),
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      children: [
                        Table(
                          children: [
                            TableRow(
                              children: [
                                TableCell(
                                  child: Text(
                                    'Study Session Date:',
                                  ),
                                ),
                                TableCell(
                                  child: Text(
                                    DateFormat("yMd").format(review.startTime),
                                    textAlign: TextAlign.end,
                                  ),
                                ),
                              ],
                            ),
                            TableRow(
                              children: [
                                TableCell(
                                  child: Text(
                                    'Study Session Length',
                                  ),
                                ),
                                TableCell(
                                  child: Text(
                                    '${review.endTime
                                        .difference(review.startTime)
                                        .inHours
                                        .toString()} hours, ${((review.endTime
                                        .difference(review.startTime)
                                        .inMinutes.toInt()) - (review.endTime
                                        .difference(review.startTime)
                                        .inHours.toInt() *60))
                                        .toString()} minutes',
                                    textAlign: TextAlign.end,
                                  ),
                                ),
                              ],
                            ),
                            TableRow(
                              children: [
                                TableCell(
                                  child: Text(
                                    'Productivity Level:',
                                  ),
                                ),
                                TableCell(
                                  child: Text(review.productivity.toString().split(".")[1]),
                                ),
                              ],
                            ),
                            TableRow(
                              children: [
                                TableCell(
                                  child: Text(
                                    'Stress Level:',
                                  ),
                                ),
                                TableCell(
                                  child: Text(review.stress.toString().split(".")[1]),
                                ),
                              ],
                            ),
                            TableRow(
                              children: [
                                TableCell(
                                  child: Text(
                                    'Noise Level:',
                                  ),
                                ),
                                TableCell(
                                  child: Text(review.noiseLevel.toString().split(".")[1]),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ]
            )
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return PressableCard(
      onPressed: () {},
      child:       Stack(
        children: [
          Semantics(
              label: 'A card background featuring ${review.spaceId}',
              child: _buildDetails()
          ),
//        Positioned(
//          bottom: 0,
//          left: 0,
//          right: 0,
//          //child: _buildDetails(),
//        ),
        ],
      )
    );


  }
}


