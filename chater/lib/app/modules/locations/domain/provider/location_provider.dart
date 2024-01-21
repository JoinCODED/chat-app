import 'package:chater/app/modules/locations/domain/provider/controller/location_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final locationProviders = ChangeNotifierProvider((ref) => LocationController());
