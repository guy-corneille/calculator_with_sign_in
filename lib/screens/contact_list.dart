import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:permission_handler/permission_handler.dart';

class ContactListScreen extends StatefulWidget {
  const ContactListScreen({super.key});

  @override
  _ContactListScreenState createState() => _ContactListScreenState();
}

class _ContactListScreenState extends State<ContactListScreen> {
  Iterable<Contact>? _contacts;

  @override
  void initState() {
    super.initState();
    _requestContactsPermission();
  }

  Future<void> _requestContactsPermission() async {
    PermissionStatus status = await Permission.contacts.request();
    if (status.isGranted) {
      // Permission granted, proceed to get contacts
      getContacts();
    } else if (status.isPermanentlyDenied) {
      // Permission permanently denied, show a dialog or navigate to app settings
      _showPermissionDialog();
    }
  }

  void _showPermissionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Permission Required'),
          content:
              const Text('Please enable contacts permission in app settings.'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                openAppSettings(); // Import 'package:permission_handler/permission_handler.dart' is needed for this function
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> getContacts() async {
    Iterable<Contact> contacts = await ContactsService.getContacts();
    setState(() {
      _contacts = contacts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact List'),
      ),
      body: _contacts != null
          ? ListView.builder(
              itemCount: _contacts!.length,
              itemBuilder: (context, index) {
                Contact contact = _contacts!.elementAt(index);
                return ListTile(
                  leading: contact.avatar != null
                      ? CircleAvatar(
                          backgroundImage: MemoryImage(contact.avatar!),
                        )
                      : CircleAvatar(
                          child: Text(contact.initials()),
                        ),
                  title: Text(contact.displayName ?? 'No Name'),
                  subtitle: Text(contact.phones?.isNotEmpty == true
                      ? contact.phones!.elementAt(0).value ?? 'No Phone'
                      : 'No Phone'),
                  onTap: () {
                    // Do something when the contact is tapped
                  },
                );
              },
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
