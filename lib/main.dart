import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

void main() {
  runApp(MovieReviewApp());
}

class MovieReviewApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie Review App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ReviewForm(),
    );
  }
}

class ReviewForm extends StatefulWidget {
  @override
  _ReviewFormState createState() => _ReviewFormState();
}

class _ReviewFormState extends State<ReviewForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _reviewController = TextEditingController();
  double _rating = 1.0; // Ensuring minimum rating is 1
  String _gender = 'Male';

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final formData = {
        'name': _nameController.text,
        'surname': _surnameController.text,
        'dob': _dobController.text,
        'address': _addressController.text,
        'email': _emailController.text,
        'phone': _phoneController.text,
        'gender': _gender,
        'review': _reviewController.text,
        'rating': _rating,
      };

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ReviewDisplayPage(formData: formData),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movie Review', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blueAccent, Colors.lightBlueAccent, Colors.blueAccent]
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              SizedBox(height: 12),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(filled: true, labelText: 'Name', prefixIcon: Icon(Icons.person)),
                validator: (value) => value!.isEmpty ? 'Enter your name' : null,
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: _surnameController,
                decoration: InputDecoration(filled: true, labelText: 'Surname', prefixIcon: Icon(Icons.person_outline)),
                validator: (value) => value!.isEmpty ? 'Enter your surname' : null,
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: _dobController,
                decoration: InputDecoration(filled: true, labelText: 'Date of Birth', prefixIcon: Icon(Icons.calendar_month)),
                validator: (value) => value!.isEmpty ? 'Enter your date of birth' : null,
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: _addressController,
                decoration: InputDecoration(filled: true, labelText: 'Address', prefixIcon: Icon(Icons.home)),
                validator: (value) => value!.isEmpty ? 'Enter your address' : null,
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(filled: true, labelText: 'Email', prefixIcon: Icon(Icons.email)),
                validator: (value) => value!.isEmpty ? 'Enter your email' : null,
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(filled: true, labelText: 'Phone Number', prefixIcon: Icon(Icons.phone)),
                validator: (value) => value!.isEmpty ? 'Enter your phone number' : null,
              ),
              SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: _gender,
                onChanged: (String? newValue) {
                  setState(() {
                    _gender = newValue!;
                  });
                },
                items: ['Male', 'Female', 'Other']
                    .map((String gender) => DropdownMenuItem(value: gender, child: Text(gender)))
                    .toList(),
                decoration: InputDecoration(filled: true, labelText: 'Gender', prefixIcon: Icon(Icons.wc)),
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: _reviewController,
                decoration: InputDecoration(filled: true, labelText: 'Review', prefixIcon: Icon(Icons.comment)),
                validator: (value) => value!.isEmpty ? 'Please write a review' : null,
              ),
              SizedBox(height: 12),

              Center(
                child: Column(
                  children: [
                    Text("Rating: $_rating"),
                    RatingBar.builder(
                      initialRating: 1.0,
                      minRating: 1.0,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, index) {
                        IconData icon;
                        if (index == 0) {
                          icon = Icons.sentiment_very_dissatisfied;
                        } else if (index == 1) {
                          icon = Icons.sentiment_dissatisfied;
                        } else if (index == 2) {
                          icon = Icons.sentiment_neutral;
                        } else if (index == 3) {
                          icon = Icons.sentiment_satisfied;
                        } else {
                          icon = Icons.sentiment_very_satisfied;
                        }
                        return Icon(icon, color: Colors.amber);
                      },
                      onRatingUpdate: (rating) {
                        setState(() {
                          _rating = rating;
                        });
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              FilledButton(
                onPressed: _submitForm,
                child: const Text('Confirm'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ReviewDisplayPage extends StatelessWidget {
  final Map<String, dynamic> formData;

  const ReviewDisplayPage({Key? key, required this.formData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Review Details', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blueAccent, Colors.lightBlueAccent, Colors.blueAccent]
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView(
                children: [
                  _buildDetailRow('Name', "${formData['name']} ${formData['surname']}"),
                  _buildDetailRow('Date of Birth', formData['dob']),
                  _buildDetailRow('Address', formData['address']),
                  _buildDetailRow('Email', formData['email']),
                  _buildDetailRow('Phone', formData['phone']),
                  _buildDetailRow('Gender', formData['gender']),
                  _buildDetailRow('Review', formData['review']),
                  _buildDetailRow('Rating', "${formData['rating']} stars"),
                ],
              ),
            ),
            Center(
              child: FilledButton(
                onPressed: () => _showConfirmationSnackbar(context),
                child: const Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [Text("$label: ", style: const TextStyle(fontWeight: FontWeight.bold)), Expanded(child: Text(value))],
      ),
    );
  }

  void _showConfirmationSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: const Text('Thank you for your review!')));
  }
}
