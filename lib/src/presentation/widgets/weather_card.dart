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
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue[50]!, Colors.white, Colors.blue[100]!],
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            // Location Name with Country - REQUIRED
            _buildLocationSection(),
            const SizedBox(height: 24),

            // Main Weather Info - REQUIRED: Temperature, Condition, Icon
            _buildMainWeatherSection(),
            const SizedBox(height: 24),

            // Temperature Range - REQUIRED: Min/Max Temperatures
            _buildTemperatureRangeSection(),
            const SizedBox(height: 16),

            // Additional Weather Info
            _buildAdditionalInfoSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationSection() {
    return Column(
      children: [
        Text(
          weather.cityName,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.blueGrey,
          ),
          textAlign: TextAlign.center,
        ),
        if (weather.countryCode.isNotEmpty) ...[
          const SizedBox(height: 4),
          Text(
            weather.countryCode,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
        const SizedBox(height: 8),
        Text(
          DateFormat('EEEE, MMMM d, y').format(DateTime.now()),
          style: TextStyle(fontSize: 16, color: Colors.grey[600]),
        ),
      ],
    );
  }

  Widget _buildMainWeatherSection() {
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
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
            if (weather.description.isNotEmpty &&
                weather.description != weather.condition) ...[
              const SizedBox(height: 4),
              Text(
                '(${weather.description})',
                style: TextStyle(fontSize: 12, color: Colors.grey[500]),
              ),
            ],
          ],
        ),

        // Current Temperature - REQUIRED
        Column(
          children: [
            Text(
              '${weather.temperature.round()}°C',
              style: const TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey,
              ),
            ),
            Text(
              'Feels like ${weather.feelsLike.round()}°C',
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTemperatureRangeSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue[100]!),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // Minimum Temperature - REQUIRED
          _buildTemperatureItem(
            icon: Icons.arrow_downward,
            label: 'Min Temp',
            value: '${weather.tempMin.round()}°C',
            color: Colors.blue,
          ),

          // Divider
          Container(width: 1, height: 40, color: Colors.blue[200]),

          // Maximum Temperature - REQUIRED
          _buildTemperatureItem(
            icon: Icons.arrow_upward,
            label: 'Max Temp',
            value: '${weather.tempMax.round()}°C',
            color: Colors.red,
          ),
        ],
      ),
    );
  }

  Widget _buildTemperatureItem({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Column(
      children: [
        Icon(icon, color: color, size: 24),
        const SizedBox(height: 4),
        Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
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

  Widget _buildAdditionalInfoSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue[100]!),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildAdditionalInfoItem(
            icon: Icons.water_drop,
            label: 'Humidity',
            value: '${weather.humidity}%',
          ),
          _buildAdditionalInfoItem(
            icon: Icons.air,
            label: 'Wind Speed',
            value: '${weather.windSpeed.toStringAsFixed(1)} m/s',
          ),
          _buildAdditionalInfoItem(
            icon: Icons.speed,
            label: 'Pressure',
            value: '${weather.pressure} hPa',
          ),
          if (weather.visibility > 0)
            _buildAdditionalInfoItem(
              icon: Icons.visibility,
              label: 'Visibility',
              value: '${(weather.visibility / 1000).toStringAsFixed(1)} km',
            ),
        ],
      ),
    );
  }

  Widget _buildAdditionalInfoItem({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Column(
      children: [
        Icon(icon, color: Colors.blue[700], size: 20),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(fontSize: 10, color: Colors.grey[600]),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.blueGrey,
          ),
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
