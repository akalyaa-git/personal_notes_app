import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

/// Saves a new note or updates the existing one in Firestore.
void saveNote(TextEditingController titleController, TextEditingController contentController, DocumentSnapshot? note, BuildContext context) async {
  final title = titleController.text.trim();
  final content = contentController.text.trim();

  // Return early if fields are empty
  if (title.isEmpty || content.isEmpty) return;

  final notesRef = FirebaseFirestore.instance.collection('notes');

  if (note != null) {
    // Update existing note
    await notesRef.doc(note!.id).update({
      'title': title,
      'content': content,
      'timestamp': FieldValue.serverTimestamp(), // Optional: Useful for sorting
    });
  } else {
    // Add new note
    await notesRef.add({
      'title': title,
      'content': content,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  // Go back to previous screen
  Navigator.pop(context);
}