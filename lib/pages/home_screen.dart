import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/bloc/weather_bloc.dart';
import 'package:weather_app/pages/home_page_success_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

Widget getWeatherIcon(int code) {
  switch (code) {
    case >= 200 && < 300:
      return Image.asset('assets/1.png');
    case >= 300 && < 400:
      return Image.asset('assets/2.png');
    case >= 500 && < 600:
      return Image.asset('assets/3.png');
    case >= 600 && < 700:
      return Image.asset('assets/4.png');
    case >= 700 && < 800:
      return Image.asset('assets/5.png');
    case == 800:
      return Image.asset('assets/6.png');
    case > 800 && <= 804:
      return Image.asset('assets/7.png');
    default:
      return Image.asset('assets/7.png');
  }
}

Widget getBackgroundAlignment(
  double start,
  double alignY,
  double containerWidth,
  Color? color,
) {
  return Align(
    alignment: AlignmentDirectional(start, alignY),
    child: Container(
      height: 300,
      width: containerWidth,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    ),
  );
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<WeatherBloc>().add(FetchWeatherDataEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(40, 1.2 * kToolbarHeight, 40, 20),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              getBackgroundAlignment(3, -0.3, 300, Colors.purple),
              getBackgroundAlignment(
                  3, -0.3, 300, Color.fromRGBO(103, 58, 183, 1)),
              getBackgroundAlignment(
                  0, -1.2, 600, Color.fromRGBO(255, 171, 64, 1)),
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 100.0, sigmaY: 100.0),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                  ),
                ),
              ),
              BlocBuilder<WeatherBloc, WeatherState>(
                builder: (context, state) {
                  if (state is WeatherBlocLoading) {
                    return CircularProgressIndicator();
                  } else if (state is WeatherBlocSuccess) {
                    return HomePageSuccessScreen(state);
                  } else if (state is WeatherBlocFailure) {
                    return Center(
                      child: Text('Failed to load Data'),
                    );
                  } else {
                    return Center(
                      child: Text('Something wrong Happening'),
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
