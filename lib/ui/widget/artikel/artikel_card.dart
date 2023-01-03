import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:moneyger/ui/article/article.dart';
import 'package:moneyger/ui/widget/loading/shimmer_widget.dart';

class ArtikelCard extends StatefulWidget {
  String judul, subjudul, tanggalPosting, penulis, foto, isiArtikel;
  ArtikelCard(
      {Key? key,
      required this.judul,
      required this.subjudul,
      required this.tanggalPosting,
      required this.penulis,
      required this.foto,
      required this.isiArtikel})
      : super(key: key);

  @override
  State<ArtikelCard> createState() => _ArtikelCardState();
}

class _ArtikelCardState extends State<ArtikelCard> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ArticlePage(
                  judul: widget.judul,
                  subjudul: widget.subjudul,
                  tanggalPosting: widget.tanggalPosting,
                  penulis: widget.penulis,
                  foto: widget.foto,
                  isiArtikel: widget.isiArtikel),
            ));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.only(bottom: 16),
        decoration: const BoxDecoration(
          border: BorderDirectional(
            bottom: BorderSide(
              color: Color(0XFFD7D7D7),
            ),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 75,
              height: 75,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(5),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: CachedNetworkImage(
                  imageUrl: widget.foto,
                  fit: BoxFit.fill,
                  placeholder: (context, url) => ShimmerWidget(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      radius: 5),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
            const SizedBox(
              width: 24,
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.judul,
                    style: textTheme.headline4,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    widget.tanggalPosting,
                    style: textTheme.bodyText1,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
