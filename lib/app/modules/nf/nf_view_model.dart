import 'package:flutter/material.dart';
import 'package:metal_forte/app/core/enums/storage_status_enum.dart';
import 'package:metal_forte/app/core/models/text_controller.dart';

class NfsViewModel {
  PageController pageController = PageController();
  StorageStatusEnum storageStatus = StorageStatusEnum.aberta;
  bool showSearch = false;
  TextController searchController = TextController();
}
