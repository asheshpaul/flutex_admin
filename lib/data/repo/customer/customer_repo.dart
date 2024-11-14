import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutex_admin/core/utils/method.dart';
import 'package:flutex_admin/core/utils/url_container.dart';
import 'package:flutex_admin/data/model/customer/contact_post_model.dart';
import 'package:flutex_admin/data/model/customer/customer_post_model.dart';
import 'package:flutex_admin/data/model/global/response_model/response_model.dart';
import 'package:flutex_admin/data/services/api_service.dart';

import '../../model/customer/customer_model.dart';

class CustomerRepo {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addCustomer(Customer customer) {
    return _db
        .collection('customers')
        .doc(customer.userId)
        .set(customer.toJson());
  }

  Future<List<Customer>> getCustomers() async {
    var result = await _db.collection('customers').get();
    return result.docs.map((doc) => Customer.fromJson(doc.data())).toList();
  }

  ApiClient apiClient;

  CustomerRepo({required this.apiClient});

  Future<ResponseModel> getAllCustomers() async {
    String url = "${UrlContainer.baseUrl}${UrlContainer.customersUrl}";
    ResponseModel responseModel =
        await apiClient.request(url, Method.getMethod, null, passHeader: true);
    return responseModel;
  }

  Future<ResponseModel> getCustomerDetails(customerId) async {
    String url =
        "${UrlContainer.baseUrl}${UrlContainer.customersUrl}/$customerId";
    ResponseModel responseModel =
        await apiClient.request(url, Method.getMethod, null, passHeader: true);
    return responseModel;
  }

  Future<ResponseModel> getCustomerContacts(customerId) async {
    String url =
        "${UrlContainer.baseUrl}${UrlContainer.contactsUrl}/$customerId";
    ResponseModel responseModel =
        await apiClient.request(url, Method.getMethod, null, passHeader: true);
    return responseModel;
  }

  Future<ResponseModel> getCustomerGroups() async {
    String url =
        "${UrlContainer.baseUrl}${UrlContainer.commonDataUrl}/client_groups";
    ResponseModel responseModel =
        await apiClient.request(url, Method.getMethod, null, passHeader: true);
    return responseModel;
  }

  Future<ResponseModel> getCountries() async {
    String url =
        "${UrlContainer.baseUrl}${UrlContainer.commonDataUrl}/countries";
    ResponseModel responseModel =
        await apiClient.request(url, Method.getMethod, null, passHeader: true);
    return responseModel;
  }

  Future<ResponseModel> createCustomer(CustomerPostModel customerModel) async {
    String url = "${UrlContainer.baseUrl}${UrlContainer.customersUrl}";

    Map<String, dynamic> params = {
      "company": customerModel.company,
      "vat": customerModel.vat,
      "phonenumber": customerModel.phoneNumber,
      "website": customerModel.website,
      "groups_in": customerModel.groupsIn,
      "default_language": customerModel.defaultLanguage,
      "default_currency": customerModel.defaultCurrency,
      "address": customerModel.address,
      "city": customerModel.city,
      "state": customerModel.state,
      "zip": customerModel.zip,
      "partnership_type": customerModel.partnershipType,
      "country": customerModel.country,
      "billing_street": customerModel.billingStreet,
      "billing_city": customerModel.billingCity,
      "billing_state": customerModel.billingState,
      "billing_zip": customerModel.billingZip,
      "billing_country": customerModel.billingCountry,
      "shipping_street": customerModel.shippingStreet,
      "shipping_city": customerModel.shippingCity,
      "shipping_state": customerModel.shippingState,
      "shipping_zip": customerModel.shippingZip,
      "shipping_country": customerModel.shippingCountry,
    };

    ResponseModel responseModel = await apiClient
        .request(url, Method.postMethod, params, passHeader: true);
    return responseModel;
  }

  Future<ResponseModel> deleteCustomer(customerId) async {
    String url =
        "${UrlContainer.baseUrl}${UrlContainer.customersUrl}/$customerId";
    ResponseModel responseModel = await apiClient
        .request(url, Method.deleteMethod, null, passHeader: true);
    return responseModel;
  }

  Future<ResponseModel> searchCustomer(keysearch) async {
    String url =
        "${UrlContainer.baseUrl}${UrlContainer.customersUrl}/search/$keysearch";
    ResponseModel responseModel =
        await apiClient.request(url, Method.getMethod, null, passHeader: true);
    return responseModel;
  }

  Future<ResponseModel> createContact(ContactPostModel contactModel) async {
    String url = "${UrlContainer.baseUrl}${UrlContainer.contactsUrl}";

    Map<String, dynamic> params = {
      "customer_id": contactModel.customerId,
      "firstname": contactModel.firstName,
      "lastname": contactModel.lastName,
      "email": contactModel.email,
      "title": contactModel.title,
      "phonenumber": contactModel.phone,
      "password": contactModel.password,
    };

    ResponseModel responseModel = await apiClient
        .request(url, Method.postMethod, params, passHeader: true);
    return responseModel;
  }
}
