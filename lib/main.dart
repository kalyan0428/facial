import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Splash Screen Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
    );
  }
}



class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const RegisteredPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset('assets/ass.png', height: 150),
      ),
    );
  }
}




class RegisteredPage extends StatefulWidget {
  const RegisteredPage({super.key});

  @override
  _RegisteredPageState createState() => _RegisteredPageState();
}

class _RegisteredPageState extends State<RegisteredPage> {
  final TextEditingController _mobileNumberController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();

  bool _otpSent = false;

  Future<void> _sendOtp(String number) async {
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      _otpSent = true;
    });
  }

  Future<bool> _verifyOtp(String otp) async {
    await Future.delayed(Duration(seconds: 2));
    return otp == "123456";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Center(
              child: Image.asset(
                'assets/ass.png',
                width: 150,
                height: 150,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Registration Page',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: const Color(0xFF0033A0)),
                    ),
                    child: TextField(
                      controller: _mobileNumberController,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                        hintText: 'Enter mobile number',
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () async {
                    final String number = _mobileNumberController.text;
                    if (number.isNotEmpty) {
                      await _sendOtp(number);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('OTP sent to $number')),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please enter a mobile number')),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF0033A0),
                    shape: const StadiumBorder(),
                  ),
                  child: const Text(
                    'Send OTP',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: const Color(0xFF0033A0)),
              ),
              child: TextField(
                controller: _nameController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                  hintText: 'Enter name',
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Color(0xFF0033A0)),
              ),
              child: TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                  hintText: 'Enter email (optional)',
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: const Color(0xFF0033A0)),
                    ),
                    child: TextField(
                      controller: _otpController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                        hintText: 'Enter OTP',
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: () async {
                    final String number = _mobileNumberController.text;
                    if (number.isNotEmpty) {
                      await _sendOtp(number); // Resend the OTP
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('OTP resent to $number')),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please enter a mobile number')),
                      );
                    }
                  },
                  child: const Text(
                    'Resend OTP',
                    style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // navigate to the DashboardScreen
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => DashboardScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: const StadiumBorder(),
              ),
              child: const Text(
                'Register',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}





class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 150,
              height: 150,
              child: Image.asset(
                'assets/ass.png',
                fit: BoxFit.cover,
              ),
            ),
            const Text(
              'Lockers Availability',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            const SizedBox(height: 70),


            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildAvailabilityBox("SMALL\n3X3"),
                const SizedBox(width: 30),
                _buildAvailabilityBox("MEDIUM\n4X4"),
              ],
            ),
            const SizedBox(height: 30),
            _buildAvailabilityBox("LARGE\n5X5"),
            const SizedBox(height: 100),

            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.3,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const WelcomePage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                  ),
                  child: const Text(
                    'Start',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 25),
            const Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.only(right: 45.0),
                child: Text(
                  '  Click on Start to drop or pickup a parcel',
                  style: TextStyle(
                    fontSize: 17,
                    color: Color(0xFF0033A0),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PrivacyPolicyScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    'Privacy Policy',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TermsOfServiceScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    'Terms and Conditions',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvailabilityBox(String text) {
    return Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(
        color: Colors.blue[900],
        borderRadius: BorderRadius.circular(10),
      ),
      alignment: Alignment.center,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}





class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  bool isDropSelected = true; // Initially, "Drop" is selected

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          titleSpacing: 0,
          title: Row(
            children: [
              // Drop Option
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      isDropSelected = true;
                    });
                  },
                  child: Container(
                    color: isDropSelected ? Colors.blue[900] : Colors.grey,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: const Text(
                      'Drop',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              // Pickup Option
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      isDropSelected = false; // Select Pickup
                    });
                  },
                  child: Container(
                    color: !isDropSelected ? Colors.red : Colors.grey,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: const Text(
                      'Pickup',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
          automaticallyImplyLeading: false,
        ),
      ),
      body: Center(
        // Conditionally render DropFragment or PickupFragment
        child: isDropSelected
            ? const DropFragment()
            : const PickupFragment(),
      ),
    );
  }
}


class DropFragment extends StatefulWidget {
  const DropFragment({super.key});

  @override
  _DropFragmentState createState() => _DropFragmentState();
}

class _DropFragmentState extends State<DropFragment> {
  Timer? _timer;
  int _start = 60;
  bool _canResendOtp = true;
  bool _showFaceAuthScreen = false;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _canResendOtp = false;
    _start = 60;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_start == 0) {
        setState(() {
          _canResendOtp = true;
        });
        timer.cancel();
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  void _resendOtp() {
    if (_canResendOtp) {
      _startTimer();
      print('OTP Resent');
    }
  }

  @override
  Widget build(BuildContext context) {
    return _showFaceAuthScreen
        ? const FaceAuthenticationScreen()
        : Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Image.asset(
              'assets/ass.png',
              height: 100,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Please enter mobile number:',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.blue[900],
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    labelText: 'Mobile Number',
                  ),
                  style: const TextStyle(height: 1.5),
                ),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: _resendOtp,
                child: Text(
                  _canResendOtp ? 'Resend OTP' : 'Resend in $_start s',
                  style: TextStyle(
                    color: _canResendOtp ? Colors.red : Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Center(
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                shape: const StadiumBorder(),
                backgroundColor: Colors.blue[900],
              ),
              child: const Text(
                'Send OTP',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Please enter OTP',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.blue[900],
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    labelText: 'OTP',
                  ),
                  style: const TextStyle(height: 1.5),
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  shape: const StadiumBorder(),
                  backgroundColor: Colors.blue[900],
                ),
                child: const Text(
                  'Verify OTP',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Center(
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  _showFaceAuthScreen = true;
                });
              },
              style: ElevatedButton.styleFrom(
                shape: const StadiumBorder(),
                backgroundColor: Colors.red,
              ),
              child: const Text(
                'Submit',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FaceAuthenticationScreen extends StatefulWidget {
  const FaceAuthenticationScreen({super.key});

  @override
  _FaceAuthenticationScreenState createState() => _FaceAuthenticationScreenState();
}

class _FaceAuthenticationScreenState extends State<FaceAuthenticationScreen> {
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();
  bool _isCodeScreenVisible = false;

  // Method to pick an image from the camera
  Future<void> _captureImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
      } else {
        print('No image captured.');
      }
    });
  }


  void _submitImage() {
    if (_imageFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please capture an image first.')),
      );
      return;
    }


    setState(() {
      _isCodeScreenVisible = true;
    });


  }


  Widget _buildCodeScreenFragment() {
    return CodeScreenFragment();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              if (_isCodeScreenVisible)
                _buildCodeScreenFragment()
              else ...[

                SizedBox(
                  width: 150,
                  height: 150,
                  child: Image.asset(
                    'assets/ass.png',
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Face Authentication',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
                const SizedBox(height: 20),
                _imageFile != null
                    ? ClipOval(
                  child: Image.file(
                    _imageFile!,
                    height: 250,
                    width: 250,
                    fit: BoxFit.cover,
                  ),
                )
                    : ClipOval(
                  child: Container(
                    color: Colors.grey[200],
                    height: 250,
                    width: 250,
                    child: Icon(Icons.face, size: 120, color: Colors.blue[900]),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: _captureImage,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[900],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                      ),
                      child: const Text(
                        'Capture',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: _submitImage,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                      ),
                      child: const Text(
                        'Submit',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}



class CodeScreenFragment extends StatefulWidget {
  const CodeScreenFragment({super.key});

  @override
  _CodeScreenFragmentState createState() => _CodeScreenFragmentState();
}

class _CodeScreenFragmentState extends State<CodeScreenFragment> {
  bool _isPaymentVisible = false;

  @override
  Widget build(BuildContext context) {
    return _isPaymentVisible ? const PaymentFragment() : _buildMpinForm();
  }

  Widget _buildMpinForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Center(
          child: Image.asset(
            'assets/ass.png',
            height: 100,
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Text(
            'Create your M-PIN:',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.blue[900],
            ),
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: 'Enter M-PIN',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Text(
            'Re-enter your M-PIN:',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.blue[900],
            ),
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: 'Re-enter M-PIN',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Center(
          child: ElevatedButton(
            onPressed: () {

              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text(
                      'Success',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Facial and M-PIN scanned successfully!',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[900],
                          ),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {

                            setState(() {
                              _isPaymentVisible = true;
                            });
                            Navigator.of(context).pop();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue[900],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                          ),
                          child: const Text(
                            'Payment',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    backgroundColor: Colors.white,
                  );
                },
              );

            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
            ),
            child: const Text(
              'Submit',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}






class PaymentFragment extends StatelessWidget {
  const PaymentFragment({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue[900],
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Choose a Payment Method:',
            style: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Google Pay selected')),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white, // White background for button
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: Text(
              'Google Pay',
              style: TextStyle(
                fontSize: 18,
                color: Colors.blue[900],
              ),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('PhonePe selected')),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: Text(
              'PhonePe',
              style: TextStyle(
                fontSize: 18,
                color: Colors.blue[900],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PickupFragment extends StatelessWidget {
  const PickupFragment({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Top Image
            Image.asset(
              'assets/ass.png',
              height: 150,
              width: 200,
            ),
            const SizedBox(height: 20),


            Text(
              'Enter your phone number:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue[900],
              ),
            ),
            const SizedBox(height: 20),


            Container(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: TextField(
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: 'Phone Number',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),


            ElevatedButton(
              onPressed: () {

              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[900],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              ),
              child: const Text(
                'Submit',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



class TermsOfServiceScreen extends StatelessWidget {
  const TermsOfServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Terms and Conditions'),
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Privacy Policy content
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Zibomo Terminal Application\n\n'
                          'TERMS AND CONDITIONS OF SERVICE AND USE\n\n',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold, // Bold heading
                      ),
                    ),
                    Text(
                      '1. GENERAL',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    Text(
                      'Zibomo Sprint Safe registered and having its registered office at 5-A/2, IDA, Nacharam, Telangana, 500076, and Head office at Plot# 54, 2-119/54/1F, Road#10, Panchavati Colony, Manikonda, Hyderabad- 500089, hereinafter referred to as the “Company” (where such expression shall, unless repugnant to the context thereof, be deemed to include its respective legal heirs, representatives, administrators, permitted successors and assigns).\n\n'
                          'The Company ensures steady commitment to your usage of the Platform and privacy with regard to the protection of your invaluable information. This document contains information about the Zibomo Terminal Application hereinafter referred to as the “Platform”.\n\n',
                    ),
                    Text(
                      '2. DEFINITION',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    Text(
                      'For the purpose of these Terms of Use (“Terms”), wherever the context so requires,\n\n'
                          '“We”, “Our”, and “Us” shall mean and refer to the Platform and/or the Company, as the context so requires.\n'
                          '“User” shall mean and refer to natural and legal individuals who use the Platform and who is of sound mind and competent to make sound and informed decisions.\n'
                          '“Services” shall refer to the platform that provides smart locker facility for its Users. A detailed explanation of Services provided by the Company can be found in Clause 4 of this Terms of Service.\n'
                          '“Third Parties” refer to any Application, legal entity or individual apart from the User and the creator of this Platform.\n'
                          'The term “Platform” refers to the Website which provides the user with smart locker facilities.\n'
                          'The term “minor” shall mean and include a person who has not completed the age of eighteen years.\n'
                          '“Partnered Customers” shall mean persons who register with the Platform and enjoy the services provided by the Company.\n\n',
                    ),
                    Text(
                      '3. GENERAL TERMS',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    Text(
                      'The headings of each section in these Terms are only for the purpose of organizing the various provisions under these Terms in an orderly manner and shall not be used by either Party to interpret the provisions contained herein in any manner. Further, it is specifically agreed to by the Parties that the headings shall have no legal or contractual value.\n'
                          'The use of this Platform by the Users is solely governed by these Terms of Service and the Privacy Policy, and any modifications or amendments made thereto by the Company, from time to time, at its sole discretion. If you continue to access and use this Platform, you are agreeing to comply with and be bound by the following Terms and Conditions of Use and other Policies mentioned above. The User expressly agrees and acknowledges that these Terms of Service and other Policies are co-terminus in nature and that expiry/termination of either one will lead to the termination of the other.\n'
                          'The User unequivocally agrees that these Terms and the aforementioned Policy constitute a legally binding agreement between the User and the Company, and that the User shall be subject to the rules, guidelines, policies, terms, and conditions applicable to any service that is provided by the Platform, and that the same shall be deemed to be incorporated into these Terms, and shall be treated as part and parcel of the same. The User acknowledges and agrees that no signature or express act is required to make these Terms and the Policy binding on the User and that the User’s act of visiting any part of the Platform constitutes the User’s full and final acceptance of these Terms and the aforementioned Policy.\n'
                          'The Company reserves the sole and exclusive right to amend or modify these Terms without any prior permission or intimation to the User, and the User expressly agrees that any such amendments or modifications shall come into effect immediately. If the User does not adhere to the changes, they must stop using the Services at once. Their continuous use of the Services will signify your acceptance of the changed terms.\n\n',
                    ),
                    Text(
                      '4. SERVICE OVERVIEW',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    Text(
                      'The platform provides the following Services to its User:\n\n'
                          'Smart – Locker Facilities: The Company shall install smart lockers in various places such as gated communities, offices, Metro Stations, Airports, Railway Stations, Bus stations, IT Parks, Beaches, etc. Users can enter their mobile number to pick up or drop their package. The Smart Lockers having an account with the Platform can drop or pick up packages using OTP Authentication to their mobile phone number.\n'
                          'Credit Facilities: The Company shall credit a certain amount of the subscription fee (mutually agreed between the parties) paid by the User in their User Account every month. Users, when they avail locker facilities from the Company to drop off their package from vendors such as e-commerce businesses, can avail of Cash on Delivery Payment, and such Payment shall be deducted from their Account. If the User’s account becomes overdraft, they can also make payment with their debit card or credit card using the app or the Zibomo Smart Locker.\n\n',
                    ),
                    Text(
                      '5. REGISTRATION',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    Text(
                      'i. Registration of Users:\n\n'
                          'The Users may register themselves on the platform by providing the following details on the platform:\n\n'
                          'Name of the User\n'
                          'Mobile Number of the User\n'
                          'Whatsapp Number of the User\n'
                          'Verification of Government ID such as Aadhar card, PAN Card, etc.\n'
                          'Email Address of the User\n'
                          'Additionally, the Users may also be required to provide a delivery address or drop address for fulfilling the promised services. Providing the above-mentioned details is mandatory. However, the Company may employ third Parties as Payment Gateway who may require banking details of the User to make payments on the Platform.\n\n',
                    ),
                    Text(
                      '6. PAYMENT GATEWAY',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    Text(
                      'For Users, the Platform will be available to them based on the Service fee mutually agreed between the Company and the Owner of the Smart Locker facility. The Owner of the Smart Locker facility shall be the legal person who requested the Company to install the Smart Locker facility in the stipulated place. These owners may be any private legal entity or a governmental body. The User can access the App free of cost. However, to use the Services such as accessing the smart locker, the User has to pay a subscription fee based on the Master Service Agreement between the Company and the Owner who maintains the facility.\n\n'
                          'For making all payments for services on the Platform, you shall be required to make payment through third-party platforms such as Razorpay, Phonepe, or other third parties that we may have an agreement with. The payment gateway may additionally seek information from you to process the payment for your purchase and additionally may charge you the payment gateway charges that may be applicable. You shall be governed under the concerned payment gateway’s Terms and Conditions and other Policies for the purpose of all payment-related aspects.\n\n',
                    ),
                    Text(
                      '7. ELIGIBILITY',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    Text(
                      'The User has to be of sound mind and must be capable of making informed decisions after referring to the guides on the Website.\n'
                          'In the event of a minor accessing the Website, it would be the responsibility of their immediate guardian to monitor the minor’s use; the platform or the Company will not be liable for any consequences.\n\n',
                    ),
                    Text(
                      '8. CONTENT',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    Text(
                      'All the Content displayed including but not limited to the illustrations, photographs, one-liners, videos, design, and write-ups on the Platform is created by the Company and is subject to copyright and shall not be reused by any party (or a third party) without the prior written consent of the Company and the copyright owner.\n'
                          'The Company may use or incorporate third party tools and services in a collaborative manner to deliver the final result. Hence, all content displayed or placed, including but not limited to illustrations, codes, articles, videos, photographs, and write-ups on the platform on behalf of any third party shall be subject to such third party’s copyright and shall not be reused by any party without the prior written consent of the Company and the copyright owner.\n'
                          'The Users have a personal, non-exclusive, non-transferable, revocable, limited privilege to access the content on the Platform. The User shall not copy, adapt, and modify any content without written permission from the Company.\n\n',
                    ),
                    Text(
                      '9. INDEMNITY',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    Text(
                      'The Users undertake to indemnify the Platform and keep it indemnified against all proceedings, claims, expenses, and liabilities whatsoever which may be taken or made against or incurred by the Platform or by reasons of the premises for any comments, feedback, or any other form of content created by them, which has been published by the Company on the Platform.\n\n',
                    ),



                    Text(
                      '10. TERM & TERMINATION',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    Text(
                      'These Terms shall continue to form a valid and binding contract between the Parties and shall continue to be in full force and effect until the User continues to access and use the Services and Platform. A User may terminate their use of the Services and the Platform at any time by either deleting their account with the platform or by unsubscribing to the services, as the case may be. Non-payment of subscription by the Users shall also be construed as Termination of services.\n\n'
                          'The Company may terminate these Terms without notice and/or suspend or terminate a User’s access to the Platform at any time and for any reason, if any discrepancy or legal issue arises.\n'
                          'Such suspension or termination shall not limit the Company’s right to take any other action against the User that the Company considers appropriate.\n'
                          'It is also hereby declared that the Company may discontinue the Services and Platform without any prior notice.\n'
                          'The Company and its members reserve the right, in its sole discretion, to unilaterally terminate the User’s access to the Services, or any portion thereof, at any time, without notice or cause.\n\n',
                      textAlign: TextAlign.justify,
                    ),
                    Text(
                      '11. COMMUNICATION',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    Text(
                      'a. By using this Platform, and providing their identity and contact information to the Company through the Platform, the User and the Vendor hereby agree and consent to receive calls, e-mails, SMS or any other modes of communication from the Company or any of its representatives at any time.\n\n'
                          'b. Users can report to the Company any grievances or suggestions that they have through e-mail. If they find any discrepancy with regard to the information generated on the Platform, the Company will take necessary action after an investigation. The response with resolution (if any issues are found) shall be dependent on the time that is taken for investigation.\n\n',
                      textAlign: TextAlign.justify,
                    ),
                    Text(
                      '12. USER OBLIGATIONS AND FORMAL UNDERTAKINGS AS TO CONDUCT',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    Text(
                      'The User and Vendor agree and acknowledge that they are a restricted user of this Platform and that they:\n\n'
                          'a. authorize the Platform to use, store or otherwise process certain personal information and all published content, reviews and ratings, comments, and feedback for personalization of services, marketing, and promotional purposes and for optimization of User-related options and Services.\n'
                          'b. agree not to access (or attempt to access) the Platform and/or the materials or Services by any means other than through the interface provided by the Platform.\n'
                          'c. expressly agree and acknowledge that the Content displayed on the Platform is for the purpose of reference only. The User may, however, report any offensive or objectionable content, which the Company may then remove from the Platform, at its sole discretion.\n'
                          'd. expressly agree to make good any losses suffered by the Company or platform which result as a consequence of any act committed by the User including but not limited to acts of fraud, misrepresentation of information provided on the Company’s Platform as expert advice or posting slanderous or libelous content in the form of comments or feedback.\n'
                          'e. accepts all risk of using the forum and content on the forum. As far as the law allows, the company and its suppliers provide the forum as is, without any warranty whatsoever.\n'
                          'f. agrees that they are using the services of the Platform and accessing the platform at their own risk with their prudent judgment and the Company or Platform shall not be responsible for any resultant losses suffered.\n'
                          'g. agrees and grants permissions to the Company and any third party authorized by the Company to access files and folders such as to notify the User of a delivery or an OTP Authentication through SMS for the purpose of fulfilling the service requested by the User.\n'
                          'h. agrees that the platform will be used by them solely for non-commercial use with the intent of gaining services provided by the Platform. No commercial endorsements will be made on the platform. This includes providing links to other platforms which may or may not be competitors of the Company. In the event of detection of commercial activity by a user, the Platform will have the right to bar them from posting further comments or content on the Platform.\n'
                          'i. authorizes the Company to record and store video footage when any User uses the Smart Locker Facility for security purposes. However, such video footage shall not record User’s bank details, PIN, etc. The User also authorizes the Company to disclose the footage to law enforcement agencies or any under any order made by Court of Law.\n'
                          'j. agrees that it is the sole responsibility of the User (whether in the capacity of drop-in person or pick-up person) to close the door properly of the Smart Locker Facility and the Company is not liable for any negligence on the part of such User. The SMS sent as “Door is closed” does not provide any legal authority to evidence the closure of the door since this may happen due to technical issue as well.\n'
                          'k. agrees that they shall not keep anything illegal or any hazardous substance in the Smart Locker Facility. If the Company suspects the deposit of any illegal or hazardous substance by any User in the safe deposit locker, the Company shall have the right to take appropriate action against such customer as it deems fit and proper in the circumstances.\n\n'
                          'Further:\n\n'
                          'a. The User hereby expressly authorizes the Company /Platform to disclose any and all information relating to the User in the possession of the Company /Platform to law enforcement or other government officials, as the Company may in its sole discretion, believe necessary or appropriate in connection with the investigation and/or resolution of possible crimes, especially those that involve personal injury and theft/infringement of intellectual property. The User further understands that the Company /Platform will have to disclose any information (including the identity of persons providing information or materials on the Platform) as necessary to satisfy any judicial Order, law, regulation or valid governmental request.\n'
                          'b. The User agrees to use the services provided by the Company, its affiliates, consultants and contracted companies, for lawful purposes only.\n'
                          'c. The User agrees that specific Agreement shall be applicable for each location of the smart locker facility. If there are any conflict in clauses between this Terms of Service and that Agreement, then the Agreement with specific terms relevant to that conflict shall prevail.\n'
                          'd. The User agrees not to post any material on the Platform that is defamatory, offensive, obscene, indecent, abusive, or needlessly distressful or advertising any goods or services. More specifically, the User agrees not to host, display, upload, update, publish, modify, transmit, or in any manner share any information that:\n'
                          '  i. belongs to another person and to which the User has no right;\n'
                          '  ii. is grossly harmful, harassing, blasphemous, defamatory, obscene, pornographic, paedophilic, libelous invasive of another\'s privacy, hateful, or racially, ethnically objectionable, disparaging, or otherwise unlawful in any manner whatever; but not limited to "indecent representation of women" within the meaning of the Indecent Representation of Women (Prohibition) Act, 1986;\n'
                          '  iii. violates any law for the time being in force;\n'
                          '  iv. deceives or misleads the other users.\n\n',
                      textAlign: TextAlign.justify,
                    ),
                    Text(
                      '13. BETA SERVICES AND PRODUCTS',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    Text(
                      'The Company may, from time to time, offer access to services that are classified as Beta versions. Access to and use of Beta versions may be subject to additional agreements. The company makes no representations that a Beta version will ever be made generally available and reserves the right to discontinue or modify a Beta version at any time without notice. Beta versions are provided as is, may contain bugs, errors, or other defects, and Your use of a Beta version is at Your sole risk.\n\n',
                      textAlign: TextAlign.justify,
                    ),
                    Text(
                      '14. TECHNICAL IMPROVEMENT',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    Text(
                      'From time to time, the Company may need to perform maintenance on or upgrade the Software, Products or Company Websites to improve their functionality or address technical issues. Such maintenance or upgrades may temporarily interrupt the availability of the Services and Company Websites. The Company will make reasonable efforts to minimize any disruption and will notify Users in advance of any significant disruptions.\n\n',
                      textAlign: TextAlign.justify,
                    ),
                    Text(
                      '15. LIMITATION OF LIABILITY',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    Text(
                      'To the fullest extent permitted by law, the Company shall not be liable to the User or any third party for any indirect, incidental, special, consequential, or punitive damages arising out of or relating to these Terms or the use of the Services, even if the Company has been advised of the possibility of such damages. The Company\'s liability for any direct damages arising out of these Terms or the use of the Services shall be limited to the amount paid by the User to the Company for the specific Service giving rise to the claim.\n\n',
                      textAlign: TextAlign.justify,
                    ),
                    Text(
                      '16. INDEMNIFICATION',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    Text(
                      'The User agrees to indemnify, defend, and hold harmless the Company, its affiliates, officers, directors, employees, agents, and representatives from and against any and all claims, liabilities, damages, losses, costs, or expenses (including reasonable attorneys\' fees) arising out of or related to (i) the User\'s use of the Services, (ii) any violation of these Terms by the User, or (iii) any content posted by the User on the Platform.\n\n',
                      textAlign: TextAlign.justify,
                    ),
                    Text(
                      '17. GOVERNING LAW AND JURISDICTION',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    Text(
                      'These Terms shall be governed by and construed in accordance with the laws of the jurisdiction in which the Company is located, without regard to its conflict of law principles. Any disputes arising out of or relating to these Terms or the use of the Services shall be subject to the exclusive jurisdiction of the courts located in the jurisdiction in which the Company is located.\n\n',
                      textAlign: TextAlign.justify,
                    ),

                    Text(
                      '18. DISPUTE RESOLUTION AND JURISDICTION',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    Text(
                      'a. It is expressly agreed to by the Parties hereto that the formation, interpretation, and performance of these Terms and any disputes arising therefrom will be resolved through a two-step Alternate Dispute Resolution (“ADR”) mechanism. It is further agreed to by the Parties that the contents of this Section shall survive even after the termination or expiry of the Terms and/or Policy.\n\n'

                          'i. Mediation: In case of any dispute between the parties, the Parties will attempt to resolve the same amicably amongst themselves, to the mutual satisfaction of all parties. In the event that the Parties are unable to reach such an amicable solution within thirty (30) days of one Party communicating the existence of a dispute to any other Party, the dispute will be resolved by arbitration, as detailed herein below;\n\n'

                          'ii. Arbitration: In the event that the Parties are unable to amicably resolve a dispute by mediation, said dispute will be referred to arbitration by a sole arbitrator to be appointed by the Company, and the award passed by such sole arbitrator will be valid and binding on all parties. The Parties shall bear their own costs for the proceedings, although the sole arbitrator may, in his/her sole discretion, direct either Party to bear the entire cost of the proceedings. The arbitration shall be conducted in English, and the seat of Arbitration shall be the city of Hyderabad, Telangana, India. The Parties expressly agree that the Terms, Policy and any other agreements entered into between the Parties are governed by the laws, rules, and regulations of India.\n\n',
                      textAlign: TextAlign.justify,
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      '19. GRIEVANCES',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    Text(
                      'a. Any and all communication relating to any dispute or grievance experienced by the User may be communicated to the Company by the User by emailing to support@zibomo.in.\n\n',
                      textAlign: TextAlign.justify,
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      '20. MISCELLANEOUS PROVISIONS',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    RichText(
                      textAlign: TextAlign.justify,
                      text: TextSpan(
                        style: TextStyle(fontSize: 16, color: Colors.black), // default style
                        children: [
                          TextSpan(
                            text: 'a. Entire Agreement: These Terms, read with the Policies, form the complete and final contract between the User and the Company with respect to the subject matter hereof and supersedes all other communications, representations, and agreements (whether oral, written or otherwise) relating thereto.\n\n',
                          ),
                          TextSpan(
                            text: 'b. Waiver: The failure of either Party at any time to require performance of any provision of these Terms shall in no manner affect such Party\'s right at a later time to enforce the same. No waiver by either party of any breach of these Terms, whether by conduct or otherwise, in any one or more instances, shall be deemed to be or construed as furtherance or continuing waiver of any such breach, or a waiver of any other breach of these Terms.\n\n',
                          ),
                          TextSpan(
                            text: 'c. Severability: If any provision/clause of these Terms is held to be invalid, illegal or unenforceable by any court or authority of competent jurisdiction, the validity, legality, and enforceability of the remaining provisions/clauses of these Terms shall in no way be affected or impaired thereby, and each such provision/clause of these Terms shall be valid and enforceable to the fullest extent permitted by law. In such case, these Terms shall be reformed to the minimum extent necessary to correct any invalidity, illegality or unenforceability, while preserving to the maximum extent the original rights, intentions and commercial expectations of the Parties hereto, as expressed herein.\n\n',
                          ),
                          TextSpan(
                            text: 'd. Contact Us: If you have any questions about this Agreement, the practices of the Platform, or your experience with the Service, you can contact us at +91 7013365348.\n\n',
                          ),
                          TextSpan(
                            text: 'Zibomo Sprint Safe\n'
                                '5-A/2, IDA, Nacharam, Telangana, 500076\n'
                                'Plot# 54, 2-119/54/1F, Road#10, Panchavati Colony, Manikonda, Hyderabad- 500089\n'
                                'Email: support@zibomo.com\n'
                                'Phone: +91 7013365348\n\n',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),

                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => const DashboardScreen()),
                          );
                        },
                        child: const Text('Home'),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white, backgroundColor: Colors.red, // Text color
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
        backgroundColor: Colors.red,
      ),
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Text.rich(
                    TextSpan(
                      children: [
                        // 1. Privacy Policy Heading
                        TextSpan(
                          text: 'PRIVACY POLICY\n\n',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        // Introduction
                        TextSpan(
                          text:
                          'Welcome to Zibomo Sprint Safe App Owned by M/s. APP PRO TECH SOLUTIONS\n\n',
                          style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold,),
                        ),
                        TextSpan(
                          text:
                          'M/s APP PRO TECH SOLUTIONS C/o Bobbal Arun Reddy, a Sole Proprietor...'
                              'Please contact our Customer Support Desk at +91 91 212 080 58\n\n',
                          style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold,),
                        ),
                        // 2. Definitions Heading
                        // Definitions Heading
                        TextSpan(
                          text: '1.DEFINITIONS\n\n',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        // Definitions Content
                        TextSpan(
                          text: '“We”, “Our”, and “Us” shall mean and refer to the Domain and/or the Company, as the context so requires.\n\n'
                              '“You”, “Your”, “Yourself”, “User”, shall mean and refer to natural and legal individuals who use the Platform and who is competent to enter into binding contracts, as per Indian laws.\n\n'
                              '“Services”, shall refer to the platform that provides access to Smart Locker Facility on the Platform. The detailed explanation shall be provided in Clause 4 of the Terms of Service (which can be found separately on our website).\n\n'
                              '“Third Parties” refer to any Application, legal entity or individual apart from the User, Vendor and the creator of this Application.\n\n'
                              '“Personal Information” shall mean and refer to any personally identifiable information that we may collect from you such as Name, Email Id, Mobile number, Password, Photo etc. For removal of any doubts, please refer to Clause 2 of this Privacy Policy.\n\n'
                              '“Sensitive personal data” means passwords, financial information, physical, physiological, or mental health conditions, sexual orientation, medical records and history, and biometric information. However, it does not include any personal data that is freely available or accessible in the public domain, furnished under the Right to Information Act, 2005, or under any other law in force.\n\n'
                              '“Platform” refers to the Terminal Application Zibomo which provides the users with access to Smart Locker Facility on the Platform.\n\n',
                          style: const TextStyle(fontSize: 14),
                        ),
                        // Information We Collect Heading
                        TextSpan(
                          text: '2.INFORMATION WE COLLECT\n\n',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        // Information We Collect Content
                        TextSpan(
                          text: 'We are committed to respecting our User’s online privacy. We further recognize your need for appropriate protection and management of any Personal Information you share with us. We may collect the following information:\n\n'
                              'Personal data such as, but not limited to, Name, Email Id, Address Proof, Mobile Number, Username, Password, Address, Bank details for payment, etc.;\n\n'
                              'Details of Platform usage for analytics.\n\n'
                              'This privacy policy also applies to data we collect from users who are not registered as members of this Platform, including, but not limited to, browsing behaviour, pages viewed etc. We also collect and store personal information provided by You from time to time on the Platform. We only collect and use such information from you that we consider necessary for achieving a seamless, efficient and safe experience, customized to your needs including:\n\n'
                              'To enable the provision of services opted by you;\n'
                              'To enable the viewing of content in your interest;\n'
                              'To communicate the necessary account and service related information from time to time;\n'
                              'To allow you to receive quality customer care services and data Collection;\n'
                              'To comply with applicable laws, rules and regulations;\n'
                              'Where any service requested by You involves a third party, such information as is reasonably necessary by the Company to carry out Your service request may be shared with such third party. We also do use your contact information to send you offers based on your interests and prior activity and also to view the content preferred by you. The Company may also use contact information internally to direct its efforts for service improvement but shall immediately delete all such information upon withdrawal of your consent for the same through the ‘unsubscribe’ button or through an email to be sent to support@zibomo.in.\n\n'
                              'To the extent possible, we provide You with the option of not divulging any specific information that you wish for us to not collect, store or use. You may also choose not to use a particular service or feature on the Platform and opt-out of any non-essential communications from the platform.\n\n'
                              'Further, transacting over the internet has inherent risks which can only be avoided by you following security practices yourself, such as not revealing account/login related information to any other person and informing our customer care team about any suspicious activity or where your account has/may have been compromised.\n\n',
                          style: const TextStyle(fontSize: 14),
                        ),
                        // Our Use of Your Information Heading
                        TextSpan(
                          text: '3.OUR USE OF YOUR INFORMATION\n\n',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        // Our Use of Your Information Content
                        TextSpan(
                          text: 'The information provided by you shall be used to provide and improve the service for you and all users.\n\n'
                              'For providing the service as detailed in Clause 4 of Terms of Service.\n'
                              'For maintaining an internal record.\n'
                              'For enhancing the Services provided.\n'
                              'For more details about the nature of such communications, please refer to our Terms of Service. Further, your personal data and Sensitive Personal data may be collected and stored by Us for internal record.\n\n'
                              'We use Your tracking information such as IP addresses, and or Device ID to help identify you and to gather broad demographic information and make further services available to you.\n\n'
                              'We will not sell, license or trade Your personal information. We will not share your personal information with others unless they are acting under our instructions or we are required to do so by law.\n\n'
                              'Information collected via Our server logs includes users\' IP addresses and the pages visited; this will be used to manage the web system and troubleshoot problems. We also use third-party analytics, tracking, optimization and targeting tools to understand how users engage with our Platform so that we can improve it and cater personalized content/ads according to their preferences.\n\n',
                          style: const TextStyle(fontSize: 14),
                        ),
                        // How Information is Collected Heading
                        TextSpan(
                          text: '4.HOW INFORMATION IS COLLECTED\n\n',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        // How Information is Collected Content
                        TextSpan(
                          text: 'Before or at the time of collecting personal information, we will identify the purposes for which information is being collected. If the same is not identified to you, you have the right to request the Company to elucidate the purpose of collection of said personal information, pending the fulfillment of which you shall not be mandated to disclose any information whatsoever.\n\n'
                              'We will collect and use your personal information solely with the objective of fulfilling those purposes specified by us, within the scope of the consent of the individual concerned or as required by law. We will only retain personal information as long as necessary for the fulfilment of those purposes. We will collect personal information by lawful and fair means and with the knowledge and consent of the individual concerned.\n\n'
                              'Personal data should be relevant to the purposes for which it is to be used, and, to the extent necessary for those purposes, should be accurate, complete, and up-to-date.\n\n',
                          style: const TextStyle(fontSize: 14),
                        ),
                        // External Links on the Platform Heading
                        TextSpan(
                          text: '5.EXTERNAL LINKS ON THE PLATFORM\n\n',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        // External Links on the Platform Content
                        TextSpan(
                          text: 'The Platform will not include third-party advertisements, hyperlinks to other websites, applications, content or resources, except advertisements, hyperlinks, applications, content or resources of Zibomo itself. You acknowledge and agree that we are not responsible for the availability of any such external sites or resources, and do not endorse any advertising, services/services or other materials on or available from such platform or resources. You acknowledge and agree that We are not liable for any loss or damage which may be incurred by you as a result of the availability of those external sites or resources, or as a result of any reliance placed by you on the completeness, accuracy or existence of any advertising, services or other materials on, or available from, such websites or resources. These external websites and resource providers may have their own privacy policies governing the collection, storage, retention and disclosure of Your Personal Information that You may be subject to. We recommend that you enter the external Website and review their privacy policy.\n\n',
                          style: const TextStyle(fontSize: 14),
                        ),
                        // Google Analytics Heading
                        TextSpan(
                          text: '6.GOOGLE ANALYTICS\n\n',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        // Google Analytics Content
                        TextSpan(
                          text: 'We use Google Analytics to help us to understand how you make use of our content and work out how we can make things better. These cookies follow your progress through us, collecting anonymous data on where you have come from, which pages you visit, and how long you spend on the site. This data is then stored by Google to create reports. These cookies do not store your personal data.\n\n'
                              'The information generated by the cookie about your use of the Website, including your IP address, may be transmitted to and stored by Google on servers in the United States or anywhere else in the World. Google may use this information for the purpose of evaluating your use of the website, compiling reports on website activity for us and providing other services relating to website activity and internet usage. Google may also transfer this information to third parties where required to do so by law, or where such third parties process the information on Google\'s behalf. Google will not associate your IP address with any other data held by Google. By using this website, you consent to the processing of data about you by Google in the manner and for the purposes set out above.\n\n'
                              'The Google website contains further information about Analytics and a copy of Google\'s privacy policy pages.\n\n',
                          style: const TextStyle(fontSize: 14),
                        ),
                        // Google AdSense Heading
                        TextSpan(
                          text: '7.GOOGLE ADSENSE\n\n',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        // Google AdSense Content
                        TextSpan(
                          text: 'Google AdSense is a tool that allows website publishers to deliver advertisements to site visitors in exchange for revenue calculated on a per-click or per-impression basis. To do this, Google uses cookies and tracking technology to deliver ads personalized to a website user/visitor. In this regard the following terms are specified to the Users:\n\n'
                              'Third-party vendors, including Google, use cookies to serve ads based on your prior visits to our website or other websites.\n'
                              'Google\'s use of advertising cookies enables us to serve advertisements to you based on your visit to our Platform and/or other websites on the Internet.\n'
                              'You may opt-out of personalized advertising by visiting Ads Settings.\n'
                              'At no point will the Company permit its Competitors to advertise on the Platform.\n'
                              'You may visit the links in the advertisements at your own risk or choose to not accept the cookies permitting third parties to display their advertisements.\n\n',
                          style: const TextStyle(fontSize: 14),
                        ),
                        // Your Rights Heading
                        TextSpan(
                          text: '8.YOUR RIGHTS\n\n',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        // Your Rights Content
                        TextSpan(
                          text: 'Unless subject to an exemption, you have the following rights with respect to your personal data:\n\n'
                              'The right to request a copy of your personal data which we hold about you;\n'
                              'The right to request for any correction to any personal data if it is found to be inaccurate or out of date;\n'
                              'The right to withdraw Your consent to the processing at any time;\n'
                              'The right to object to the processing of personal data;\n'
                              'The right to lodge a complaint with a supervisory authority.\n'
                              'The right to obtain information as to whether personal data are transferred to a third Party or to an international organization.\n\n'
                              'Where you hold an account with any of our services, you are entitled to a copy of all personal data which we hold in relation to you. You are also entitled to request that we restrict how we use your data in your account when you log in.\n\n',
                          style: const TextStyle(fontSize: 14),
                        ),
                        // Confidentiality Heading
                        TextSpan(
                          text: '9.CONFIDENTIALITY\n\n',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        // Confidentiality Content
                        TextSpan(
                          text: 'You further acknowledge that the Platform may contain information that is designated confidential by us and that you shall not disclose such information without our prior written consent. Your information is regarded as confidential and therefore will not be divulged to any third party, unless if legally required to do so to the appropriate authorities. We will not sell, share, or rent your personal information to any third party or use your e-mail address for unsolicited mail. Any emails sent by us will only be in connection with the provision of agreed services, and you retain sole discretion to seek for discontinuation of such communications at any point of time.\n\n',
                          style: const TextStyle(fontSize: 14),
                        ),
                        // Other Information Collectors Heading
                        TextSpan(
                          text: '10.OTHER INFORMATION COLLECTORS\n\n',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        // Other Information Collectors Content
                        TextSpan(
                          text: 'Except as otherwise expressly included in this Privacy Policy, this document only addresses the use and disclosure of information we collect from you. To the extent that you disclose your information to other parties, whether they are on our Platform or on other sites throughout the Internet, different rules may apply to their use or disclosure of the information you disclose to them. To the extent that we use third party advertisers, they adhere to their own privacy policies. Since we do not control the privacy policies of the third parties, you are subject to ask questions before you disclose your personal information to others.\n\n',
                          style: const TextStyle(fontSize: 14),
                        ),
                        // Our Disclosure of Your Information Heading
                        TextSpan(
                          text: '11.OUR DISCLOSURE OF YOUR INFORMATION\n\n',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        // Our Disclosure of Your Information Content
                        TextSpan(
                          text: 'We may host surveys for survey creators for our platform who are the owners and users of your survey responses. We do not own or sell your responses. Anything you expressly disclose in your responses will be disclosed to survey creators. Please contact the survey creator directly to better understand how they might share your survey responses.\n\n'
                              'Information collected will not be considered as sensitive if it is freely available and accessible in the public domain or is furnished under the Right to Information Act, 2005, any rules made thereunder or any other law for the time being in force.\n\n'
                              'Due to the existing regulatory environment, and the evolving nature of law, we cannot ensure that all of your private communications and other personally identifiable information will never be disclosed in ways not otherwise described in this Privacy Policy. By way of example (without limiting and foregoing), we may be forced to disclose information to the government, law enforcement agencies or third parties. Therefore, although we use industry-standard practices to protect your privacy, we do not promise, and you should not expect, that your personally identifiable information or private communications would always remain private. We do however assure you that any and all disclosure of your personally identifiable sensitive information shall be personally intimated to you through an email sent to your provided email address.\n\n'
                              'As a matter of policy, we do not sell or rent any personally identifiable information about you to any third party. However, the following describes some of the ways that your personally identifiable information may be disclosed:\n\n'
                              'External Service Providers: There may be a number of services offered by external service providers that help you use our Platform. If you choose to use these services, and in the course of doing so, disclose information to the external service providers, and/or grant them permission to collect information about you, then their use of your information is governed by their privacy policy.\n\n'
                              'Law and Order: We cooperate with law enforcement inquiries, as well as other third parties to enforce laws, such as intellectual property rights, fraud and other rights. We can (and you authorize us to) disclose any information about you to law enforcement and other government officials as we, in our sole discretion, believe necessary or appropriate, in connection with an investigation of fraud, intellectual property infringements, or other activity that is illegal or may expose us or you to legal liability.\n\n',
                          style: const TextStyle(fontSize: 14),
                        ),
                        // Accessing, Reviewing, and Changing Your Profile Heading
                        TextSpan(
                          text: '12.ACCESSING, REVIEWING AND CHANGING YOUR PROFILE\n\n',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        // Accessing, Reviewing, and Changing Your Profile Content
                        TextSpan(
                          text: 'Following registration, you can review and change the information you submitted at the stage of registration, except Email ID and Mobile Number. An option for facilitating such change shall be present on the Platform and such change shall be facilitated by the User. If you change any information, we may or may not keep track of your old information. We will not retain in our files information you have requested to remove for certain circumstances, such as to resolve disputes, troubleshoot problems and enforce our terms and conditions. Such prior information shall be completely removed from our databases, including stored ‘back up’ systems. If you believe that any information, we are holding on you is incorrect or incomplete, or to remove your profile so that others cannot view it, the User needs to remediate, and promptly correct any such incorrect information.\n\n',
                          style: const TextStyle(fontSize: 14),
                        ),
                        // Control of Your Password Heading
                        TextSpan(
                          text: '13.CONTROL OF YOUR PASSWORD\n\n',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        // Control of Your Password Content
                        TextSpan(
                          text: 'You are entirely responsible for maintaining the confidentiality of your password. It is important that you protect it against unauthorized access of your account and information by choosing your password carefully and keeping your password and computer secure by signing out after using our services.\n\n'
                              'You agree not to use the account, username, email address or password of another Member at any time or to disclose your password to any third party. You are responsible for all actions taken with your login information and password, including fees. If you lose control of your password, you may lose substantial control over your personally identifiable information and may be subject to legally binding actions taken on your behalf. Therefore, if your password has been compromised for any reason, you should immediately change your password. You agree to notify us immediately if you suspect any consistent unauthorized use of your account or access to your password even after changing it.\n\n',
                          style: const TextStyle(fontSize: 14),
                        ),
                        // Security Heading
                        TextSpan(
                          text: '14.SECURITY\n\n',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        // Security Content
                        TextSpan(
                          text: 'We treat data as an asset that must be protected against loss and unauthorized access. We employ many different security techniques to protect such data from unauthorized access by members inside and outside the Company. We follow generally accepted industry standards to protect the Personal Information submitted to us and information that we have accessed.\n\n'
                              'However, no security system is impenetrable. Our Company cannot guarantee the security of our database or the decentralized server, nor can we guarantee that information you provide won’t be intercepted while being transmitted to the Company over the Internet.\n\n',
                          style: const TextStyle(fontSize: 14),
                        ),
                        // Severability Heading
                        TextSpan(
                          text: '15.SEVERABILITY\n\n',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        // Severability Content
                        TextSpan(
                          text: 'Each paragraph of this Privacy Policy shall be and remain separate from, independent of and severable from all and any other paragraphs herein except where otherwise expressly indicated or indicated by the context of the agreement. The decision or declaration that one or more of the paragraphs are null and void shall have no effect on the remaining paragraphs of this privacy policy.\n\n',
                          style: const TextStyle(fontSize: 14),
                        ),
                        // Amendment Heading
                        TextSpan(
                          text: '16.AMENDMENT\n\n',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        // Amendment Content
                        TextSpan(
                          text: 'Our Privacy Policy may change from time to time. The most current version of the policy will govern our use of your information and will always be at the Platform. Any amendments to this Policy shall be deemed as accepted by the User on their continued use of the Platform.\n\n',
                          style: const TextStyle(fontSize: 14),
                        ),
                        // Automated Decision Making Heading
                        TextSpan(
                          text: '17.AUTOMATED DECISION MAKING\n\n',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        // Automated Decision Making Content
                        TextSpan(
                          text: 'As a responsible Company, we do not use automated decision-making or profiling.\n\n',
                          style: const TextStyle(fontSize: 14),
                        ),
                        // Consent Withdrawal, Data Download & Data Removal Requests Heading
                        TextSpan(
                          text: '18.CONSENT WITHDRAWAL, DATA DOWNLOAD & DATA REMOVAL REQUESTS\n\n',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        // Consent Withdrawal, Data Download & Data Removal Requests Content
                        TextSpan(
                          text: 'To withdraw your consent, or to request the download or delete your data with us for any or all our services & services at any time, please email to support@zibomo.in.\n\n',
                          style: const TextStyle(fontSize: 14),
                        ),
                        // Contact Us Heading
                        TextSpan(
                          text: '19.CONTACT US\n\n',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        // Contact Us Content
                        TextSpan(
                          text: 'If you have any questions or concerns regarding this privacy policy, you should contact us +91 91 212 080 58 or by sending an e-mail to support@zibomo.in.\n\n'
                              'Information provided on the website may not be 100% accurate and may be provided for promotional purposes of the business.\n\n',
                          style: const TextStyle(fontSize: 14),
                        ),
// Definitions Heading


                      ],
                    ),
                  ),
                ),
              ),
              // Navigation Button to go back to DashboardScreen
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const DashboardScreen()),
                    );
                  },
                  child: const Text('Home'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Colors.red, // Text color
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}