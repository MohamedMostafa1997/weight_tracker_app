import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:weight_tracker_app/features/weight/model/weight_entry.dart';

class WeightRepo {
  final FirebaseFirestore firestore;
  final fb.FirebaseAuth auth;

  WeightRepo({FirebaseFirestore? firestore, fb.FirebaseAuth? auth})
      : firestore = firestore ?? FirebaseFirestore.instance,
        auth = auth ?? fb.FirebaseAuth.instance;

  Future<void> addWeight(double weight) async {
    final user = auth.currentUser;
    if (user == null) throw Exception('User not logged in');
    final entry = WeightEntry(
      id: '', 
      userId: user.uid,
      weight: weight,
      dateTime: DateTime.now(),
    );
    await firestore.collection('weights').add(entry.toJson());
  }

  Stream<List<WeightEntry>> userWeightsStream() {
    final user = auth.currentUser;
    if (user == null) {
      return Stream.value([]);
    }
    return firestore
        .collection('weights')
        .where('userId', isEqualTo: user.uid)
        .orderBy('dateTime', descending: true)
        .snapshots()
        .handleError((error) {
          throw Exception('Firestore stream error: $error');
        })
        .map((snapshot) {
          return snapshot.docs.map((doc) => WeightEntry.fromDoc(doc)).toList();
        });
  }

  Future<void> updateWeight(String id, double newWeight) async {
    await firestore.collection('weights').doc(id).update({
      'weight': newWeight,
      'dateTime': Timestamp.fromDate(DateTime.now()),
    });
  }

  Future<void> deleteWeight(String id) async {
    await firestore.collection('weights').doc(id).delete();
  }
}