import 'package:equatable/equatable.dart';
import 'package:grumbler/models/map_screen_settings.dart';

abstract class MapScreenSate extends Equatable{
  @override
  List<Object?> get props => [];
}

class MapScreenInitialState extends MapScreenSate
{

}

class MapScreenSettingsChangedState extends MapScreenSate
{
  final MapScreenSettings settings;

  MapScreenSettingsChangedState(this.settings);

  @override
  List<Object?> get props => [settings];
}