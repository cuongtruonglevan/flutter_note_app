import 'package:flutter/material.dart';
import 'package:flutter_note_app/note/note_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final notes = List<Note>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        title: Text(
          'Notes',
          style: TextStyle(color: Colors.blue),
        ),
        centerTitle: true,
      ),
      body: Visibility(
        visible: notes.isNotEmpty,
        replacement: Center(
          child: Text(
            'You don\'t have any note yet.\nPlease add note.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 20.0,
            ),
          ),
        ),
        child: ListView.separated(
          padding: EdgeInsets.all(10.0),
          itemCount: notes.length,
          separatorBuilder: (context, index) => SizedBox(height: 5.0),
          itemBuilder: (context, index) {
            final note = notes[index];
            return Container(
              decoration: BoxDecoration(
                color: index.isOdd ? Colors.white : Colors.blueGrey,
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Dismissible(
                key: UniqueKey(),
                direction: DismissDirection.endToStart,
                onDismissed: (direction) {
                  setState(() {
                    notes.remove(note);
                  });
                },
                background: Container(
                  padding: EdgeInsets.only(right: 5.0),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Swipe to the left\nto remove this note',
                    textAlign: TextAlign.end,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.0),
                  child: ListTile(
                    title: Text(
                      note.title,
                      style: TextStyle(color: Colors.yellow[700]),
                    ),
                    trailing: Icon(Icons.keyboard_arrow_right,
                        color: index.isOdd ? Colors.blueGrey : Colors.white),
                    onTap: () {
                      notes.remove(note);
                      navigateToNote(note: note);
                    },
                  ),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        key: Key('note'),
        onPressed: navigateToNote,
        backgroundColor: Colors.yellow,
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 30.0,
        ),
      ),
      floatingActionButtonLocation: notes.isNotEmpty
          ? FloatingActionButtonLocation.endFloat
          : FloatingActionButtonLocation.centerFloat,
    );
  }

  Future navigateToNote({Note note}) async {
    final newNote = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => NoteScreen(note: note),
      ),
    );
    if (newNote != null) {
      notes.add(newNote);
      setState(() {});
    }
  }
}

class Note {
  Note({
    @required this.title,
    @required this.content,
  });

  final String title;
  final String content;
}
