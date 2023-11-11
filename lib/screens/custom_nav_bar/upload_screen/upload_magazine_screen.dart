import 'package:flick_admin_panel/providers/image_provider.dart';
import 'package:flick_admin_panel/providers/loading_provider.dart';
import 'package:flick_admin_panel/screens/custom_nav_bar/upload_screen/widget/custom_input.dart';
import 'package:flick_admin_panel/services/magazine_services.dart';
import 'package:flick_admin_panel/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../../theme/app_text.dart';
import '../../../../theme/colors.dart';
import '../../../../theme/text_style.dart';
import '../../../../widget/primary_button.dart';

class UploadMagazineScreen extends StatefulWidget {
  const UploadMagazineScreen({Key? key}) : super(key: key);

  @override
  State<UploadMagazineScreen> createState() => _UploadMagazineScreenState();
}

class _UploadMagazineScreenState extends State<UploadMagazineScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
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
            AppText.upload,
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
                        height: MediaQuery.sizeOf(context).height * 0.3,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: AppColors.lightBlackColor,
                          image: DecorationImage(
                            image: FileImage(imageProvider.selectedImage!),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                const SizedBox(height: 30),
                CustomInput(
                  controller: titleController,
                  hintText: AppText.title,
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(height: 20),
                CustomInput(
                  controller: descriptionController,
                  maxLines: 4,
                  hintText: AppText.description,
                ),
                const SizedBox(height: 40),
                loadingController.isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : PrimaryButton(
                        title: AppText.save,
                        onTap: () async {
                          await MagazineServices().uploadMagazineInformation(
                            context: context,
                            image: imageProvider.selectedImage!,
                            title: titleController.text,
                            description: descriptionController.text,
                          );
                          imageProvider.deleteUploadImage();
                        }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
