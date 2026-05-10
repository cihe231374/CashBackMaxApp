# CashBack & Rewards Points Maximiser

High-fidelity Flutter prototype for a reward-card recommendation app.

## Added features
- Real recommendation logic using points, cashback, bonus offers, and fees.
- Location detection using `geolocator`.
- Store/geofence simulation with supported store coordinates.
- Smart notification trigger that avoids repeated alerts for the same store.
- Manual store fallback from the Map screen.

## Run
```bash
flutter pub get
flutter run
```

## Notes
For a real deployment, replace the demo store coordinates in `lib/services/store_service.dart` with real store coordinates and connect reward offers to a backend/API.
