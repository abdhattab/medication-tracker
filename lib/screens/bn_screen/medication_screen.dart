import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medication_tracker/get/medication_getx.dart';
import 'package:medication_tracker/screens/bn_screen/home_screen.dart';
import '../../uitls/helpers.dart';
import '../../uitls/process_response.dart';

class MedicationScreen extends StatefulWidget {
  const MedicationScreen({Key? key}) : super(key: key);

  @override
  State<MedicationScreen> createState() => _MedicationScreenState();
}

class _MedicationScreenState extends State<MedicationScreen> with Helpers {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<MedicationGetxController>(
        init: MedicationGetxController(),
        global: true,
        builder: (MedicationGetxController controller) {
          if (controller.loading == true) {
            return const Center(child: CircularProgressIndicator());
          } else if (controller.medications.isNotEmpty) {
            return ListView.builder(
                itemCount: controller.medications.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeScreen(
                            medication: controller.medications[index],
                          ),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(color: Color(0xff3b195a),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: ListTile(
                          horizontalTitleGap: 10,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomeScreen(
                                  medication: controller.medications[index],
                                ),
                              ),
                            );
                          },
                          leading: const Icon(
                            Icons.medication,
                            color: Color(0xfffef647),
                          ),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Wrap(children: [
                                const Icon(
                                  Icons.access_alarms_outlined,
                                  size: 19,
                                  color: Color(0xfffef647),
                                ),
                                Text(
                                  '    ${controller.medications[index].name}',
                                  style: GoogleFonts.nunito(
                                    color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              ]),
                              const SizedBox(height: 2),
                              Wrap(
                                children: [
                                  const Icon(
                                    Icons.date_range_sharp,
                                    size: 19,
                                    color: Color(0xfffef647),
                                  ),
                                  Text(
                                    '    ${controller.medications[index].year}/${controller.medications[index].month}/${controller.medications[index].day}',
                                    style: GoogleFonts.nunito(
                                        color: Colors.white,
                                        fontSize: 15),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Wrap(
                                children: [
                                  const Icon(
                                    Icons.access_time_sharp,
                                    size: 19,
                                    color:Color(0xfffef647),
                                  ),
                                  Text(
                                    '    ${controller.medications[index].hour.toString().padLeft(2, '0')} : ${controller.medications[index].minute.toString().padLeft(2, '0')}',
                                    style: GoogleFonts.nunito(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 2),
                              Wrap(children: [
                                const Icon(
                                  Icons.subtitles_sharp,
                                  size: 19,
                                  color:Color(0xfffef647),
                                ),
                                Text(
                                    '    ${controller.medications[index].description}',
                                    style: GoogleFonts.nunito(
                                        color:Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500))
                              ]),
                            ],
                          ),
                          trailing: IconButton(
                            onPressed: () async {
                              await deleteMedication(index: index);

                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.deepOrangeAccent,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                });
          } else {
            return Center(
              child: Text(
                'No Medication added !! ',
                style: GoogleFonts.nunito(
                    fontWeight: FontWeight.bold,
                    color: Colors.black12,
                    fontSize: 22),
              ),
            );
          }
        },
      ),
    );
  }

  Future<void> deleteMedication({required int index}) async {
    ProcessResponse processResponse =
        await MedicationGetxController.to.delete(index: index);
    showSnackBar(context,
        message: processResponse.message, error: !processResponse.success);
  }
}
