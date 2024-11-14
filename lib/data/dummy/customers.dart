import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../model/customer/customer_model.dart';

/// Function to generate a random user userId
String generateUserId() {
  const characters =
      'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
  return List.generate(
      20, (index) => characters[Random().nextInt(characters.length)]).join();
}

final List<Customer> dummyCustomers = [
  Customer(
    userId: generateUserId(),
    company: "Dicki, Ferry and Abbott",
    phoneNumber: "+1-267-944-0388",
    active: "Yes",
    dateCreated: "2024-11-14 14:00:06",
  ),
  Customer(
    userId: generateUserId(),
    company: "Franecki LLC",
    phoneNumber: "+1-870-755-3070",
    active: "Yes",
    dateCreated: "2024-11-14 14:00:06",
  ),
  Customer(
    userId: generateUserId(),
    company: "Franecki, Zulauf and Lind",
    phoneNumber: "+1 (747) 600-6451",
    active: "Yes",
    dateCreated: "2024-11-14 14:00:06",
  ),
  Customer(
    userId: generateUserId(),
    company: "Gaylord-Orn",
    phoneNumber: "+1 (689) 567-4730",
    active: "Yes",
    dateCreated: "2024-11-14 14:00:06",
  ),
  Customer(
    userId: generateUserId(),
    company: "Gusikowski, Zemlak and Rau",
    phoneNumber: "(913) 716-7257",
    active: "Yes",
    dateCreated: "2024-11-14 14:00:06",
  ),
  Customer(
    userId: generateUserId(),
    company: "Hickle, Schultz and Goldner",
    phoneNumber: "1-215-756-9265",
    active: "Yes",
    dateCreated: "2024-11-14 14:00:06",
  ),
  Customer(
    userId: generateUserId(),
    company: "Koelpin-Streich",
    phoneNumber: "+1-845-991-9996",
    active: "Yes",
    dateCreated: "2024-11-14 14:00:06",
  ),
  Customer(
    userId: generateUserId(),
    company: "Lakin-Kozey",
    phoneNumber: "1-773-413-9855",
    active: "Yes",
    dateCreated: "2024-11-14 14:00:06",
  ),
  Customer(
    userId: generateUserId(),
    company: "Schamberger and Sons",
    phoneNumber: "+1 (914) 336-9073",
    active: "Yes",
    dateCreated: "2024-11-14 14:00:06",
  ),
  Customer(
    userId: generateUserId(),
    company: "Schowalter, Sporer and Schultz",
    phoneNumber: "+1 (872) 455-3793",
    active: "Yes",
    dateCreated: "2024-11-14 14:00:06",
  ),
];

/// Function to upload dummy customers to Firestore
void uploadCustomers() async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  for (var customer in dummyCustomers) {
    await firestore
        .collection('customers')
        .doc(customer.userId)
        .set(customer.toJson());
  }
  if (kDebugMode) {
    print('Customers uploaded successfully');
  }
}
