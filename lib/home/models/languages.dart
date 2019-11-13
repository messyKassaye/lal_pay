class Languages{
  int id;
  String name;

  Languages(this.id,this.name);

  static List<Languages> getLanguages(){

    return <Languages> [
      Languages(1,"English"),
      Languages(2,"Amharic"),
      Languages(3,"Tigrigna"),
      Languages(4,"Oromiffa"),
      Languages(5,"France")
    ];
  }
}