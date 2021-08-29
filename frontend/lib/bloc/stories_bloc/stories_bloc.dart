import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'stories_event.dart';
part 'stories_state.dart';

class StoriesBloc extends Bloc<StoriesEvent, StoriesState> {
  StoriesBloc() : super(StoriesInitial());

  @override
  Stream<StoriesState> mapEventToState(
    StoriesEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
