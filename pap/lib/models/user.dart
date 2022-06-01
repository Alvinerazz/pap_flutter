class User {
  int? id;
  String? carro;
  int? contacto;
  String? dataValidade;
  String? matricula;
  String? nome;
  Parque? parque;
  String? role;

  User(
      {this.id,
      this.carro,
      this.contacto,
      this.dataValidade,
      this.matricula,
      this.nome,
      this.parque,
      this.role});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    carro = json['Carro'];
    contacto = json['Contacto'];
    dataValidade = json['DataValidade'];
    matricula = json['Matricula'];
    nome = json['Nome'];
    parque =
        json['Parque'] != null ? new Parque.fromJson(json['Parque']) : null;
    role = json['Role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['Carro'] = this.carro;
    data['Contacto'] = this.contacto;
    data['DataValidade'] = this.dataValidade;
    data['Matricula'] = this.matricula;
    data['Nome'] = this.nome;
    if (this.parque != null) {
      data['Parque'] = this.parque!.toJson();
    }
    data['Role'] = this.role;
    return data;
  }
}

class Parque {
  bool? b1SParadaI;
  bool? b1SParadaS;
  bool? b2SBar;
  bool? b2SParada;
  bool? b2SParque;

  Parque(
      {this.b1SParadaI,
      this.b1SParadaS,
      this.b2SBar,
      this.b2SParada,
      this.b2SParque});

  Parque.fromJson(Map<String, dynamic> json) {
    b1SParadaI = json['1S_ParadaI'];
    b1SParadaS = json['1S_ParadaS'];
    b2SBar = json['2S_Bar'];
    b2SParada = json['2S_Parada'];
    b2SParque = json['2S_Parque'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['1S_ParadaI'] = this.b1SParadaI;
    data['1S_ParadaS'] = this.b1SParadaS;
    data['2S_Bar'] = this.b2SBar;
    data['2S_Parada'] = this.b2SParada;
    data['2S_Parque'] = this.b2SParque;
    return data;
  }
}
