import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:personal_notes_app/personal_notes_app/data/crud_functions.dart';

/// Screen to either add a new note or edit an existing one.
/// If [note] is provided, screen will be in edit mode.
class AddOrEditNotesScreen extends StatefulWidget {
  final DocumentSnapshot? note; // Nullable Firestore document (note)

  const AddOrEditNotesScreen({super.key, this.note});

  @override
  State<AddOrEditNotesScreen> createState() => _AddOrEditNotesScreenState();
}

class _AddOrEditNotesScreenState extends State<AddOrEditNotesScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for form input fields
  late TextEditingController _titleController;
  late TextEditingController _contentController;

  @override
  void initState() {
    super.initState();

    // Initialize controllers with existing data if editing a note
    _titleController = TextEditingController(
      text: widget.note != null ? widget.note!['title'] : '',
    );
    _contentController = TextEditingController(
      text: widget.note != null ? widget.note!['content'] : '',
    );
  }

  @override
  void dispose() {
    // Dispose controllers when widget is removed
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Text(
          widget.note != null ? 'Edit Note' : 'Add Note',
          style: TextStyle(fontSize: 25, color: Colors.white),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // Title input
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(hintText: 'Enter your title'),
              ),
              SizedBox(height: 10),

              // Content input
              TextFormField(
                controller: _contentController,
                decoration: InputDecoration(hintText: 'Enter the content'),
              ),
              SizedBox(height: 30),

              // Save/Update button
              ElevatedButton(
                onPressed: () {
                  saveNote(
                    _titleController,
                    _contentController,
                    widget.note,
                    context,
                  );
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  backgroundColor: Colors.cyan,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                ),
                child: Text(
                  widget.note != null ? 'Update Note' : 'Save Note',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
