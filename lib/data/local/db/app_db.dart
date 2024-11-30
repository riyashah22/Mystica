import 'dart:io';
import 'package:drift/drift.dart';
import 'package:mytica/data/local/entity/album_entity.dart';
import 'package:mytica/data/local/entity/image_entity.dart';
import 'package:mytica/data/local/entity/journal_entity.dart';
import 'package:mytica/data/local/entity/notebook_entity.dart';
import 'package:mytica/data/local/entity/remainder_entity.dart';
import 'package:mytica/data/local/entity/todo_entity.dart';
import 'package:mytica/data/local/entity/user_entity.dart';
import 'package:mytica/data/local/entity/note_entity.dart';
import 'package:path_provider/path_provider.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as path;

part 'app_db.g.dart';

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(path.join(dbFolder.path, 'mystica.sqlite'));
    // print(file);
    return NativeDatabase(file);
  });
}

@DriftDatabase(tables: [
  Users,
  Journals,
  Albums,
  MyImages,
  Todos,
  Notebooks,
  Notes,
  Remainders
])
class AppDb extends _$AppDb {
  AppDb() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  // Users
  // Get All Users
  Future<List<User>> getUsers() async {
    return await select(users).get();
  }

  // get user by username
  Future<User> getUser(String username) async {
    return await (select(users)..where((tbl) => tbl.username.equals(username)))
        .getSingle();
  }

  // insertUser
  Future<int> insertUser(UsersCompanion entity) async {
    return await into(users).insert(entity);
  }

// Get User
  Future<User> getUserById(int id) async {
    return await (select(users)..where((tbl) => tbl.id.equals(id))).getSingle();
  }

// Update User
  Future<bool> updateUser(UsersCompanion entity) async {
    return await update(users).replace(entity);
  }

  // Journals
  // Get All Journals
  Future<List<Journal>> getJournals() async {
    return await select(journals).get();
  }

  // Get Journals By UserId
  Future<List<Journal>> getJournalsByUserId(int userId) async {
    return await (select(journals)..where((tbl) => tbl.userId.equals(userId)))
        .get();
  }

  // Create Journal
  Future<int> insertJournal(JournalsCompanion entity) async {
    return await into(journals).insert(entity);
  }

  // Get Journal By Id
  Future<Journal> getJournal(int id) async {
    return await (select(journals)..where((tbl) => tbl.id.equals(id)))
        .getSingle();
  }

  // Update Journal
  Future<bool> updateJournal(JournalsCompanion entity) async {
    return await update(journals).replace(entity);
  }

// delete Journal
  Future<int> deleteJournal(int id) async {
    return await (delete(journals)..where((tbl) => tbl.id.equals(id))).go();
  }

  // Albums
  // Get All Albums
  Future<List<Album>> getAlbums() async {
    return await select(albums).get();
  }

  // Get Albums By UserId
  Future<List<Album>> getAlbumByUserId(int userId) async {
    return await (select(albums)..where((tbl) => tbl.userId.equals(userId)))
        .get();
  }

  // Create Album
  Future<int> insertAlbum(AlbumsCompanion entity) async {
    return await into(albums).insert(entity);
  }

  // Get Album By Id
  Future<Album> getAlbum(int id) async {
    return await (select(albums)..where((tbl) => tbl.id.equals(id)))
        .getSingle();
  }

  // Update Album
  Future<bool> updateAlbum(AlbumsCompanion entity) async {
    return await update(albums).replace(entity);
  }

  // delete Album
  Future<int> deleteAlbum(int id) async {
    return await (delete(albums)..where((tbl) => tbl.id.equals(id))).go();
  }

  // Images
  // Get All Images
  Future<List<MyImage>> getMyImages() async {
    return await select(myImages).get();
  }

  // Get Image By AlbumId
  Future<List<MyImage>> getImageByAlbumId(int albumId) async {
    return await (select(myImages)..where((tbl) => tbl.albumId.equals(albumId)))
        .get();
  }

  Future<List<MyImage>> getImageByUserId(int userId) async {
    return await (select(myImages)..where((tbl) => tbl.userId.equals(userId)))
        .get();
  }

  // Create MyImage
  Future<int> insertImage(MyImagesCompanion entity) async {
    return await into(myImages).insert(entity);
  }

  // // Get Image By Id
  Future<MyImage> getImage(int id) async {
    return await (select(myImages)..where((tbl) => tbl.id.equals(id)))
        .getSingle();
  }

  // Update Image
  Future<bool> updateImage(MyImagesCompanion entity) async {
    return await update(myImages).replace(entity);
  }

  // delete Image
  Future<int> deleteImage(int id) async {
    return await (delete(myImages)..where((tbl) => tbl.id.equals(id))).go();
  }

  //Remainder
  // Get all Remainder
  Future<List<Remainder>> getRemainders() async {
    return await select(remainders).get();
  }

  // Get Remainders By UserId
  Future<List<Remainder>> getRemaindersByUserId(int userId) async {
    return await (select(remainders)..where((tbl) => tbl.userId.equals(userId)))
        .get();
  }

  // Create Remainder
  Future<int> insertRemainder(RemaindersCompanion entity) async {
    return await into(remainders).insert(entity);
  }

  // Get Remainder By Id
  Future<Remainder> getRemainder(int id) async {
    return await (select(remainders)..where((tbl) => tbl.id.equals(id)))
        .getSingle();
  }

  // Update Remainder
  Future<bool> updateRemainder(RemaindersCompanion entity) async {
    return await update(remainders).replace(entity);
  }

// delete Remainder
  Future<int> deleteRemainder(int id) async {
    return await (delete(remainders)..where((tbl) => tbl.id.equals(id))).go();
  }

  //Todos
  // Get all Todos
  Future<List<Todo>> getTodos() async {
    return await select(todos).get();
  }

  // Get Journals By UserId
  Future<List<Todo>> getTodosByUserId(int userId) async {
    return await (select(todos)..where((tbl) => tbl.userId.equals(userId)))
        .get();
  }

  // Create Todo
  Future<int> insertTodo(TodosCompanion entity) async {
    return await into(todos).insert(entity);
  }

  // Get Todo By Id
  Future<Todo> getTodo(int id) async {
    return await (select(todos)..where((tbl) => tbl.id.equals(id))).getSingle();
  }

  // Update Todo
  Future<bool> updateTodo(TodosCompanion entity) async {
    return await update(todos).replace(entity);
  }

// delete Todo
  Future<int> deleteTodo(int id) async {
    return await (delete(todos)..where((tbl) => tbl.id.equals(id))).go();
  }

  // Notebook
  // Get All Notebooks
  Future<List<Notebook>> getNotebooks() async {
    return await select(notebooks).get();
  }

  // Get Notebook By UserId
  Future<List<Notebook>> getNotebookByUserId(int userId) async {
    return await (select(notebooks)..where((tbl) => tbl.userId.equals(userId)))
        .get();
  }

  // Create Notebook
  Future<int> insertNotebook(NotebooksCompanion entity) async {
    return await into(notebooks).insert(entity);
  }

  // Get Notebook By Id
  Future<Notebook> getNotebook(int id) async {
    return await (select(notebooks)..where((tbl) => tbl.id.equals(id)))
        .getSingle();
  }

  // Update Notebook
  Future<bool> updateNotebook(NotebooksCompanion entity) async {
    return await update(notebooks).replace(entity);
  }

  // delete Notebook
  Future<int> deleteNotebook(int id) async {
    return await (delete(notebooks)..where((tbl) => tbl.id.equals(id))).go();
  }

  // Note
  // Get All Notes
  Future<List<Note>> getNotes() async {
    return await select(notes).get();
  }

  // Get Note By NotebookId
  Future<List<Note>> getNoteByNotebookId(int notebookId) async {
    return await (select(notes)
          ..where((tbl) => tbl.notebookId.equals(notebookId)))
        .get();
  }

  // Create Note
  Future<int> insertNote(NotesCompanion entity) async {
    return await into(notes).insert(entity);
  }

  // // Get Note By Id
  Future<Note> getNote(int id) async {
    return await (select(notes)..where((tbl) => tbl.id.equals(id))).getSingle();
  }

  // Update Note
  Future<bool> updateNote(NotesCompanion entity) async {
    return await update(notes).replace(entity);
  }

  // delete Note
  Future<int> deleteNote(int id) async {
    return await (delete(notes)..where((tbl) => tbl.id.equals(id))).go();
  }
}
