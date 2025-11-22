import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/weather_controller.dart';
import '../widgets/error_widget.dart';
import '../widgets/loading_widget.dart';
import '../widgets/weather_card.dart';

class HomePage extends GetView<WeatherController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: Colors.blue[50],
        appBar: _buildAppBar(),
        body: _buildBody(),
        floatingActionButton: _buildFabButton(),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text(
        'Weather App',
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
      ),
      backgroundColor: Colors.blue[700],
      elevation: 0,
      centerTitle: true,
      actions: [
        if (controller.lastUpdateText.isNotEmpty &&
            !controller.isLoading.value &&
            controller.weather.value != null)
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Center(
              child: Text(
                controller.lastUpdateText,
                style: const TextStyle(color: Colors.white70, fontSize: 12),
              ),
            ),
          ),
      ],
    );
  }

  Container _buildBody() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.blue[700]!, Colors.blue[500]!, Colors.blue[300]!],
        ),
      ),
      child: RefreshIndicator(
        onRefresh: () async {
          controller.fetchCurrentWeather();
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const SizedBox(height: 20),

                if (controller.isLoading.value) const LoadingWidget(),

                if (controller.errorMessage.isNotEmpty &&
                    !controller.isLoading.value)
                  CustomErrorWidget(
                    message: controller.errorMessage.value,
                    onRetry: controller.fetchCurrentWeather,
                  ),

                if (controller.weather.value != null &&
                    !controller.isLoading.value)
                  WeatherCard(weather: controller.weather.value!),

                const SizedBox(height: 20),

                if (!controller.isLoading.value) _buildInfoText(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  FloatingActionButton _buildFabButton() {
    return FloatingActionButton(
      onPressed: controller.fetchCurrentWeather,
      backgroundColor: Colors.white,
      child: Icon(Icons.refresh, color: Colors.blue[700]),
    );
  }

  Widget _buildInfoText() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Text(
        'Pull down to refresh or tap the refresh button to update weather data',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white70,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
