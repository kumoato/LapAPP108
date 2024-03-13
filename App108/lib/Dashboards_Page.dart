import 'package:flutter/material.dart';
import 'register_page.dart';
import 'Edit.dart';
import 'Product.dart';
import 'package:dio/dio.dart';
import 'Hub.dart';

class Dashboards extends StatefulWidget {
  Dashboards({Key? key}) : super(key: key);

  @override
  _DashboardsState createState() => _DashboardsState();
}

class _DashboardsState extends State<Dashboards> {
  late List products = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      var dio = Dio();
      var res = await dio.get(
        'http://localhost:4035/api/nahra/products',
      );
      if (res != '') {
        products = res.data['data'];
        setState(() {
          products = products;
          print(products);
        });
      }
    } catch (e) {}
  }

  del(int productId) async {
    print(productId);
    try {
      var dio = Dio();
      var res = await dio.delete(
        'http://localhost:4035/api/nahra/productdel/$productId',
      );
      print(res);
      showLoginErrorPopup2();
    } catch (e) {
      // showLoginErrorPopup();
    }
  }

  void showLoginErrorPopup2() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('บันทึกข้อมูลสำเร็จ',
              style: TextStyle(
                color: Color.fromARGB(255, 0, 0, 0),
                // fontSize: 18,
              )),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Hub()),
                );
              },
              child: Text('ตกลง',
                  style: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    // fontSize: 18,
                  )),
            ),
          ],
        );
      },
    );
  }

  void showLoginErrorPopup(productId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('ยืนยันการลบ',
              style: TextStyle(
                color: Color.fromARGB(255, 0, 0, 0),
                // fontSize: 18,
              )),
          content: Text('คุณต้องการลบข้อมูลนี้หรือไม่?',
              style: TextStyle(
                color: Color.fromARGB(255, 0, 0, 0),
                // fontSize: 18,
              )),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // ปิด AlertDialog
              },
              child: Text('ยกเลิก',
                  style: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    // fontSize: 18,
                  )),
            ),
            TextButton(
              onPressed: () {
                // ทำการลบข้อมูล
                del(productId);
                Navigator.of(context).pop(); // ปิด AlertDialog
              },
              child: Text('ลบ',
                  style: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    // fontSize: 18,
                  )),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Color.fromARGB(255, 0, 0, 0), // กำหนดสีของพื้นหลังเป็นสีขาว
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        child: Text(
                          'สินค้า',
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 255, 255, 255)),
                        ),
                      ),
                    ],
                  ),
                ),
                MaterialButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Product(),
                      ),
                    );
                  },
                  // child: const Icon(Icons.add, color: Colors.black)
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add,
                        color: const Color.fromARGB(255, 255, 255, 255),
                      ),
                      Text(
                        'เพิ่มสินค้า',
                        style: TextStyle(
                            color: const Color.fromARGB(255, 255, 255, 255)),
                      )
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Center(
              child: Container(
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 55.0, vertical: 50.0),
                  height: MediaQuery.of(context).size.height * 1,
                  child: ListView.builder(
                    // scrollDirection: Axis.horizontal,
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      return Container(
                        width: MediaQuery.of(context).size.width * 0.75,
                        child: Card(
                          color: const Color.fromARGB(255, 0, 0, 0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0.0),
                          ),
                          elevation: 2,
                          child: Container(
                            child: Column(children: [
                              AspectRatio(
                                aspectRatio: 5.0 / 5.0,
                                child: Image.asset(
                                  '../assets/picproduct.png',
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                              SizedBox(
                                  height:
                                      10), // เพิ่มช่องว่างระหว่างภาพและข้อความ
                              Text(
                                ('${products[index]["productname"]}'),
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      const Color.fromARGB(255, 255, 255, 255),
                                ),
                              ),
                              SizedBox(
                                  height:
                                      10), // เพิ่มช่องว่างระหว่างภาพและข้อความ
                              Text(
                                // (products[index].price),
                                ('¥${products[index]["price"]}'),

                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                ),
                              ),
                              SizedBox(
                                  height:
                                      5), // เพิ่มช่องว่างระหว่างภาพและข้อความ
                              SizedBox(
                                // width: double.infinity,
                                height: 25,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            Edit(data: products[index]),
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Color.fromARGB(255, 255, 255, 255),
                                    // minimumSize: const Size(double.infinity, 60),
                                  ),
                                  child: const Text(
                                    'Edit',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 5),

                              SizedBox(
                                // width: double.infinity,
                                height: 25,
                                child: ElevatedButton(
                                  onPressed: () {
                                    showLoginErrorPopup(products[index]["id"]);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xFFdc5254),
                                    // minimumSize: const Size(double.infinity, 60),
                                  ),
                                  child: const Text(
                                    'Delete',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 5),
                            ]),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
