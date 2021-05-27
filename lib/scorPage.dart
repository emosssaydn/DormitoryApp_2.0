import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoring/constants.dart';
import 'package:scoring/context_extension.dart';
import 'package:scoring/rating.dart';

class ScorPage extends StatefulWidget {
  @override
  _ScorPageState createState() => _ScorPageState();
}

class _ScorPageState extends State<ScorPage> {
  int _rating = 0;
  final allChecked = CheckBoxModal(title: 'All Checked');
  final checkBoxList = [
    CheckBoxModal(title: 'Teacher'),
    CheckBoxModal(title: 'Manager'),
    CheckBoxModal(title: 'Assistant manager'),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
                backgroundColor: primaryColor,
                centerTitle: true,
                title: Text(
                  'Score Page',
                  style: TextStyle(fontWeight: FontWeight.w300),
                )),
            body: Container(
              color: secondaryColor,
              child: ListView(
                padding: new EdgeInsets.only(bottom: 0.1),
                children: [
                  ListTile(
                    onTap: () => onAllClicked(allChecked),
                    leading: Checkbox(
                      activeColor: primaryColor,
                      value: allChecked.value,
                      onChanged: (value) => onAllClicked(allChecked),
                    ),
                    title: Text(
                      allChecked.title,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Divider(),
                  ...checkBoxList
                      .map((item) => ListTile(
                            onTap: () => onItemClicked(item),
                            leading: Checkbox(
                              activeColor: primaryColor,
                              value: item.value,
                              onChanged: (value) => onItemClicked(item),
                            ),
                            title: Text(item.title,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w300)),
                          ))
                      .toList(),
                  SizedBox(height: context.dynamicHeight(0.03)),
                  Row(
                    children: [
                      SizedBox(
                        width: context.dynamicWidth(0.05),
                      ),
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              border: new OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(30.0),
                                ),
                                borderSide: new BorderSide(
                                  style: BorderStyle.none,
                                  color: Colors.transparent,
                                  width: 1.0,
                                ),
                              ),
                              hintText:
                                  'Name and surname of the person or persons to be scored:',
                              hintStyle: new TextStyle(
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black,
                                  fontSize: 16.0)),
                          maxLines: 2,
                          minLines: 2,
                        ),
                      ),
                      SizedBox(
                        width: context.dynamicWidth(0.05),
                      ),
                    ],
                  ),
                  SizedBox(height: context.dynamicHeight(0.05)),
                  Row(
                    children: [
                      SizedBox(
                        width: context.dynamicWidth(0.05),
                      ),
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              border: new OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(30.0),
                                ),
                                borderSide: new BorderSide(
                                  style: BorderStyle.none,
                                  color: Colors.transparent,
                                  width: 1.0,
                                ),
                              ),
                              hintText: 'Comment / Criticism:',
                              hintStyle: new TextStyle(
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black,
                                  fontSize: 16.0)),
                          maxLines: 5,
                          minLines: 3,
                        ),
                      ),
                      SizedBox(
                        width: context.dynamicWidth(0.05),
                      ),
                    ],
                  ),
                  SizedBox(height: context.dynamicHeight(0.03)),
                  Rating(
                    (rating) {
                      setState(() {
                        _rating = rating;
                      });
                    },
                  ),
                  SizedBox(height: context.dynamicHeight(0.03)),

                  /* SizedBox(
                      height: 44,
                      child: _rating == 1 && _rating <= 5
                          ? Text("You selected $_rating rating",
                              style: TextStyle(fontSize: 18))
                          : SizedBox.shrink()) */
                ],
              ),
            )));
  }

  onAllClicked(CheckBoxModal ckbItem) {
    final newValue = !ckbItem.value;
    setState(() {
      ckbItem.value = newValue;
      checkBoxList.forEach((element) {
        element.value = newValue;
      });
    });
  }

  onItemClicked(CheckBoxModal ckbItem) {
    final newValue = !ckbItem.value;
    setState(() {
      ckbItem.value = newValue;

      if (!newValue) {
        //This is List checkbox not checked full all =>So not need checked allChecked
        allChecked.value = false;
      } else {
        //This is List checkbox checked full => So need checked allChecked
        final allListChecked = checkBoxList.every((element) => element.value);
        allChecked.value = allListChecked;
      }
    });
  }
}

class CheckBoxModal {
  String title;
  bool value;

  CheckBoxModal({required this.title, this.value = false});
}
