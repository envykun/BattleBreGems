import 'package:battle_bre_gems/models/stratagem.dart';
import 'package:flutter/material.dart';

class StratagemPreviewCard extends StatelessWidget {
  const StratagemPreviewCard({Key? key, required this.stratagem}) : super(key: key);

  final Stratagem stratagem;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: 380, minWidth: 240),
      child: Column(
        children: [
          Card(
            color: Colors.grey[100],
            child: InkWell(
              onTap: () {
                print("Tabbed");
              },
              child: Column(
                children: [
                  Ink(
                    decoration: BoxDecoration(
                      color: Colors.blue[700],
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(4.0),
                        topRight: Radius.circular(4.0),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Text(
                            stratagem.title.toUpperCase(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
                        child: Container(
                          child: Text(
                            stratagem.type,
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Container(
                          child: Text(
                            stratagem.lore,
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                              color: Colors.grey[400],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
                        child: Container(
                          child: Text(stratagem.description),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
