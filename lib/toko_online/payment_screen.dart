import 'package:flutter/material.dart';

class PaymentScreen extends StatefulWidget {
  final String productName;
  final String productLoc;
  final String productPrice;
  final String productImage;
  final String productDesc;
  final String namaPemesan;
  final String tanggalPemesanan;
  final String jumlahProduk;

  const PaymentScreen({
    super.key,
    required this.productName,
    required this.productLoc,
    required this.productPrice,
    required this.productImage,
    required this.productDesc,
    required this.namaPemesan,
    required this.tanggalPemesanan,
    required this.jumlahProduk,
  });

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _bayarController = TextEditingController();

  late int totalHarga;

  @override
  void initState() {
    super.initState();
    final hargaSatuan =
        int.tryParse(widget.productPrice.replaceAll(RegExp(r'[^0-9]'), '')) ??
            0;
    final jumlah = int.tryParse(widget.jumlahProduk) ?? 0;
    totalHarga = hargaSatuan * jumlah;
  }

  @override
  void dispose() {
    _bayarController.dispose();
    super.dispose();
  }

  void _konfirmasiPembayaran() {
    if (_formKey.currentState!.validate()) {
      final jumlahBayar = int.tryParse(_bayarController.text) ?? 0;

      if (jumlahBayar < totalHarga) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text("Jumlah pembayaran kurang dari total harga")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Pembayaran berhasil dikonfirmasi")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Halaman Pembayaran'),
        backgroundColor: Colors.brown[100],
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Card Produk
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
                    child: Image.network(
                      widget.productImage,
                      height: 180,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
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
                        Text(widget.productPrice,
                            style: const TextStyle(
                                color: Colors.teal,
                                fontWeight: FontWeight.bold)),
                        const SizedBox(height: 6),
                        Text(widget.productDesc,
                            style: const TextStyle(fontSize: 14)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Info Pemesanan
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              color: Colors.grey[100],
              elevation: 1,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Nama Pemesan: ${widget.namaPemesan}"),
                    const SizedBox(height: 8),
                    Text("Tanggal Pemesanan: ${widget.tanggalPemesanan}"),
                    const SizedBox(height: 8),
                    Text("Jumlah Produk: ${widget.jumlahProduk}"),
                    const SizedBox(height: 8),
                    Text("Total Harga: Rp$totalHarga"),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Form Input Pembayaran
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _bayarController,
                    decoration: const InputDecoration(
                      labelText: 'Jumlah Bayar (Rp)',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (val) =>
                        val == null || val.isEmpty ? 'Wajib diisi' : null,
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final jumlahBayar =
                              int.tryParse(_bayarController.text) ?? 0;

                          if (jumlahBayar < totalHarga) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      "Jumlah pembayaran kurang dari total harga")),
                            );
                          } else {
                            showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                title: const Text('Pembayaran Berhasil'),
                                content: const Text(
                                    'Terima kasih! Pembayaran Anda telah berhasil.'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pop(); // Nutup alert
                                      Navigator.of(context).popUntil((route) =>
                                          route
                                              .isFirst); // Balik ka list / halaman sebelumnya
                                    },
                                    child: const Text('OK'),
                                  ),
                                ],
                              ),
                            );
                          }
                        }
                      },
                      child: const Text('Konfirmasi Pembayaran'),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
