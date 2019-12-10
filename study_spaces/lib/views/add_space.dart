import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddSpace extends StatefulWidget {
  AddSpace(this.userId);
  String userId;
  @override
  State<StatefulWidget> createState() => _MyAddSpaceState();
}

class _MyAddSpaceState extends State<AddSpace> {
  final _formKey = new GlobalKey<FormState>();
  TextEditingController _myNameField = TextEditingController();
  TextEditingController _myLongitudeField = TextEditingController();
  TextEditingController _myLatitudeField = TextEditingController();
  TextEditingController _myDescriptionField = TextEditingController();

  bool fieldsAreEmpty(){
    return (_myNameField.text.isEmpty | _myLongitudeField.text.isEmpty |
    _myLongitudeField.text.isEmpty | _myDescriptionField.text.isEmpty);
  }

  void validateAndSubmit() async {
//    setState(() {
//      _errorMessage = "";
//      _isLoading = true;
//    });

    if (validateAndSave()) {
      String userId = "";
      print("pre try catch");
      try {
        DocumentReference inst = Firestore.instance.collection('spaces').document();
        String id = inst.documentID;
        inst.setData({
          'id': id,
          "latitude":double.parse(_myLatitudeField.text),
          'longitude': double.parse(_myLongitudeField.text),
          'name': _myNameField.text,
          'description': _myDescriptionField.text,
          'userUID': widget.userId
        });
        _formKey.currentState.reset();
        Navigator.of(context).pop();
      } catch (e) {
        print('Error: $e');
      }
    }
  }
  bool validateAndSave() {
    final form = _formKey.currentState;
    print("pre validate()");
    if (form.validate()) {
      form.save();
      print("validate hit");
      return true;
    }
    return false;
  }

  Widget showForm() {
    return new Container(
      padding: EdgeInsets.fromLTRB(45.0, 20.0, 45.0, 0.0),
      child: new Form(
        key: _formKey,
        child: new ListView(
          shrinkWrap: true,
          children: <Widget>[
            showNameInput(),
            showLatitudeInput(),
            showLongitudeInput(),
            showDescriptionInput(),
            showSubmitButton(),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
          middle: new Text("Enter Information for new Study Space")),
      child: Stack(
        children: <Widget>[
          showForm(),
          //showCircularProgress(),
        ],
      ),
    );
  }

  Widget showNameInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 100.0, 0.0, 0.0),
      child: new CupertinoTextField(
        controller: _myNameField,
        prefix: Icon(Icons.text_fields, color: Colors.grey),
        placeholder: "Name of Space",
        maxLines: 1,
        autofocus: false,
        decoration: BoxDecoration(
          border: Border(
              bottom:
                  BorderSide(width: 0.0, color: CupertinoColors.activeBlue)),
        ),
      ),
    );
  }

  Widget showLatitudeInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 100.0, 0.0, 0.0),
      child: new CupertinoTextField(
        controller: _myLatitudeField,
        prefix: Icon(Icons.map, color: Colors.grey),
        placeholder: "Latitude of Space",
        maxLines: 1,
        autofocus: false,
        decoration: BoxDecoration(
          border: Border(
              bottom:
                  BorderSide(width: 0.0, color: CupertinoColors.activeBlue)),
        ),
      ),
    );
  }

  Widget showLongitudeInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 100.0, 0.0, 0.0),
      child: new CupertinoTextField(
        controller: _myLongitudeField,
        prefix: Icon(Icons.map, color: Colors.grey),
        placeholder: "Longitude of Space",
        maxLines: 1,
        autofocus: false,
        decoration: BoxDecoration(
          border: Border(
              bottom:
                  BorderSide(width: 0.0, color: CupertinoColors.activeBlue)),
        ),
      ),
    );
  }

  Widget showDescriptionInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 100.0, 0.0, 0.0),
      child: new CupertinoTextField(
        controller: _myDescriptionField,
        prefix: Icon(Icons.create, color: Colors.grey),
        placeholder: "Description of Space",
        maxLines: 1,
        autofocus: false,
        decoration: BoxDecoration(
          border: Border(
              bottom:
                  BorderSide(width: 0.0, color: CupertinoColors.activeBlue)),
        ),
      ),
    );
  }

  Widget showSubmitButton() {
    return new Padding(
        padding: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
        child: SizedBox(
            height: 40.0,
            child: new RaisedButton(
                elevation: 5.0,
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0),
                ),
                color: Colors.blue,
                child: new Text("Submit",
                    style: new TextStyle(fontSize: 20.0, color: Colors.white)),
                onPressed: () {
                  if(fieldsAreEmpty()){
                    showCupertinoDialog(
                        context: context,
                        builder: (context) {
                          return CupertinoAlertDialog(
                            title: Text('error'),
                            content: Text('One or more fields are empty'),
                            actions: <Widget>[
                              FlatButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('ok'))
                            ],
                          );
                        });
                  }
                  else{
                    validateAndSubmit();
                  }


                })));
  }
}
