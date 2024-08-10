import 'package:event_planner/pages/event/event_budget_page.dart';
import 'package:event_planner/pages/event/event_details_page.dart';
import 'package:event_planner/pages/event/event_toDoList_page.dart';
import 'package:event_planner/services/event_services.dart';
import 'package:event_planner/services/task_services.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../components/custom_snackbar.dart';
import '../../models/event.dart';
import '../../services/user_services.dart';

class EventNavigationPage extends StatefulWidget {
  
  final Event? event;

  EventNavigationPage({super.key, this.event});

  @override
  State<EventNavigationPage> createState() => _EventNavigationPageState();
}

class _EventNavigationPageState extends State<EventNavigationPage> with SingleTickerProviderStateMixin {
  
  late TabController _tabController;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _numberOfAttendeesController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _themeController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _sizeRatingController = TextEditingController();
  

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    if (widget.event != null) {

      _titleController.text = widget.event!.title ?? '';
      _descriptionController.text = widget.event!.description ?? '';
      _dateController.text = widget.event!.date != null ? DateFormat('dd/MM/yyyy').format(widget.event!.date!): '';
      _locationController.text = widget.event!.location ?? '';
      _numberOfAttendeesController.text = widget.event!.numberOfAttendees != null ? widget.event!.numberOfAttendees.toString() : '';
      _imageUrlController.text = widget.event!.imageUrl ?? '';
      _themeController.text = widget.event!.theme ?? '';
      _typeController.text = widget.event!.type ?? '';
      _sizeRatingController.text = widget.event!.sizeRating ?? '';
    }
  }

  @override
  void dispose() {
    _tabController.dispose();

    _titleController.dispose();
    _dateController.dispose();
    _locationController.dispose();
    _numberOfAttendeesController.dispose();
    _descriptionController.dispose();
    _imageUrlController.dispose();
    _themeController.dispose();
    _typeController.dispose();
    _sizeRatingController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer3<UserServices, EventServices, TaskServices>(
      builder: (context, userServices, eventServices, taskServices, child) {
        if (userServices.appUser == null) {
          return const Center(child: CircularProgressIndicator());
        }
        if(widget.event != null && taskServices.localTasks.isEmpty){
          taskServices.fetchEventTasks(widget.event!.id);
        }
        return Scaffold(

          appBar: AppBar(
            title: const Text("Event Details"),
            bottom: TabBar(
              controller: _tabController,
              tabs: const <Widget>[
                Tab(text: "Details"),
                Tab(text: "To Do List"),
                Tab(text: "Budget"),
              ],
            ),
          ),


          body: TabBarView(
            controller: _tabController,
            children: [

              EventDetailsPage(
                titleController: _titleController,
                dateController: _dateController,
                locationController: _locationController,
                descriptionController: _descriptionController,
                imageUrlController: _imageUrlController,
                sizeRatingController: _sizeRatingController,
                numberOfAttendeesController: _numberOfAttendeesController,
                themeController: _themeController,
                typeController: _typeController,
              ),

              EventToDoListPage(),

              EventBudgetPage(),

            ],
          ),


          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              try{

                var eventDate = _dateController.text.isNotEmpty ? DateFormat('dd/MM/yyyy').parse(_dateController.text) : null;

                Event? e = Event(
                  userId: userServices.appUser?.id,
                  title: _titleController.text,
                  date: eventDate,
                  location: _locationController.text,
                  numberOfAttendees: int.tryParse(_numberOfAttendeesController.text),
                  description: _descriptionController.text,
                  imageUrl: _imageUrlController.text,
                  sizeRating: _sizeRatingController.text,
                  theme: _themeController.text,
                  type: _typeController.text,
                );

                if(widget.event != null){
                  e.id = widget.event!.id;
                }

                final result = await eventServices.saveEvent(e, userServices.appUser?.id, taskServices.localTasks, taskServices.tasksToDetele);

                if (result['success']) {

                  taskServices.resetLocalTasks();
                  Navigator.pop(context);
                } 

                CustomSnackBar.show(context, result['message'], result['success']);
              
              }catch (e){
                CustomSnackBar.show(context, 'erro:$e', false);
            
              }
          
            },
            child: const Icon(Icons.save),
          ),
        );
      },
    );
  }
}
