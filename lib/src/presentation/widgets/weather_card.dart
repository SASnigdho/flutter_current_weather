import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/weather_entity.dart';

class WeatherCard extends StatelessWidget {
  final WeatherEntity weather;

  const WeatherCard({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color:
              Theme.of(context).cardTheme.color ?? Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            // Location Name with Country - REQUIRED
            _buildLocationSection(context),
            const SizedBox(height: 24),

            // Main Weather Info - REQUIRED: Temperature, Condition, Icon
            _buildMainWeatherSection(context),
            const SizedBox(height: 24),

            // Temperature Range - REQUIRED: Min/Max Temperatures
            _buildTemperatureRangeSection(context),
            const SizedBox(height: 16),

            // Additional Weather Info
            _buildAdditionalInfoSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationSection(BuildContext context) {
    return Column(
      children: [
        Text(
          weather.cityName,
          style: Theme.of(
            context,
          ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        if (weather.countryCode.isNotEmpty) ...[
          const SizedBox(height: 4),
          Text(
            weather.countryCode,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
        const SizedBox(height: 8),
        Text(
          DateFormat('EEEE, MMMM d, y').format(DateTime.now()),
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }

  Widget _buildMainWeatherSection(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        // Weather Icon and Description - REQUIRED
        Column(
          children: [
            Image.network(
              'https://openweathermap.org/img/wn/${weather.iconCode}@2x.png',
              width: 80,
              height: 80,
              errorBuilder: (context, error, stackTrace) {
                return Icon(
                  _getWeatherIcon(weather.condition),
                  size: 64,
                  color: Colors.orange,
                );
              },
            ),
            const SizedBox(height: 8),
            // Weather Condition - REQUIRED
            Text(
              weather.condition,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            if (weather.description.isNotEmpty &&
                weather.description != weather.condition) ...[
              const SizedBox(height: 4),
              Text(
                '(${weather.description})',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ],
        ),

        // Current Temperature - REQUIRED
        Column(
          children: [
            Text(
              '${weather.temperature.round()}°C',
              style: Theme.of(
                context,
              ).textTheme.displayMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            Text(
              'Feels like ${weather.feelsLike.round()}°C',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTemperatureRangeSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // Minimum Temperature - REQUIRED
          _buildTemperatureItem(
            context,
            icon: Icons.arrow_downward,
            label: 'Min Temp',
            value: '${weather.tempMin.round()}°C',
            color: Colors.blue,
          ),

          // Divider
          Container(
            width: 1,
            height: 40,
            color: Theme.of(context).dividerColor,
          ),

          // Maximum Temperature - REQUIRED
          _buildTemperatureItem(
            context,
            icon: Icons.arrow_upward,
            label: 'Max Temp',
            value: '${weather.tempMax.round()}°C',
            color: Colors.red,
          ),
        ],
      ),
    );
  }

  Widget _buildTemperatureItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Column(
      children: [
        Icon(icon, color: color, size: 24),
        const SizedBox(height: 4),
        Text(label, style: Theme.of(context).textTheme.bodySmall),
        const SizedBox(height: 2),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildAdditionalInfoSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildAdditionalInfoItem(
            context,
            icon: Icons.water_drop,
            label: 'Humidity',
            value: '${weather.humidity}%',
          ),
          _buildAdditionalInfoItem(
            context,
            icon: Icons.air,
            label: 'Wind Speed',
            value: '${weather.windSpeed.toStringAsFixed(1)} m/s',
          ),
          _buildAdditionalInfoItem(
            context,
            icon: Icons.speed,
            label: 'Pressure',
            value: '${weather.pressure} hPa',
          ),
          if (weather.visibility > 0)
            _buildAdditionalInfoItem(
              context,
              icon: Icons.visibility,
              label: 'Visibility',
              value: '${(weather.visibility / 1000).toStringAsFixed(1)} km',
            ),
        ],
      ),
    );
  }

  Widget _buildAdditionalInfoItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Column(
      children: [
        Icon(icon, color: Theme.of(context).colorScheme.primary, size: 20),
        const SizedBox(height: 4),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  IconData _getWeatherIcon(String condition) {
    switch (condition.toLowerCase()) {
      case 'clear':
        return Icons.wb_sunny;
      case 'clouds':
        return Icons.cloud;
      case 'rain':
        return Icons.beach_access;
      case 'drizzle':
        return Icons.grain;
      case 'thunderstorm':
        return Icons.flash_on;
      case 'snow':
        return Icons.ac_unit;
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
      case 'sand':
      case 'ash':
      case 'squall':
      case 'tornado':
        return Icons.blur_on;
      default:
        return Icons.wb_cloudy;
    }
  }
}
