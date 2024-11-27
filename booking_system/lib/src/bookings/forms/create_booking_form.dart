
import 'package:booking_system/widgets/base_form.dart';
import 'package:booking_system/models/business_data.dart';
import 'package:booking_system/models/employee_data.dart';
import 'package:booking_system/src/bookings/services/create_booking.dart';
import 'package:booking_system/services/fetch_employees.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateBookingForm extends StatefulWidget{
  final BusinessData businessData;

  const CreateBookingForm({super.key, required this.businessData});

  @override
  _CreateBookingFormState createState() => _CreateBookingFormState();
}

class _CreateBookingFormState extends State<CreateBookingForm>{
  final _formKey = GlobalKey<FormState>();
  
  EmployeeData? selectedEmployee;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController notesController = TextEditingController();
  final TextEditingController statusController = TextEditingController();

  List<EmployeeData> employees = [];

  void _submitForm() async{
    String title = titleController.text;
    String? employee = selectedEmployee?.id;
    String startDate = startDateController.text;
    String endDate = endDateController.text;
    String location = locationController.text;
    String notes = notesController.text;
    String status = statusController.text;
    final dio = Provider.of<Dio>(context, listen: false);
    try{
      bool bookingCreated = await createBooking(
                                      widget.businessData.id, 
                                      employee, 
                                      title, 
                                      startDate, 
                                      endDate, 
                                      location, 
                                      notes, 
                                      status, 
                                      dio);
      if(bookingCreated){
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Successfully booked')),
        );

        Navigator.of(context).pushReplacementNamed('/');
      }
    }catch(error){
      print('Error Loading Eployees: $error');
    }
  }

  void _loadEmployees() async{
    final dio = Provider.of<Dio>(context, listen: false);
    try{
      var employeeList = await fetchEmployees(widget.businessData.id,dio);
      setState(() {
        employees = employeeList;
      });
    }catch(error){
      print('Error Loading Eployees: $error');
    }
  }

  @override
  void initState(){
    super.initState();
    _loadEmployees();
  }

  @override
  Widget build(BuildContext context){

    BusinessData? businessData = widget.businessData;

    return BaseForm(
      formKey: _formKey,
      formName: "Create New Booking ${businessData.name}",
      formFields: [
        
        //Title
        TextFormField(
          controller: titleController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Title'
          ),
          validator: (value) {
            if (value == null || value.isEmpty){
              return 'Please enter your title';
            }
            return null;
          },
        ),

        //Employee
        DropdownButtonFormField<EmployeeData>(
          value: selectedEmployee,
          decoration: InputDecoration(
              labelText: 'Select an Employee',
              border: OutlineInputBorder(),
            ),
          onChanged: (EmployeeData? newValue) {
            setState((){
              selectedEmployee = newValue;
            });
          },
          items: 
            employees.map((item) => DropdownMenuItem<EmployeeData>(
              value: item,
              child: Text(item.name!),
            )).toList(),
          validator: (value) {
          if (value == null){
            return 'Please select an employee';
          }
          return null;
          },
        ),

        //Start Date
        TextFormField(
          controller: startDateController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Start Date'
          ),
          validator: (value) {
            if (value == null || value.isEmpty){
              return 'Please enter your Start Date';
            }
            return null;
          },
        ),

        //End Date
        TextFormField(
          controller: endDateController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'End Date'
          ),
          validator: (value) {
            if (value == null || value.isEmpty){
              return 'Please enter your End Date';
            }

            return null;
          },
        ),

        //Location
        TextFormField(
          controller: locationController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Location'
          ),
          validator: (value) {
            if (value == null || value.isEmpty){
              return 'Please enter your Locaiton';
            }

            return null;
          },
        ),

        //Notes
        TextFormField(
          controller: notesController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Notes'
          ),
          validator: (value) {
            if (value == null || value.isEmpty){
              return 'Please enter your Notes';
            }

            return null;
          },
        ),

        //Status
        TextFormField(
          controller: statusController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Status'
          ),
          validator: (value) {
            if (value == null || value.isEmpty){
              return 'Please enter your Status';
            }

            return null;
          },
        ),

      ],
      onSubmit: _submitForm,
    );
  }
}