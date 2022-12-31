import 'package:flutter/material.dart';
import 'package:moneyger/ui/article/article.dart';

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
        padding: const EdgeInsets.only(bottom: 16, top: 16),
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
                child: FadeInImage.assetNetwork(
                  placeholder: 'assets/images/google.png',
                  image: widget.foto,
                  fit: BoxFit.fill,
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
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    widget.tanggalPosting,
                    style: textTheme.bodyText1,
                  ),
                  Text(
                    '${DateTime.now()}',
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
