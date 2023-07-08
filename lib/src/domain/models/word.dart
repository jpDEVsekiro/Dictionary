class Word {
  String? word;
  List<Results>? results;
  Syllables? syllables;
  Pronunciation? pronunciation;

  Word({this.word, this.results, this.syllables, this.pronunciation});

  Word.fromJson(Map<String, dynamic> json) {
    word = json['word'];
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(Results.fromJson(v));
      });
    }
    syllables = json['syllables'] != null
        ? Syllables.fromJson(json['syllables'])
        : null;
    pronunciation = json['pronunciation'] != null
        ? Pronunciation.fromJson(json['pronunciation'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['word'] = word;
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    if (syllables != null) {
      data['syllables'] = syllables!.toJson();
    }
    if (pronunciation != null) {
      data['pronunciation'] = pronunciation!.toJson();
    }
    return data;
  }
}

class Results {
  String? definition;
  String? partOfSpeech;
  List<String>? synonyms;
  List<String>? typeOf;
  List<String>? hasTypes;
  List<String>? derivation;
  List<String>? examples;

  Results(
      {this.definition,
      this.partOfSpeech,
      this.synonyms,
      this.typeOf,
      this.hasTypes,
      this.derivation,
      this.examples});

  Results.fromJson(Map<String, dynamic> json) {
    definition = json['definition'];
    partOfSpeech = json['partOfSpeech'];
    synonyms = json['synonyms']?.cast<String>();
    typeOf = json['typeOf']?.cast<String>();
    hasTypes = json['hasTypes']?.cast<String>();
    derivation = json['derivation']?.cast<String>();
    examples = json['examples']?.cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['definition'] = definition;
    data['partOfSpeech'] = partOfSpeech;
    data['synonyms'] = synonyms;
    data['typeOf'] = typeOf;
    data['hasTypes'] = hasTypes;
    data['derivation'] = derivation;
    data['examples'] = examples;
    return data;
  }
}

class Syllables {
  int? count;
  List<String>? list;

  Syllables({this.count, this.list});

  Syllables.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    list = json['list'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;
    data['list'] = list;
    return data;
  }
}

class Pronunciation {
  String? all;

  Pronunciation({this.all});

  Pronunciation.fromJson(dynamic json) {
    if (json is String) {
      all = json;
    } else if (json is Map<String, dynamic>) {
      all = json['all'];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['all'] = all;
    return data;
  }
}
