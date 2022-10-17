
import 'package:get/get.dart';
import 'package:medication_tracker/database/controller/medication_controller.dart';
import 'package:medication_tracker/models/medication.dart';
import 'package:medication_tracker/uitls/process_response.dart';

class MedicationGetxController extends GetxController{


  List<Medication> medications=<Medication>[];
   final MedicationDbController _dbController=MedicationDbController();

  static MedicationGetxController get to => Get.find<MedicationGetxController>();
  bool loading = false;

  @override
  void onInit() {
    read();
    super.onInit();
  }

  Future<ProcessResponse> create({required Medication medication}) async{

    int newRowId=await _dbController.create(medication);
    if(newRowId !=0){
      medication.id=newRowId;
      medications.add(medication);
      update();

    }
    return ProcessResponse(message: newRowId !=0 ? 'Created successfully':'Create Failed ! ', success: newRowId != 0);
  }
  void read () async{
    loading= true;
    medications = await _dbController.read();
    update();
    loading = false;
  }

  Future<ProcessResponse> updateMedication({required Medication medication})async{
    bool updated = await _dbController.update(medication);
    if(updated){
      int index = medications.indexWhere((element) => element.id==medication.id);
      if(index != -1){
        medications[index]=medication;
        update();
      }
    }
    return ProcessResponse(message: updated ? 'Updated Successfully':'Update failed', success: updated);
  }

  Future<ProcessResponse> delete({required int index})async{
    bool deleted = await _dbController.delete(medications[index].id);
    if(deleted){
      medications.removeAt(index);
      update();
    }
    return ProcessResponse(message: deleted ?'Deleted Successfully':'Deleted Failed', success: deleted);
  }

}