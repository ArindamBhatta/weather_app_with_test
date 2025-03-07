// ignore_for_file: avoid_print

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:weather_app/models/wether_model.dart';
import 'package:weather_app/repo/weather_repo.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherInitial()) {
    on<FetchWeatherDataEvent>((event, emit) async {
      emit(WeatherBlocLoading());
      try {
        WeatherModel? weather = await WeatherRepo.getWhetherInfo();
        if (weather != null) {
          emit(WeatherBlocSuccess(weather));
        } else {
          emit(WeatherBlocFailure());
        }
      } catch (error) {
        print(error);
      }
    });
  }
}
