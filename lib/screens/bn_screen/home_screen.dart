import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medication_tracker/get/medication_getx.dart';
import 'package:medication_tracker/models/medication.dart';
import 'package:medication_tracker/uitls/helpers.dart';
import 'package:medication_tracker/widgets/text_field.dart';
import '../../noification/notification_services.dart';
import '../../uitls/process_response.dart';
import 'package:timezone/data/latest.dart' as tz;

class HomeScreen extends StatefulWidget {
   const HomeScreen({Key? key, this.medication}) : super(key: key);
  final Medication? medication;



  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with Helpers {
  DateTime? date;
  TimeOfDay? time;
  late TextEditingController _name;
  late TextEditingController _description;




  final MedicationGetxController medicationGetxController =
      Get.put<MedicationGetxController>(MedicationGetxController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _name = TextEditingController();
    _description = TextEditingController();
     tz.initializeTimeZones();



  }

  @override
  void dispose() {
    // TODO: implement dispose
    _name.dispose();
    _description.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Color(0xff3b195a)),
        elevation: 0,
        backgroundColor: Colors.transparent,

      ),
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 30),
        child: SafeArea(
          child: Column(
            children: [
              Text(
                isNewMedication
                    ? 'Welcome to Medical Tracker ♥'
                    : 'Update your Medication',
                style: GoogleFonts.nunito(fontWeight: FontWeight.bold),
              ),  const Spacer(),
              Align(
                alignment: AlignmentDirectional.topEnd,
                child: IconButton(
                  onPressed: () {
                    _performSave();
                    print(DateTime.now());
                  },
                  icon: const Icon(Icons.add),
                  iconSize: 40,
                  color: const  Color(0xff3b195a),
                ),
              ),
              Align(
                alignment: AlignmentDirectional.topStart,
                child: Text(
                  'Enter some details... ',
                  style: GoogleFonts.nunito(fontWeight: FontWeight.bold),
                ),
              ),
              TextWidget(
                  hint: isNewMedication
                      ? 'Name'
                      : _name.text = widget.medication!.name,
                  icon: Icons.medication_outlined,
                  textController: _name),
               SizedBox(height: 5),
              TextWidget(
                  hint: isNewMedication
                      ? 'Description'
                      : _description.text = widget.medication!.description,
                  icon: Icons.medication,
                  textController: _description),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      pickDate();

                    },
                    child:  Text('Pick a Date' ,style: GoogleFonts.nunito(fontSize: 15,fontWeight: FontWeight.w700,color: const  Color(0xff3b195a)),),
                  ),
                  TextButton(
                    onPressed: () {
                      pickTime();

                    },
                    child: Text(
                      'Pick a Time',
                      style: GoogleFonts.nunito(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          color: const  Color(0xff3b195a)),
                    ),
                  ),
                ],

              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> pickDate() async {
    final initialDate = isNewMedication
        ? DateTime.now()
        : DateTime(widget.medication!.year, widget.medication!.month,
            widget.medication!.day);
    final newDate = await showDatePicker(
        context: context,
        initialDate: date ?? initialDate,
        firstDate: DateTime(DateTime.now().year),
        lastDate: DateTime(DateTime.now().year + 5));
    if (newDate == null) {
      showSnackBar(context, message: 'Failed to select date', error: true);
    } else {
      setState(() {
        date = newDate;
      });
      showSnackBar(context, message: 'Date selected successfully');
    }
  }

  Future<void> pickTime() async {
    final initialTime = isNewMedication
        ? const TimeOfDay(hour: 9, minute: 0)
        : TimeOfDay(
            hour: widget.medication!.hour, minute: widget.medication!.minute);
    final newTime = await showTimePicker(
        context: context, initialTime: time ?? initialTime);
    if (newTime == null) {
      showSnackBar(context, message: 'Failed to select Time', error: true);
    } else {
      setState(() {
        time = newTime;
      });
      showSnackBar(context, message: 'Time selected successfully');
    }
  }

  Future<void> _performSave() async {
    if (_checkData()) {
      await _save();
     await _performNotification();
    }
  }
Future<void>_performNotification()async{
  // Duration diffrance =DateTime.now().difference(date!);

  NotificationService().showNotification(1, medication.name, medication.description,10);

}


  bool _checkData() {
    if (_name.text.isNotEmpty &&
        _description.text.isNotEmpty &&
        date != null &&
        time != null) {
      return true;
    }
    showSnackBar(context, message: 'Enter required data!', error: true);
    return false;
  }

  Future<void> _save() async {
    ProcessResponse processResponse = isNewMedication
        ? await MedicationGetxController.to.create(medication: medication)
        : await MedicationGetxController.to
            .updateMedication(medication: medication);



    showSnackBar(context,
        message: processResponse.message, error: !processResponse.success);

    if (processResponse.success) {
      isNewMedication ? clear() : Navigator.pop(context);
    }
  }

  bool get isNewMedication => widget.medication == null;

  Medication get medication {
    Medication medication = isNewMedication ? Medication() : widget.medication!;
    medication.name = _name.text;
    medication.description = _description.text;
    medication.hour = time!.hour;
    medication.minute = time!.minute;
    medication.day = date!.day;
    medication.month = date!.month;
    medication.year = date!.year;

    return medication;
  }

  void clear() {
    _name.clear();
    _description.clear();
  }


}
