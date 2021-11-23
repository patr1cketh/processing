import java.util.stream.Collectors;

final int DEFAULT_START_EPOCH = -30;
final int DEFAULT_END_EPOCH = 0;

final int DEFAULT_MAX_MAGNITUDE = 10;

final long DAYS_TO_MILLISECONDS = 24 * 60 * 60 * 1000;

void createFilteringGUI() {
  gui.createForm("Earthquakes (last 30 days)")
    .addLabel("By Date")
    .addSlider("From", DEFAULT_START_EPOCH, DEFAULT_END_EPOCH, DEFAULT_START_EPOCH, 5, 1)
    .setID("start_epoch")
    .addSlider("To", DEFAULT_START_EPOCH, DEFAULT_END_EPOCH, DEFAULT_END_EPOCH, 5, 1)
    .setID("end_epoch")
    .addLabel("By Magnitude")
    .addSlider("Up to ", 0, DEFAULT_MAX_MAGNITUDE, DEFAULT_MAX_MAGNITUDE, 2, 1)
    .setID("magnitude")
 
    .setChangeListener((e, v, f) -> buildFilteredList(e, f))
    .addButton("Reset", () -> { })
    .setID("reset_button")
    .andWindow().setSize(400, 500).save() //feature for assignment 2
    .run();
}

void buildFilteredList(FormElement e, Form f) {
  if (f.getById("reset_button") == e) {
    f.getById("start_epoch").setValue(DEFAULT_START_EPOCH);
    f.getById("end_epoch").setValue(DEFAULT_END_EPOCH);
    
  }

  long now = new Date().getTime();
  long epochFrom = now + f.getById("start_epoch").asInt() * DAYS_TO_MILLISECONDS;
  long epochTo = now + f.getById("end_epoch").asInt() * DAYS_TO_MILLISECONDS;

  
  workingList = originalList;
  workingList = workingList.stream().filter(m -> m.inDateRange(epochFrom, epochTo)).collect(Collectors.toList());
}
