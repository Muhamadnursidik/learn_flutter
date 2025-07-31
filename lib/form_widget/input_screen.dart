// ignore_for_file: prefer_final_fields, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:learn_flutter/form_widget/output_screen.dart';
import 'package:learn_flutter/main_layout.dart';
// import 'package:learn_flutter/theme/pallete.dart';

class InputFormScreen extends StatefulWidget {
  const InputFormScreen({super.key});

  @override
  State<InputFormScreen> createState() => _InputFormScreenState();
}

class _InputFormScreenState extends State<InputFormScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _namaController = TextEditingController();
  TextEditingController _tglLahirController = TextEditingController();

  String? _jk = "";
  String? _agama;
  String? _error;

  final List<String> agama = ["Islam", "Kristen", "Hindu", "Budha", "Konghucu"];

  @override
  void initState() {
    super.initState();
    _tglLahirController.text = "";
    _jk = "";
    _error = null;
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: "Input Form",
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Formulir Biodata",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _namaController,
                decoration: const InputDecoration(
                  labelText: "Nama Lengkap",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) return "Input Nama";
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Jenis Kelamin",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              Row(
                children: [
                  Radio<String>(
                    value: "Laki-laki",
                    groupValue: _jk,
                    onChanged: (value) {
                      setState(() {
                        _jk = value;
                        _error = null;
                      });
                    },
                  ),
                  const Text("Laki laki"),
                  Radio<String>(
                    value: "Perempuan",
                    groupValue: _jk,
                    onChanged: (value) {
                      setState(() {
                        _jk = value;
                        _error = null;
                      });
                    },
                  ),
                  const Text("Perempuan"),
                ],
              ),
              if (_error != null)
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Text(
                    _error!,
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _tglLahirController,
                decoration: const InputDecoration(
                  labelText: "Tanggal Lahir",
                  border: OutlineInputBorder(),
                ),
                readOnly: true,
                onTap: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime.now(),
                  );
                  if (picked != null) {
                    setState(() {
                      _tglLahirController.text =
                          "${picked.day}/${picked.month}/${picked.year}";
                    });
                  }
                },
                validator: (value) {
                  if (value!.isEmpty) return "Input Tanggal Lahir";
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _agama,
                hint: const Text("Pilih Agama"),
                items: agama
                    .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(e),
                        ))
                    .toList(),
                decoration: const InputDecoration(
                  labelText: "Agama",
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    _agama = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Pilih agama terlebih dahulu";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: _submit,
                  child: const Text("Simpan"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      if (_jk == null || _jk!.isEmpty) {
        setState(() {
          _error = "Pilih Jenis Kelamin!";
        });
        return;
      }

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OutputFormScreen(
            nama: _namaController.text,
            jk: _jk!,
            tglLahir: _tglLahirController.text,
            agama: _agama!,
          ),
        ),
      );
    }
  }
}
