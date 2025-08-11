import 'package:flutter/material.dart';
import 'package:learn_flutter/toko_online/payment_screen.dart';

class ListScreen extends StatefulWidget {
  final String productId;
  final String productName;
  final String productLoc;
  final String productPrice;
  final String productImage;
  final String productDesc;
  final String productStock;

  const ListScreen({
    super.key,
    required this.productId,
    required this.productName,
    required this.productLoc,
    required this.productPrice,
    required this.productImage,
    required this.productDesc,
    required this.productStock,
  });

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _tanggalController = TextEditingController();
  final TextEditingController _jumlahController = TextEditingController();

  @override
  void dispose() {
    _namaController.dispose();
    _tanggalController.dispose();
    _jumlahController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Pemesanan'),
        backgroundColor: Colors.brown[100],
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              elevation: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(16)),
                    child: Image.network(widget.productImage,
                        height: 180, width: double.infinity, fit: BoxFit.cover),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.productName,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        Text(widget.productLoc,
                            style: const TextStyle(color: Colors.grey)),
                        const SizedBox(height: 4),
                        Text(
                          widget.productPrice,
                          style: const TextStyle(
                              color: Colors.teal, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          widget.productStock,
                          style:
                              const TextStyle(color: Colors.teal, fontSize: 12),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          widget.productDesc,
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _namaController,
                    decoration: const InputDecoration(
                      labelText: 'Nama Lengkap',
                      border: OutlineInputBorder(),
                    ),
                    validator: (val) => val!.isEmpty ? 'Wajib diisi' : null,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _tanggalController,
                    readOnly: true,
                    decoration: const InputDecoration(
                      labelText: 'Tanggal Pemesanan',
                      border: OutlineInputBorder(),
                    ),
                    onTap: () async {
                      FocusScope.of(context).unfocus();
                      final DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2100),
                      );
                      if (pickedDate != null) {
                        _tanggalController.text =
                            "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                      }
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _jumlahController,
                    decoration: const InputDecoration(
                      labelText: 'Jumlah Produk',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (val) =>
                        val!.isEmpty ? 'Isi jumlah produk' : null,
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => PaymentScreen(
                                productName: widget.productName,
                                productLoc: widget.productLoc,
                                productPrice: widget.productPrice,
                                productImage: widget.productImage,
                                productDesc: widget.productDesc,
                                namaPemesan: _namaController.text,
                                tanggalPemesanan: _tanggalController.text,
                                jumlahProduk: _jumlahController.text,
                              ),
                            ),
                          );
                        }
                      },
                      child: const Text('Pesan Sekarang'),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
