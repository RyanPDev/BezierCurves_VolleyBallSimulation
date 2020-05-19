void keyPressed() {
  keyPressedForAllOtherStates();
}

void keyPressedForAllOtherStates() {
  switch(key) {
  case '9':
    state=stateShowMovieWithBeziers;
    break; 

  case '8':
    state=stateShowMovieLookingAhead;
    break;

  case '1':
    state=stateEditSouth;
    break;

  case '2':
    state=stateEditTop;
    break;
  }
}
