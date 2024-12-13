import 'package:al_quran/provider/calender/calender_info_provider.dart';
import 'package:al_quran/state_helper/get_theme.dart';
import 'package:al_quran/utils/get_location_permission.dart';
import 'package:al_quran/utils/show_toast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';

class RenderGoogleMap extends StatelessWidget {
  const RenderGoogleMap({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = getTheme(context).colors;
    final calenderInfoProvider = Provider.of<CalenderInfoProvider>(context);
    LatLng myCurrentLocation =
        LatLng(calenderInfoProvider.lat, calenderInfoProvider.lng);

    Set<Marker> markers = {};
    markers.add(
      Marker(
        markerId: MarkerId(calenderInfoProvider.lat.toString()),
        position: myCurrentLocation,
      ),
    );

    Future<void> setCurrentLocation() async {
      if (calenderInfoProvider.locationMethod == 'district') {
        return;
      }

      if (!(await getLocationPermission())) {
        showToast('Location service is off!', colors.activeColor2);
      }

      try {
        Position position = await Geolocator.getCurrentPosition();

        List<Placemark> placemarks = await placemarkFromCoordinates(
            position.latitude, position.longitude);
        Placemark place = placemarks.first;

        calenderInfoProvider.setAddressLatAndLng(
          address: '${place.locality}, ${place.administrativeArea}',
          lat: position.latitude,
          lng: position.longitude,
        );
      } catch (_) {
        showToast('Somethig went wrong!', colors.activeColor1);
      }
    }

    return Stack(
      children: [
        SizedBox(
          height: 220,
          child: GoogleMap(
            zoomControlsEnabled: false,
            myLocationButtonEnabled: false,
            markers: markers,
            onMapCreated: (GoogleMapController controller) {
              calenderInfoProvider.setMapController(controller);
            },
            initialCameraPosition: CameraPosition(
              target: myCurrentLocation,
              zoom: 10,
            ),
          ),
        ),
        Positioned(
          bottom: 20,
          right: 20,
          child: Container(
            clipBehavior: Clip.antiAlias,
            width: 35,
            height: 35,
            decoration: BoxDecoration(
              border: Border.all(color: colors.activeColor1, width: 2),
              borderRadius: BorderRadius.circular(50),
            ),
            child: FloatingActionButton(
              splashColor: Colors.grey[300],
              backgroundColor: Colors.white,
              onPressed: setCurrentLocation,
              child: Icon(
                Icons.my_location,
                size: 25,
                color: colors.activeColor1,
              ),
            ),
          ),
        )
      ],
    );
  }
}
