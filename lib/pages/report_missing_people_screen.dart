import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crime_reporting_system/auth_service.dart';
import 'package:crime_reporting_system/main.dart';
import 'package:crime_reporting_system/pages/Widgets/appdrawer.dart';
import 'package:crime_reporting_system/pages/Widgets/navbar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';
import 'dart:ui';

import 'package:quickalert/quickalert.dart';


class ReportMissingPeopleScreen extends StatefulWidget {
  const ReportMissingPeopleScreen({super.key});

  @override
  State<ReportMissingPeopleScreen> createState() =>
      _ReportMissingPeopleScreenState();
}

class _ReportMissingPeopleScreenState extends State<ReportMissingPeopleScreen> {
  PlatformFile? pickedFile;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  int currentStep = 0;
  bool isCompleted = false;
  bool fileUploaded = false;
  final formKey = GlobalKey<FormState>();
  final name = TextEditingController();
  final address = TextEditingController();
  final contactDetails = TextEditingController();
  final descriptionOfLostPerson = TextEditingController();
 
  late DatabaseReference dbRef;

  void showAlert() {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.success,
      onConfirmBtnTap: () {
        setState(() {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const ReportMissingPeopleScreen(),
            ),
          );
        });
      },
    );
  }

  @override
  void dispose() {
    name.dispose();
    address.dispose();
    contactDetails.dispose();
    descriptionOfLostPerson.dispose();
    
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    dbRef = FirebaseDatabase.instance.ref().child("Lease");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const Navbar(),
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        title: const Text("Report Missing People"),
        backgroundColor: const Color.fromARGB(255, 105, 245, 231),
        elevation: 0,
      ),
      drawer: const AppDrawer(),
      body: Theme(
        data: ThemeData(
          canvasColor: const Color.fromARGB(255, 255, 255, 255),
        ),
        child: Form(
          key: formKey,
          child: Stepper(
            elevation: 0,
            type: StepperType.horizontal,
            steps: getSteps(),
            currentStep: currentStep,
            onStepContinue: () {
              final isLastStep = currentStep == getSteps().length - 1;
              formKey.currentState!.validate();
              bool isDetailsValid = isDetailsComplete();
              if (isDetailsValid) {
                if (isLastStep) {
                  setState(() {
                    isCompleted = true;
                    addLeaseDetails(
                      name.text.trim(),
                      address.text.trim(),
                      contactDetails.text.trim(),
                      descriptionOfLostPerson.text.trim(),
                      
                    );
                    Map<String, String> missing = {
                      'Name': name.text.trim(),
                      'Contact': contactDetails.text.trim(),
                      
                      'Missing': descriptionOfLostPerson.text.trim(),
                      'Address': address.text.trim(),
                      
                    };
                    dbRef.push().set(missing);
                    showAlert();
                  });
                } else {
                  setState(() {
                    currentStep += 1;
                  });
                }
              }
            },
            onStepCancel: () {
              currentStep == 0
                  ? null
                  : setState(() {
                      currentStep -= 1;
                    });
            },
            onStepTapped: (value) {
              formKey.currentState!.validate();
              setState(() {
                currentStep = value;
              });
            },
            controlsBuilder: (context, ControlsDetails controls) {
              final isLastStep = currentStep == getSteps().length - 1;
              return Container(
                margin: const EdgeInsets.only(top: 50),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ButtonStyle(
                          fixedSize: const MaterialStatePropertyAll(
                            Size(240, 60),
                          ),
                          backgroundColor: MaterialStateProperty.all(
                            const Color.fromARGB(255, 108, 225, 249),
                          ),
                        ),
                        onPressed: controls.onStepContinue,
                        child: Text(isLastStep ? "Cornfirm" : "Next"),
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    if (currentStep != 0)
                      Expanded(
                        child: ElevatedButton(
                          style: ButtonStyle(
                            fixedSize: const MaterialStatePropertyAll(
                              Size(240, 60),
                            ),
                            backgroundColor: MaterialStateProperty.all(
                              const Color.fromARGB(255, 104, 243, 219),
                            ),
                          ),
                          onPressed: controls.onStepCancel,
                          child: const Text("Cancel"),
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  bool isDetailsComplete() {
    if (currentStep == 0) {
      if (name.text.isEmpty ||
          name.text.length <= 2 ||
          address.text.isEmpty ||
          address.text.length <= 2 ||
          contactDetails.text.isEmpty ||
          contactDetails.text.length != 10 ||
          descriptionOfLostPerson.text.isEmpty ||
          descriptionOfLostPerson.text.length <= 2) {
        
        return false;
      } else {
        return true;
      }
    } else if (currentStep == 1) {
      if (fileUploaded == false) {
        
        return false;
      } else {
        return true;
      }
    } else if (currentStep == 2) {
      return true;
    }
    return false;
  }

  List<Step> getSteps() => [
        Step(
          state: currentStep > 0 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 0,
          title: const Text("Step 1"),
          content: Column(
            children: [
              const Text(
                "Reporters Details:",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                textAlign: TextAlign.right,
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: name,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color.fromARGB(255, 7, 70, 59),
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  hintText: "Name ",
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: Color.fromARGB(255, 56, 255, 222)),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty || value.length <= 2) {
                    return "*Enter your Name";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: address,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color.fromARGB(255, 7, 70, 59),
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  hintText: "Address",
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: Color.fromARGB(255, 81, 255, 226)),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty || value.length <= 2) {
                    return "*Enter valid Address";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: contactDetails,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color.fromARGB(255, 7, 70, 59),
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  hintText: "Contact Details",
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: Color.fromARGB(255, 71, 255, 224)),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty || value.length != 10) {
                    return "Enter a valid contact details ";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Lost Person Details:",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                textAlign: TextAlign.right,
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: descriptionOfLostPerson,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color.fromARGB(255, 7, 70, 59),
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  hintText: "Description of the Lost Person ",
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: Color.fromARGB(255, 67, 255, 224)),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty || value.length <= 2) {
                    return "Enter a valid details";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              
              
            ],
          ),
        ),
        Step(
          state: currentStep > 1 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 1,
          title: const Text("Step 2"),
          content: Column(
            children: [
              if (pickedFile != null)
                Expanded(
                  child: Text(
                    pickedFile!.name,
                  ),
                ),
              ElevatedButton(
                style: ButtonStyle(
                  fixedSize: const MaterialStatePropertyAll(
                    Size(240, 60),
                  ),
                  backgroundColor: MaterialStateProperty.all(
                    const Color.fromARGB(255, 7, 70, 59),
                  ),
                ),
                onPressed: selectFile,
                child: const Text(
                  "Upload File",
                ),
              ),
              const SizedBox(
                height: 32,
              ),
            ],
          ),
        ),
        Step(
          isActive: currentStep >= 2,
          title: const Text("Step 3"),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                "Reporters Details",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text("Reporters Name: ${name.text.trim()}"),
              const SizedBox(
                height: 10,
              ),
              Text("Reporters Address: ${address.text.trim()}"),
              const SizedBox(
                height: 10,
              ),
              Text("Reporters Contact Details: ${contactDetails.text.trim()}"),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Lost Person Details",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                  "Descritption of the lost person: ${descriptionOfLostPerson.text.trim()}"),
              
            ],
          ),
        ),
      ];
  void selectFile() async {
    final pickedFile = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ["pdf"]);

    if (pickedFile != null) {
      String filename = pickedFile.files[0].name;
      File file = File(pickedFile.files[0].path!);
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      );
      final downloadLink = await uploadFile(filename, file);
      await _firebaseFirestore.collection("pdfs").add(
        {
          "name": filename,
          "Name": name.text.trim(),
          "url": downloadLink,
        },
      );
      fileUploaded = true;
      navigatorKey.currentState!.pop();
      Utils.showSnackBar("Uploaded Successfully!!");
    }
  }

  Future<String> uploadFile(String filename, File file) async {
    final ref = FirebaseStorage.instance.ref().child("pdfs/$filename.pdf");
    final uploadTask = ref.putFile(file);
    await uploadTask.whenComplete(() {});
    final downloadLink = await ref.getDownloadURL();
    return downloadLink;
  }

  Future addLeaseDetails(
      String name,
      String address,
      String contactDetails,
      String
          descriptionOfLostPerson /*, String landlordId, String accomodationName*/) async {
    await FirebaseFirestore.instance.collection("missing_details").add({
      'name': name,
      'address': address,
      'contactDetails': contactDetails,
      'descriptionOfLostPerson': descriptionOfLostPerson,
      
    });
  }
}