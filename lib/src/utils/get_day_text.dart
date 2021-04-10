class DayText {
  DayText();

  static String getDayText(int day) {
    String? daytext;
    if (day != 0) {
      switch (day) {
        case 1:
          daytext = "Lunes";
          break;
        case 2:
          daytext = "Martes";
          break;
        case 3:
          daytext = "Miércoles";
          break;
        case 4:
          daytext = "Jueves";
          break;
        case 5:
          daytext = "Viernes";
          break;
        case 6:
          daytext = "Sábado";
          break;
        case 7:
          daytext = "Domingo";
          break;
        default:
      }
      return daytext!;
    } else {
      return '';
    }
  }
}
