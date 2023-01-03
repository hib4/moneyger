import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:moneyger/common/color_value.dart';
import 'package:moneyger/ui/widget/loading/shimmer_widget.dart';

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
    final textTheme = Theme.of(context).textTheme;

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
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.judul,
                style:
                    textTheme.headline3!.copyWith(fontWeight: FontWeight.w700),
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
                height: 170,
                width: MediaQuery.of(context).size.width,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: CachedNetworkImage(
                    imageUrl: widget.foto,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => ShimmerWidget(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      radius: 5,
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
              ),
              Text(
                widget.subjudul,
                style: textTheme.bodyText1!.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                widget.isiArtikel,
                style: textTheme.bodyText1!.copyWith(color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
