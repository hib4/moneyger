class ArticleModel {
  int? id;
  String? judul;
  String? subjudul;
  String? tanggalPosting;
  String? foto;
  String? isiArtikel;
  String? penulis;

  ArticleModel(
      {this.id,
      this.judul,
      this.subjudul,
      this.tanggalPosting,
      this.foto,
      this.isiArtikel,
      this.penulis});

  ArticleModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    judul = json['judul'];
    subjudul = json['subjudul'];
    tanggalPosting = json['tanggalPosting'];
    foto = json['foto'];
    isiArtikel = json['isiArtikel'];
    penulis = json['penulis'];
  }
}
