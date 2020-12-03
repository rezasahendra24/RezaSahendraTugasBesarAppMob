import 'package:flutter/material.dart';
import 'package:meditation_app/helpers/dbhelper.dart';
import 'package:meditation_app/models/books.dart';
import 'package:sqflite/sqflite.dart';
import 'entryform.dart';

class Main extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  DbHelper _dbHelper = DbHelper();
  int _count = 0;
  List<Books> _booksList;
  @override
  Widget build(BuildContext context) {
    if (_booksList == null) {
      _booksList = List<Books>();
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purpleAccent,
        title: Text('Katalog'),
      ),
      body: createListView(),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.purpleAccent,
          child: Icon(Icons.add_box),
          tooltip: 'Tambah Books',
          onPressed: () async {
            var books = await navigateToEntryForm(context, null);
            if (books != null) addBooks(books);
          }),
    );
  }

  Future<Books> navigateToEntryForm(BuildContext context, Books books) async {
    var result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) {
          return EntryForm(books);
        },
      ),
    );
    return result;
  }

  ListView createListView() {
    TextStyle textStyle = Theme.of(context).textTheme.subhead;
    return ListView.builder(
      itemCount: _count,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.red,
              child: Icon(Icons.people),
            ),
            title: Text(
              this._booksList[index].name,
              style: textStyle,
            ),
            subtitle: Text(
              this._booksList[index].penerbit,
            ),
            trailing: GestureDetector(
              child: Icon(Icons.delete),
              onTap: () {
                deleteBooks(_booksList[index]);
              },
            ),
            onTap: () async {
              var books =
                  await navigateToEntryForm(context, this._booksList[index]);
              if (books != null) editBooks(books);
            },
          ),
        );
      },
    );
  }

  void addBooks(Books object) async {
    int result = await _dbHelper.insert(object);
    if (result > 0) {
      updateListView();
    }
  }

  void editBooks(Books object) async {
    int result = await _dbHelper.update(object);
    if (result > 0) {
      updateListView();
    }
  }

  void deleteBooks(Books object) async {
    int result = await _dbHelper.delete(object.id);
    if (result > 0) {
      updateListView();
    }
  }

  void updateListView() {
    final Future<Database> dbFuture = _dbHelper.initDb();
    dbFuture.then((database) {
      Future<List<Books>> booksListFuture = _dbHelper.getBooksList();
      booksListFuture.then((booksList) {
        setState(() {
          this._booksList = booksList;
          this._count = booksList.length;
        });
      });
    });
  }
}
