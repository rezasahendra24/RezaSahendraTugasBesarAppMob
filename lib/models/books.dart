class Books {
  int _id;
  String _name;
  String _tahun;
  String _penerbit;
  String _no;

  Books(this._name, this._tahun, this._penerbit, this._no);
  Books.forMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._name = map['name'];
    this._tahun = map['tahun'];
    this._penerbit = map['penerbit'];
    this._no = map['no'];
  }

  int get id => _id;
  String get name => _name;
  String get tahun => _tahun;
  String get penerbit => _penerbit;
  String get no => _no;

  set name(String value) {
    _name = value;
  }

  set alamat(String value) {
    _tahun = value;
  }

  set medsos(String value) {
    _penerbit = value;
  }

  set phone(String value) {
    _no = value;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['id'] = this._id;
    map['name'] = this._name;
    map['tahun'] = this._tahun;
    map['penerbit'] = this._penerbit;
    map['no'] = this._no;
    return map;
  }
}
