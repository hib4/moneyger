import 'package:flutter/material.dart';
import 'package:moneyger/common/color_value.dart';

class ArticlePage extends StatefulWidget {
  String judul, subjudul, tanggalPosting, penulis, foto, isiArtikel;
  ArticlePage(
      {Key? key,
      required this.judul,
      required this.subjudul,
      required this.tanggalPosting,
      required this.penulis,
      required this.foto,
      required this.isiArtikel})
      : super(key: key);

  @override
  State<ArticlePage> createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Artikel',
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.judul,
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                "${widget.tanggalPosting}, Penulis ${widget.penulis}",
                style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: ColorValue.greyColor),
              ),
              Container(
                margin: const EdgeInsets.only(top: 16, bottom: 24),
                height: 150,
                width: MediaQuery.of(context).size.width,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: FadeInImage.assetNetwork(
                    placeholder: 'assets/images/google.png',
                    image: widget.foto,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Text(
                widget.subjudul,
                style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                widget.isiArtikel,
                style: const TextStyle(
                    fontSize: 10,
                    color: Colors.black,
                    fontWeight: FontWeight.normal),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
