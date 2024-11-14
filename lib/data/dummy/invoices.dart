import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/home/home_response_model.dart';

final List<DataField> dummyInvoices = [
  DataField(status: "Unpaid", total: 350, percent: "0"),
  DataField(status: "Paid", total: 5900, percent: "0"),
  DataField(status: "Unpaid", total: 3675, percent: "4.76"),
  DataField(status: "Unpaid", total: 2150, percent: "0"),
  DataField(status: "Partially Paid", total: 5074, percent: "13.24"),
  DataField(status: "Unpaid", total: 4480, percent: "4.02"),
  DataField(status: "Partially Paid", total: 7630, percent: "2.36"),
  DataField(status: "Paid", total: 6450, percent: "0"),
  DataField(status: "Paid", total: 630, percent: "0"),
  DataField(status: "Unpaid", total: 7950, percent: "0"),
  DataField(status: "Partially Paid", total: 3995, percent: "12.39"),
  DataField(status: "Paid", total: 5748, percent: "11.27"),
  DataField(status: "Partially Paid", total: 1758, percent: "6.14"),
  DataField(status: "Paid", total: 300, percent: "0"),
  DataField(status: "Partially Paid", total: 3895, percent: "1.16"),
  DataField(status: "Unpaid", total: 2180, percent: "0"),
  DataField(status: "Paid", total: 3560, percent: "7.4"),
  DataField(status: "Paid", total: 4820, percent: "8.4"),
  DataField(status: "Unpaid", total: 2550, percent: "6"),
  DataField(status: "Paid", total: 3250, percent: "5"),
];

void uploadCustomersToFirestore() async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  for (var dataField in dummyInvoices) {
    await firestore.collection('dataFields').add(dataField.toJson());
  }
  print('Data uploaded successfully');
}
