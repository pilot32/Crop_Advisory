/// Location Service
/// 
/// Handles location permissions and fetching user's current location
/// Uses Geolocator for precise location and Geocoding for address lookup

import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:logger/logger.dart';

part 'location_service.g.dart';

/// Location service provider
@Riverpod(keepAlive: true)
LocationService locationService(LocationServiceRef ref) {
  return LocationService();
}

/// Service class for location operations
class LocationService {
  final Logger _logger = Logger();

  /// Check if location services are enabled
  Future<bool> isLocationServiceEnabled() async {
    try {
      return await Geolocator.isLocationServiceEnabled();
    } catch (e) {
      _logger.e('Error checking location service: $e');
      return false;
    }
  }

  /// Check location permission status
  Future<LocationPermission> checkPermission() async {
    try {
      return await Geolocator.checkPermission();
    } catch (e) {
      _logger.e('Error checking location permission: $e');
      return LocationPermission.denied;
    }
  }

  /// Request location permission
  Future<LocationPermission> requestPermission() async {
    try {
      _logger.i('Requesting location permission');
      return await Geolocator.requestPermission();
    } catch (e) {
      _logger.e('Error requesting location permission: $e');
      return LocationPermission.denied;
    }
  }

  /// Get current position with error handling
  /// 
  /// Returns: Position object with latitude, longitude, accuracy, etc.
  /// Throws: Exception if location cannot be determined
  Future<Position> getCurrentPosition() async {
    try {
      _logger.i('Getting current position');

      // Check if location service is enabled
      final serviceEnabled = await isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw Exception('Location services are disabled. Please enable them in settings.');
      }

      // Check permission
      LocationPermission permission = await checkPermission();
      
      if (permission == LocationPermission.denied) {
        permission = await requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception('Location permissions are denied');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw Exception('Location permissions are permanently denied. Please enable them in settings.');
      }

      // Get position
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      _logger.i('Position obtained: ${position.latitude}, ${position.longitude}');
      return position;
    } catch (e) {
      _logger.e('Error getting current position: $e');
      rethrow;
    }
  }

  /// Get address from coordinates (reverse geocoding)
  /// 
  /// Parameters:
  /// - [latitude]: Latitude coordinate
  /// - [longitude]: Longitude coordinate
  /// 
  /// Returns: List of Placemark objects containing address information
  Future<List<Placemark>> getAddressFromCoordinates({
    required double latitude,
    required double longitude,
  }) async {
    try {
      _logger.i('Getting address for coordinates: $latitude, $longitude');
      
      final placemarks = await placemarkFromCoordinates(latitude, longitude);
      
      if (placemarks.isEmpty) {
        throw Exception('No address found for these coordinates');
      }

      _logger.i('Address found: ${placemarks.first.locality}');
      return placemarks;
    } catch (e) {
      _logger.e('Error getting address from coordinates: $e');
      rethrow;
    }
  }

  /// Get coordinates from address (forward geocoding)
  /// 
  /// Parameters:
  /// - [address]: Address string to search for
  /// 
  /// Returns: List of Location objects containing coordinates
  Future<List<Location>> getCoordinatesFromAddress(String address) async {
    try {
      _logger.i('Getting coordinates for address: $address');
      
      final locations = await locationFromAddress(address);
      
      if (locations.isEmpty) {
        throw Exception('No location found for this address');
      }

      _logger.i('Coordinates found: ${locations.first.latitude}, ${locations.first.longitude}');
      return locations;
    } catch (e) {
      _logger.e('Error getting coordinates from address: $e');
      rethrow;
    }
  }

  /// Get formatted address as a single string
  /// 
  /// Parameters:
  /// - [latitude]: Latitude coordinate
  /// - [longitude]: Longitude coordinate
  /// 
  /// Returns: Formatted address string
  Future<String> getFormattedAddress({
    required double latitude,
    required double longitude,
  }) async {
    try {
      final placemarks = await getAddressFromCoordinates(
        latitude: latitude,
        longitude: longitude,
      );

      if (placemarks.isEmpty) {
        return 'Unknown location';
      }

      final place = placemarks.first;
      final parts = <String>[];

      if (place.locality != null && place.locality!.isNotEmpty) {
        parts.add(place.locality!);
      }
      if (place.subAdministrativeArea != null && place.subAdministrativeArea!.isNotEmpty) {
        parts.add(place.subAdministrativeArea!);
      }
      if (place.administrativeArea != null && place.administrativeArea!.isNotEmpty) {
        parts.add(place.administrativeArea!);
      }

      return parts.join(', ');
    } catch (e) {
      _logger.e('Error getting formatted address: $e');
      return 'Unknown location';
    }
  }

  /// Get distance between two points in meters
  /// 
  /// Parameters:
  /// - [startLatitude]: Start point latitude
  /// - [startLongitude]: Start point longitude
  /// - [endLatitude]: End point latitude
  /// - [endLongitude]: End point longitude
  /// 
  /// Returns: Distance in meters
  double getDistanceBetween({
    required double startLatitude,
    required double startLongitude,
    required double endLatitude,
    required double endLongitude,
  }) {
    try {
      return Geolocator.distanceBetween(
        startLatitude,
        startLongitude,
        endLatitude,
        endLongitude,
      );
    } catch (e) {
      _logger.e('Error calculating distance: $e');
      return 0;
    }
  }

  /// Stream of location updates
  /// 
  /// Parameters:
  /// - [distanceFilter]: Minimum distance (meters) before update
  /// 
  /// Returns: Stream of Position objects
  Stream<Position> getPositionStream({int distanceFilter = 100}) {
    return Geolocator.getPositionStream(
      locationSettings: LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: distanceFilter,
      ),
    );
  }
}
