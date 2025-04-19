import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:personal_notes_app/personal_notes_app/data/auth_and_oauth_functions.dart';
import 'package:personal_notes_app/personal_notes_app/presentation/add_or_edit_notes_screen.dart';

/// Displays a list of notes with the ability to edit and delete.
class NotesListScreen extends StatefulWidget {
  const NotesListScreen({super.key});

  @override
  State<NotesListScreen> createState() => _NotesListScreenState();
}

class _NotesListScreenState extends State<NotesListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
        title: Center(child: Text('My Notes')),
        actions: [
          // Logout button
          IconButton(
            onPressed: () {
              signOut(context); // Calls the sign-out function
            },
            icon: Icon(Icons.logout),
          ),
        ],
        backgroundColor: Colors.cyan,
      ),
      body: StreamBuilder<QuerySnapshot>(
        // Firestore stream to listen for changes in the notes collection
        stream: FirebaseFirestore.instance
            .collection('notes')
            .orderBy('timestamp', descending: true) // Sort notes by timestamp (newest first)
            .snapshots(),
        builder: (context, snapshot) {
          // Display a loading indicator while waiting for data
          if (!snapshot.hasData) {
            return Center(child: const CircularProgressIndicator());
          }

          final docs = snapshot.data!.docs; // Get the list of notes documents
          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              var data = docs[index]; // Retrieve each note's data

              return Dismissible(
                key: Key(data.id), // Unique key for each dismissible item
                direction: DismissDirection.endToStart, // Swipe to delete
                background: Container(
                  color: Colors.red, // Red background for delete action
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  alignment: Alignment.centerRight,
                  child: const Icon(Icons.delete, color: Colors.white), // Delete icon
                ),
                confirmDismiss: (direction) async {
                  // Confirm before deleting
                  return await showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text('Delete this note?'),
                      actions: [
                        // Cancel the deletion
                        TextButton(
                          onPressed: () => Navigator.pop(context, false),
                          child: const Text('Cancel'),
                        ),
                        // Confirm and delete
                        ElevatedButton(
                          onPressed: () => Navigator.pop(context, true),
                          child: const Text('Delete'),
                        ),
                      ],
                    ),
                  );
                },
                onDismissed: (_) async {
                  // Delete the note after user confirms
                  await FirebaseFirestore.instance
                      .collection('notes')
                      .doc(data.id)
                      .delete();

                  // Show a snackbar to confirm deletion
                  ScaffoldMessenger.of(context)
                      .showSnackBar(const SnackBar(content: Text('Note deleted')));
                },
                child: ListTile(
                  title: Text(data['title']), // Display the note title
                  subtitle: Text(data['content']), // Display the note content
                  onTap: () {
                    // Navigate to the Add/Edit note screen on tap
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddOrEditNotesScreen(note: data),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to the Add/Edit note screen to create a new note
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddOrEditNotesScreen()),
          );
        },
        backgroundColor: Colors.cyan,
        child: Icon(Icons.add), // Icon to add a new note
      ),
    );
  }
}
