import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:band_name_app/bulks/bands_bulk.dart';
import 'package:band_name_app/models/band_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Band> bands = bandsBulks;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'BandNames',
          style: TextStyle(color: Colors.black87),
        ),
      ),
      body: ListView.builder(
        itemCount: bands.length,
        itemBuilder: (context, index) => _buildListTile(bands[index]),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        elevation: 1,
        onPressed: _addNewBand,
      ),
    );
  }

  ListTile _buildListTile(Band band) {
    final String iniciales = band.name.substring(0, 2);
    return ListTile(
      leading: CircleAvatar(
        child: Text('$iniciales'),
        backgroundColor: Colors.blue[100],
      ),
      title: Text(band.name),
      trailing: Text(
        '${band.votes}',
        style: TextStyle(fontSize: 30),
      ),
      onTap: () {},
    );
  }

  _addNewBand() {
    final TextEditingController textEditingController =
        new TextEditingController();

    if (Platform.isAndroid) {
      return showDialogAndroid(textEditingController);
    }
    return showDialogIOS(textEditingController);
  }

  Future showDialogAndroid(TextEditingController textEditingController) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('New Band Name'),
        content: TextField(
          controller: textEditingController,
        ),
        actions: [
          MaterialButton(
            onPressed: () => addBandToList(textEditingController.text),
            child: Text('Add'),
            textColor: Colors.blue,
            elevation: 5,
          ),
        ],
      ),
    );
  }

  Future showDialogIOS(TextEditingController textEditingController) {
    return showCupertinoDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('New Band Name'),
        content: CupertinoTextField(
          controller: textEditingController,
        ),
        actions: [
          CupertinoDialogAction(
            onPressed: () => addBandToList(textEditingController.text),
            child: Text('Add'),
            isDefaultAction: true,
          ),
          CupertinoDialogAction(
            onPressed: () => addBandToList(textEditingController.text),
            child: Text('Dismiss'),
            isDestructiveAction: true,
          ),
        ],
      ),
    );
  }

  void addBandToList(String name) {
    if (name.length > 1) {
      bands.add(
        Band(
          id: generarId,
          name: name,
        ),
      );
      setState(() {});
    }
    Navigator.pop(context);
  }

  get ultimoId => bands.last.id;
  get generarId => (int.parse(ultimoId) + 1).toString();
}
