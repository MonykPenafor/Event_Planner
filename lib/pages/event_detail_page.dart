import 'package:flutter/material.dart';

class EventDetailPage extends StatefulWidget {
  const EventDetailPage({super.key});

  @override
  State<EventDetailPage> createState() => _EventDetailPageState();
}

class _EventDetailPageState extends State<EventDetailPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _numberOfPeopleController = TextEditingController();
  final TextEditingController _venueController = TextEditingController();
  final TextEditingController _cateringController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _themeController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _titleController.dispose();
    _numberOfPeopleController.dispose();
    _venueController.dispose();
    _cateringController.dispose();
    _descriptionController.dispose();
    _themeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Event Details'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                hintText: 'Event Title',
                border: InputBorder.none,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the event title';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _numberOfPeopleController,
              decoration: const InputDecoration(
                hintText: 'Number of People Attending',
                border: InputBorder.none,
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter number of attendees';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _venueController,
              decoration: const InputDecoration(
                hintText: 'Venue',
                border: InputBorder.none,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the venue';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _cateringController,
              decoration: const InputDecoration(
                hintText: 'Catering Services',
                border: InputBorder.none,
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                hintText: 'Description',
                border: InputBorder.none,
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _themeController,
              decoration: const InputDecoration(
                hintText: 'Theme',
                border: InputBorder.none,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // Handle form submission
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Form Submitted'),
                      content: Text('Title: ${_titleController.text}'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                }
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}








































// class EventDetailPage extends StatefulWidget {
//   const EventDetailPage({super.key});

//   @override
//   // ignore: library_private_types_in_public_api
//   _EventDetailPageState createState() => _EventDetailPageState();
// }

// class _EventDetailPageState extends State<EventDetailPage> {
//   List<String> texts = ["Click here to edit", "Another field", "One more field"];
//   List<bool>? editStates;

//   @override
//   void initState() {
//     super.initState();
//     editStates = List<bool>.generate(texts.length, (_) => false);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: ListView.builder(
//         itemCount: texts.length + 2,  // Total count of items + Image + form
//         itemBuilder: (context, index) {
//           if (index == 0) {
//             return Image.asset('assets/images/festival.jpg');
//           } else if (index <= texts.length) {
//             return buildEditableText(index - 1);
//           } else {
//             return buildForm();
//           }
//         },
//       ),
//     );
//   }

//   Widget buildEditableText(int index) {
//     return editStates![index]
//         ? TextField(
//             autofocus: true,
//             controller: TextEditingController(text: texts[index]),
//             onSubmitted: (newValue) {
//               setState(() {
//                 texts[index] = newValue;
//                 editStates![index] = false;
//               });
//             },
//           )
//         : InkWell(
//             onTap: () {
//               setState(() {
//                 for (int i = 0; i < editStates!.length; i++) {
//                   editStates![i] = i == index;
//                 }
//               });
//             },
//             child: Text(texts[index], style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
//           );
//   }

//   Widget buildForm() {
//     return Column(
//       children: List.generate(5, (index) => TextFormField(
//           decoration: InputDecoration(
//             prefixIcon: const Icon(Icons.people_rounded),
//             label: Text("Number of people $index"),
//             enabledBorder: const OutlineInputBorder(
//               borderSide: BorderSide(width: 0.1),
//             ),
//             focusedBorder: const OutlineInputBorder(
//               borderSide: BorderSide(width: 0.2),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
