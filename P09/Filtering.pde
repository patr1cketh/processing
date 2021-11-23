import java.util.stream.Collectors;

final int DEFAULT_START_YEAR = 1500;
final int DEFAULT_END_YEAR = 2020;

void createFilteringGUI() {
  gui.createForm("Filter Meteorites")
    .addLabel("By Year")
    .addSlider("From", DEFAULT_START_YEAR, DEFAULT_END_YEAR, DEFAULT_START_YEAR, 100, 50)
    .setID("start_year")
    .addSlider("To", DEFAULT_START_YEAR, DEFAULT_END_YEAR, DEFAULT_END_YEAR, 100, 50)
    .setID("end_year")
    .setChangeListener((e, v, f) -> buildFilteredList(e, f))
    .addButton("Reset", () -> { })
    .setID("reset_button")
  .run();
}

void buildFilteredList(FormElement e, Form f) {
  if (f.getById("reset_button") == e) {
    f.getById("start_year").setValue(DEFAULT_START_YEAR);
    f.getById("end_year").setValue(DEFAULT_END_YEAR);
  }
  int yearFrom = f.getById("start_year").asInt();
  int yearTo = f.getById("end_year").asInt();
  
  workingList = originalList;
  workingList = workingList.stream().filter(m -> m.inRange(yearFrom, yearTo))
                                    .collect(Collectors.toList());

}
