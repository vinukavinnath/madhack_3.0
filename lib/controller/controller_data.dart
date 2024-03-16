import 'package:flutter/material.dart';

class JobControllerData {
  TextEditingController jobIndustryController = TextEditingController();
  TextEditingController jobCategoryController = TextEditingController();
  TextEditingController jobLocationController = TextEditingController();
  TextEditingController jobMinSalaryController = TextEditingController();
  TextEditingController jobMaxSalaryController = TextEditingController();
  TextEditingController jobTagsController = TextEditingController();

  // Singleton pattern for accessing the instance
  static final JobControllerData _instance = JobControllerData._internal();

  factory JobControllerData() {
    return _instance;
  }

  JobControllerData._internal();
}
