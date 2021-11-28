void displayForm() {
  // create a from to get input from the user
    gui.createForm("Choose a word")
    // each button will display a random noun
    .addButton(getRandomNoun(), () -> {}).setID("noun_1")
    .addButton(getRandomNoun(), () -> {}).setID("noun_2")
    .andWindow().setSize(200, 200).setPosition(width/2 - 100, height/2 - 100).save()
    .setChangeListener((element, value, form) -> {
      if (element.getId().equals("noun_1")) {
        binary_string += "0"; // if the first noun is chosen, add a "0" to binary_string
      }
      if (element.getId().equals("noun_2")) {
        binary_string += "1"; // if the second noun is chosen, add a "1" to binary_string
      }
      counter += 1; // increment the counter
      if (counter < 6) { // if the counter is less than 6, display the form again
        displayForm();
      }
      if (counter == 6) { // if it has run 6 times, close the form
       
        form.close();
        
      }
    })
    .show();
}
