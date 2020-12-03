import 'package:flutter/material.dart';
import 'package:meditation_app/models/books.dart';

class EntryForm extends StatefulWidget {
  final Books books;

  EntryForm(this.books);
  @override
  _EntryFormState createState() => _EntryFormState(this.books);
}

class _EntryFormState extends State<EntryForm> {
  Books _books;
  _EntryFormState(this._books);

  TextEditingController _nameController = TextEditingController();
  TextEditingController _tahunController = TextEditingController();
  TextEditingController _penerbitController = TextEditingController();
  TextEditingController _noController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (_books != null) {
      _nameController.text = _books.name;
      _tahunController.text = _books.tahun;
      _penerbitController.text = _books.penerbit;
      _noController.text = _books.no;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        title: _books == null ? Text('Info Buku') : Text('Info Buku'),
        leading: Icon(Icons.keyboard_arrow_left),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
        child: ListView(
          children: [
            //nama
            Padding(
              padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: TextField(
                controller: _nameController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Nama',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onChanged: (value) {},
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: TextField(
                controller: _tahunController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Tahun',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onChanged: (value) {},
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: TextField(
                controller: _penerbitController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Penerbit',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onChanged: (value) {},
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: TextField(
                controller: _noController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'no',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onChanged: (value) {},
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: Row(
                children: [
                  Expanded(
                    child: RaisedButton(
                      color: Colors.orangeAccent,
                      textColor: Colors.white,
                      child: Text(
                        'Baca',
                        textScaleFactor: 1.5,
                      ),
                      onPressed: () {
                        if (_books == null) {
                          _books = Books(
                              _nameController.text,
                              _tahunController.text,
                              _penerbitController.text,
                              _noController.text);
                        } else {
                          _books.name = _nameController.text;
                          _books.alamat = _tahunController.text;
                          _books.medsos = _penerbitController.text;
                          _books.phone = _noController.text;
                        }
                        Navigator.pop(context, _books);
                      },
                    ),
                  ),
                  Container(
                    width: 5.0,
                  ),
                  Expanded(
                    child: RaisedButton(
                      color: Colors.orangeAccent,
                      textColor: Colors.white,
                      child: Text(
                        'Batal',
                        textScaleFactor: 1.5,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
