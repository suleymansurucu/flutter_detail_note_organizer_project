class Notes {
  late int noteID;

  late int categoryID;

  late String noteTitle;
  late String noteDetail;
  late String noteDate;
  late int notPriority;

  Notes.withID(this.noteID, this.categoryID, this.noteTitle, this.noteDetail,
      this.noteDate, this.notPriority);
  Notes(this.categoryID, this.noteTitle, this.noteDetail,this.noteDate, this.notPriority);

  Map<String,dynamic> toMap(){
    var map= Map<String,dynamic>();
    map['noteID']=noteID;
    map['categoryID']=categoryID;
    map['noteTitle']=noteTitle;
    map['noteDetail']=noteDetail;
    map['noteDate']=noteDate;
    map['notPriority']=notPriority;

    return map;
  }

  Notes.fromMap(Map<String,dynamic> map){
    noteID=map['noteID'];
    categoryID=map['categoryID'];
    noteTitle=map['noteTitle'];
    noteDetail=map['noteDetail'];
    noteDate=map['noteDate'];
    notPriority=map['notPriority'];
  }

  @override
  String toString() {
    return 'Notes{noteID: $noteID, categoryID: $categoryID, noteTitle: $noteTitle, noteDetail: $noteDetail, noteDate: $noteDate, notPriority: $notPriority}';
  }
}
