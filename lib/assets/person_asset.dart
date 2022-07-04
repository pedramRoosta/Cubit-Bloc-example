enum PersonUrl {
  personUrl1,
  personUrl2,
}

extension PersonUrlEx on PersonUrl {
  String get urlString {
    switch (this) {
      case PersonUrl.personUrl1:
        return 'http://127.0.0.1:5500//lib/assets/person1.json';
      case PersonUrl.personUrl2:
        return 'http://127.0.0.1:5500/lib/assets/person2.json';
    }
  }
}
