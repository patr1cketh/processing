import java.util.stream.Collectors;

final int DEFAULT_START_YEAR = 1500;
final int DEFAULT_END_YEAR = 2020;

void createFilteringGUI() {
  gui.createForm("Filter Meteorites")
    .addButton("Reset", () -> { })
  .run();
}

void buildFilteredList(FormElement e, Form f) {

}
