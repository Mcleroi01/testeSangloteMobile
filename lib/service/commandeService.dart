import 'dart:convert';
import 'package:http/http.dart' as http;

class OrderService {
  final String apiUrl = 'http://192.168.200.118:8000/api/commandes';

  Future<void> createOrder({
    required String nomClient,
    required String productName,
    required int quantity,
    required double price,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
       headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json', // Ensures Laravel responds with JSON
        },

        body: jsonEncode(<String, dynamic>{
          'nom_client': nomClient,
          'product_name': productName,
          'quantity': quantity,
          'price': price,
        }),
      );

      if (response.statusCode == 201) {
        print('Order created successfully');
      } else {
        // Decode and log the error response if available
        final errorData = jsonDecode(response.body);
        throw Exception(
            'Failed to create order: ${errorData['message'] ?? 'Unknown error'}');
      }
    } catch (e) {
      // Log the error
      print('Error creating order: $e');
      rethrow; // Re-throw the error to allow further handling
    }
  }
}
