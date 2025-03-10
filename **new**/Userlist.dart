import 'package:flutter/material.dart';
import 'package:myapi/api.dart';

class Userlist extends StatefulWidget {
  const Userlist({super.key});

  @override
  State<Userlist> createState() => _UserlistState();
}

class _UserlistState extends State<Userlist> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  List<Map<String, dynamic>> users = [];
  final ApiService apiService = ApiService();
  @override
  void initState() {
    super.initState();
    loadUSer();
  }

  Future<void> loadUSer() async {
    final data = await apiService.getUser();
    setState(() {
      users = data;
    });
  }

  Future<void> delteUSer(String id) async {
    await apiService.deleteUser(id);
    loadUSer();
  }

  Future<void> saveUSer({String? id}) async {
    String name = nameController.text;
    String email = emailController.text;
    if (name.isEmpty || email.isEmpty) return;
    if (id == null) {
      await apiService.insertdata(name, email);
    } else {
      await apiService.updateUser(id, name, email);
    }
    nameController.clear();
    emailController.clear();
    Navigator.pop(context);
    loadUSer();
  }

  void ShowDialogBOXXXXXX({String? id, String? name, String? email}) {
    if (id != null) {
      nameController.text = name ?? "";
      emailController.text = email ?? "";
    } else {
      nameController.clear();
      emailController.clear();
    }
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text(id == null ? "addUSer" : "edit USer"),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("cancel")),
              TextButton(
                  onPressed: () => saveUSer(id: id), child: Text("Save")),
            ],
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                      labelText: "ENter name",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                      labelText: "ENter name",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                )
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Crud using api"),
      ),
      body: users.isEmpty
          ? Center(
              child: Text("No USer Found"),
            )
          : ListView.builder(
            itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return ListTile(
                  title: Text(user['name']),
                  subtitle: Text(user['email']),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                          onPressed: () => ShowDialogBOXXXXXX(
                              id: user['id'],
                              name: user['name'],
                              email: user['email']),
                          icon: Icon(Icons.edit)),
                      IconButton(
                          onPressed: () => delteUSer( user['id']),
                          icon: Icon(Icons.delete))
                    ],
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => ShowDialogBOXXXXXX(),
        child: Icon(Icons.add),
      ),
    );
  }
}
