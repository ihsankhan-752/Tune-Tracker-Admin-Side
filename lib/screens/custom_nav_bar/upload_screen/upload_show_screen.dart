// ignore_for_file: use_build_context_synchronously

import 'package:flick_admin_panel/providers/loading_provider.dart';
import 'package:flick_admin_panel/screens/custom_nav_bar/upload_screen/widget/custom_input.dart';
import 'package:flick_admin_panel/services/our_show_services.dart';
import 'package:flick_admin_panel/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../../theme/app_text.dart';
import '../../../../theme/colors.dart';
import '../../../../theme/text_style.dart';
import '../../../../widget/primary_button.dart';
import '../../../providers/image_provider.dart';

class UploadShowScreen extends StatefulWidget {
  const UploadShowScreen({Key? key}) : super(key: key);

  @override
  State<UploadShowScreen> createState() => _UploadShowScreenState();
}

class _UploadShowScreenState extends State<UploadShowScreen> {
  final TextEditingController dateTimeController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController showLocationController = TextEditingController();

  pickDateAndTime() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    ).then((value) {
      setState(() {
        dateTimeController.text = "${value!.day}-${value.month}-${value.year} | ${TimeOfDay.now().format(context)}";
      });
    });
  }

  @override
  void dispose() {
    dateTimeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final imageProvider = Provider.of<ImageUploadingProvider>(context);
    final loadingController = Provider.of<LoadingProvider>(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            "Upload Show",
            style: AppTextStyles.heading2,
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                imageProvider.selectedImage == null
                    ? Container(
                        height: getHeight(context, 0.25),
                        width: double.infinity,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: AppColors.lightBlackColor,
                        ),
                        child: InkWell(
                          onTap: () {
                            imageProvider.uploadImage(ImageSource.camera);
                          },
                          child: Icon(Icons.add_a_photo, color: AppColors.primaryWhite, size: 40),
                        ),
                      )
                    : Container(
                        height: getHeight(context, 0.25),
                        width: double.infinity,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: FileImage(imageProvider.selectedImage!),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(20),
                          color: AppColors.lightBlackColor,
                        ),
                      ),
                const SizedBox(height: 30),
                CustomInput(
                  controller: titleController,
                  hintText: AppText.title,
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(height: 20),
                InkWell(
                  onTap: () {
                    pickDateAndTime();
                  },
                  child: CustomInput(
                    controller: dateTimeController,
                    hintText: AppText.dateTime,
                    enabled: false,
                  ),
                ),
                const SizedBox(height: 20),
                CustomInput(
                  controller: descriptionController,
                  maxLines: 4,
                  hintText: AppText.description,
                ),
                const SizedBox(height: 20),
                CustomInput(
                  controller: showLocationController,
                  hintText: "Show Location",
                ),
                const SizedBox(height: 40),
                loadingController.isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : PrimaryButton(
                        title: AppText.save,
                        onTap: () async {
                          await OurShowServices().uploadShowInformation(
                            context: context,
                            title: titleController.text,
                            showLocation: showLocationController.text,
                            description: descriptionController.text,
                            image: imageProvider.selectedImage!,
                            timeAndDate: dateTimeController.text,
                          );
                        },
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
