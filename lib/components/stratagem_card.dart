import 'package:battle_bre_gems/models/stratagem.dart';
import 'package:flutter/material.dart';

class StratagemCard extends StatelessWidget {
  final Stratagem stratagem;
  final Function? editCallback;
  final Function? deleteCallback;

  const StratagemCard({Key? key, required this.stratagem, this.editCallback, this.deleteCallback}) : super(key: key);

  handleBorderShadow() {
    switch (stratagem.tag) {
      case CrudTag.create:
        return new BoxDecoration(boxShadow: [BoxShadow(color: Colors.green.shade800, blurRadius: 10)]);
      case CrudTag.delete:
        return new BoxDecoration(boxShadow: [BoxShadow(color: Colors.redAccent.shade700, blurRadius: 10)]);
      case CrudTag.update:
        return new BoxDecoration(boxShadow: [BoxShadow(color: Colors.yellow.shade700, blurRadius: 10)]);
      default:
        return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: 380, minWidth: 240),
      child: Column(
        children: [
          Container(
            decoration: handleBorderShadow(),
            child: Card(
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
                          PopupMenuButton(
                            tooltip: "More actions",
                            splashRadius: 16,
                            icon: Icon(
                              Icons.more_vert,
                              color: Colors.white,
                            ),
                            onSelected: (value) {
                              switch (value) {
                                case 'edit':
                                  return editCallback?.call(context, stratagem);
                                case 'delete':
                                  return deleteCallback?.call(stratagem);
                                default:
                                  throw UnimplementedError();
                              }
                            },
                            itemBuilder: (c) => <PopupMenuEntry>[
                              PopupMenuItem(
                                child: Text("Edit"),
                                value: 'edit',
                              ),
                              const PopupMenuDivider(),
                              const PopupMenuItem(
                                child: Text("Delete"),
                                value: 'delete',
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(8.0, 8.0, 1.0, 0.0),
                                child: Container(
                                  // color: Colors.amber,
                                  child: Text(
                                    stratagem.type,
                                    style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.bold,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
                              child: Row(
                                children: [
                                  Text(
                                    "${stratagem.cost}CP",
                                    style: TextStyle(fontWeight: FontWeight.w900),
                                  ),
                                  stratagem.cost2 != ""
                                      ? Text(
                                          "/${stratagem.cost2}CP",
                                          style: TextStyle(fontWeight: FontWeight.w900),
                                        )
                                      : Container(),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.0),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Container(
                            // color: Colors.pink,
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
                            // color: Colors.lightGreen,
                            child: Text(stratagem.description),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage("https://i.pravatar.cc/100"),
                        radius: 12,
                      ),
                      SizedBox(width: 8.0),
                      Container(
                        child: Text(
                          "Created 20.05.2022",
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            color: Colors.grey[400],
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    child: Text(
                      "Lastly updated 26.09.2022",
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        color: Colors.grey[400],
                        fontSize: 12,
                      ),
                    ),
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
