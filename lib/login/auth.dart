import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// val capitalCities = db.collection("cities").whereEqualTo("capital", true);
final CollectionReference ownerCollection =
    FirebaseFirestore.instance.collection('Owner');
    
