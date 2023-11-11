import 'package:flick_admin_panel/providers/loading_provider.dart';
import 'package:flick_admin_panel/providers/pick_start_and_end_time_provider.dart';
import 'package:flick_admin_panel/services/schedule_services.dart';
import 'package:flick_admin_panel/theme/colors.dart';
import 'package:flick_admin_panel/theme/text_style.dart';
import 'package:flick_admin_panel/widget/custom_input.dart';
import 'package:flick_admin_panel/widget/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UploadProgramScheduleScreen extends StatefulWidget {
  const UploadProgramScheduleScreen({super.key});

  @override
  State<UploadProgramScheduleScreen> createState() => _UploadProgramScheduleScreenState();
}

class _UploadProgramScheduleScreenState extends State<UploadProgramScheduleScreen> {
  TextEditingController titleController = TextEditingController();
  final List<String> _days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Thursday'];
  String _selectedDay = 'Monday';
  @override
  Widget build(BuildContext context) {
    final timerProvider = Provider.of<PickStartAndEndTimeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.transparentColor,
        title: Text(
          "Upload Program Schedule",
          style: AppTextStyles.heading1.copyWith(
            color: AppColors.mainColor,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Select Day(*)",
                style: AppTextStyles.heading1.copyWith(
                  color: AppColors.mainColor,
                ),
              ),
              DropdownButtonHideUnderline(
                child: DropdownButton(
                  hint: Text(
                    _selectedDay,
                    style: AppTextStyles.heading1.copyWith(color: AppColors.primaryWhite),
                  ),
                  dropdownColor: AppColors.mainColor,
                  style: AppTextStyles.heading1.copyWith(color: AppColors.primaryWhite),
                  onChanged: (v) {
                    setState(() {
                      _selectedDay = v!;
                    });
                  },
                  items: _days.map((e) {
                    return DropdownMenuItem(
                      value: e,
                      child: Text(
                        e,
                        style: AppTextStyles.heading1.copyWith(color: AppColors.primaryWhite),
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 30),
              Text(
                "Title (*)",
                style: AppTextStyles.heading1.copyWith(
                  color: AppColors.mainColor,
                ),
              ),
              const SizedBox(height: 10),
              CustomTextInput(title: "Program Title", controller: titleController),
              const SizedBox(height: 30),
              Text(
                "Start Time (*)",
                style: AppTextStyles.heading1.copyWith(
                  color: AppColors.mainColor,
                ),
              ),
              const SizedBox(height: 10),
              CustomTextInput(
                title: timerProvider.startTime == null ? "Start Time" : timerProvider.startTime.format(context),
                readOnly: true,
                suffixWidget: InkWell(
                  onTap: () {
                    timerProvider.setStartTime(context: context);
                  },
                  child: Icon(Icons.schedule, color: AppColors.mainColor),
                ),
              ),
              const SizedBox(height: 30),
              Text(
                "End Time (*)",
                style: AppTextStyles.heading1.copyWith(
                  color: AppColors.mainColor,
                ),
              ),
              const SizedBox(height: 10),
              CustomTextInput(
                title: timerProvider.endTime == null ? "End Time" : timerProvider.endTime.format(context),
                readOnly: true,
                suffixWidget: InkWell(
                  onTap: () {
                    timerProvider.setEndTime(context: context);
                  },
                  child: Icon(Icons.schedule, color: AppColors.mainColor),
                ),
              ),
              const SizedBox(height: 30),
              Consumer<LoadingProvider>(
                builder: (_, loadingProvider, __) {
                  return loadingProvider.isLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : PrimaryButton(
                          onTap: () async {
                            int startTime = timerProvider.startTime.hour * 60 + timerProvider.startTime.minute;
                            int endTime = timerProvider.endTime.hour * 60 + timerProvider.endTime.minute;
                            await ScheduleServices().uploadProgramSchedule(
                                context: context,
                                selectedDay: _selectedDay,
                                programTitle: titleController.text,
                                startTime: startTime,
                                endTime: endTime);
                          },
                          title: "Upload",
                        );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
