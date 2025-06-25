//ValueNotifier -> holds the data
//ValueListenableBuilder -> listen to the data change (we don't need the setState)

import 'package:flutter/material.dart';

ValueNotifier<int> selectedPageNotifier = ValueNotifier(0);
ValueNotifier<bool> isDarkModeNotifier = ValueNotifier(true);