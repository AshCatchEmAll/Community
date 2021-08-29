import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  LocationBloc() : super(LocationInitial());

  @override
  Stream<LocationState> mapEventToState(
    LocationEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
