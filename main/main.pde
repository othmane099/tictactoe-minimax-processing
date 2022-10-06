import java.util.HashMap;

String[][] board = {
  {"", "", ""}, 
  {"", "", ""}, 
  {"", "", ""}
};

int w;
int h;

boolean start=false;
boolean mode=false;
boolean p2=false;
boolean ordre=false;
boolean end=false;

String result = null;

String startFirst = null;

int boardWidth;
int boardHeight;

String player1;
String player2;
String currentPlayer;

PFont font;


Drop[] drops = new Drop[100];

void setup() {
  size(500, 500);  
  boardHeight=height;
  boardWidth=width;
  w=boardHeight/3;
  h=boardWidth/3;

  font = createFont("TicTacToe.ttf", 32);

  for (int i=0; i<drops.length; i++)
    drops[i] = new Drop();
}

boolean equals3(String a, String b, String c) {
  return a == b && b == c && a != "";
}

String checkWinner() {
  String winner = null;

  for (int i = 0; i < 3; i++) 
    if (equals3(board[i][0], board[i][1], board[i][2])) 
      winner = board[i][0];

  for (int i = 0; i < 3; i++) 
    if (equals3(board[0][i], board[1][i], board[2][i])) 
      winner = board[0][i];

  if (equals3(board[0][0], board[1][1], board[2][2])) 
    winner = board[0][0];

  if (equals3(board[2][0], board[1][1], board[0][2])) 
    winner = board[2][0];

  int openSpots = 0;
  for (int i = 0; i < 3; i++) 
    for (int j = 0; j < 3; j++) 
      if (board[i][j] == "") 
        openSpots++;

  if (winner == null && openSpots == 0) return "tie";
  else return winner;
}

void mousePressed() {

  if (!mode) { 
    if (mouseX>(width/2)-50 && mouseX<(width/2)+50 && mouseY>220 && mouseY<270) {
      mode=true;
    } else if (mouseX>(width/2)-50 && mouseX<(width/2)+50 && mouseY>290 && mouseY<340) {
      mode=true;
      p2=true;
      ordre= true;
    }
  } else if (!start) {
    if (mouseX>80 && mouseX<180 && mouseY>200 && mouseY<300) {
      player1="O";
      player2="X";
      start=true;
      currentPlayer=player1;
    } else if (mouseX>320 && mouseX<420 && mouseY>200 && mouseY<300) {
      player2="O";
      player1="X";
      currentPlayer=player1;
      start=true;
    }
  } else if (!ordre) { 
    if (mouseX>80 && mouseX<180 && mouseY>200 && mouseY<300) {
      ordre=true;
      startFirst = "human";
      currentPlayer=player1;
    } else if (mouseX>320 && mouseX<420 && mouseY>200 && mouseY<300) {
      ordre=true;
      startFirst = "pc";
      currentPlayer=player2;
      pcMove();
    }
  } else if (end) { 
    if (mouseX>(width/2)-50 && mouseX<(width/2)+50 && mouseY>220 && mouseY<270) {
      end=false;
      result = null;
      for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++) {
          board[i][j] = "";
        }
      }
      if (startFirst == "pc" && ordre && !p2) {
        currentPlayer=player2;
        pcMove();
      }
    } else if (mouseX>(width/2)-50 && mouseX<(width/2)+50 && mouseY>290 && mouseY<340) {
      result = null;
      for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++) {
          board[i][j] = "";
        }
      }
      end=false;
      mode = false;
      start = false;
      ordre=false;
      p2=false;
    }
  } else {
    if (p2) {
      if (currentPlayer == player2) {
        int i = floor(mouseX / w);
        int j = floor(mouseY / h);
        if (board[i][j] == "") {
          board[i][j] = player2;
          currentPlayer = player1;
        }
      } else {
        int i = floor(mouseX / w);
        int j = floor(mouseY / h);
        if (board[i][j] == "") {
          board[i][j] = player1;
          currentPlayer = player2;
        }
      }
    } else {
      if (currentPlayer == player1) {
        int i = floor(mouseX / w);
        int j = floor(mouseY / h);
        if (board[i][j] == "") {
          board[i][j] = player1;
          currentPlayer = player2;
          pcMove();
        }
      }
    }
  }
}
void draw() {
  strokeWeight(4);
  background(156, 136, 255);
  for (int i=0; i<drops.length; i++) {
    drops[i].fall();
    drops[i].show();
  }

  if (!mode && !end) {

    fill(251, 197, 49);
    noStroke();
    rect(0, 60, width, 80);

    textFont(font);
    fill(9, 132, 227);
    textSize(70);
    strokeWeight(5);
    text("Tic Tac Toe", 80, 125); 

    fill(251, 197, 49);
    noStroke();
    rect((width/2)-50, 220, 100, 50, 10, 10, 10, 10);
    noStroke();
    rect((width/2)-50, 290, 100, 50, 10, 10, 10, 10);

    fill(0, 102, 153);
    textSize(32);
    text("PC", 230, 255); 
    text("2P", 230, 325);
  }

  if (!start && mode && !end) {

    fill(251, 197, 49);
    noStroke();
    rect(0, 60, width, 50);

    textFont(font);
    fill(9, 132, 227);
    textSize(32);
    strokeWeight(5);
    text("Vous Voulez Jouer Avec :", 50, 95); 

    fill(251, 197, 49);
    noStroke();
    rect(80, 200, 100, 100, 10, 10, 10, 10);
    fill(251, 197, 49);
    noStroke();
    rect(width-180, 200, 100, 100, 10, 10, 10, 10);

    fill(251, 197, 49);
    noStroke();
    rect((width/2)-25, 225, 50, 50, 10, 10, 10, 10);

    fill(9, 132, 227);
    textSize(25);
    text("OU", 235, 260); 

    stroke(140, 122, 230);
    noFill();
    ellipse(130, 250, 60, 60);

    float xr = 30;
    line(370 - xr, 250 - xr, 370 + xr, 250 + xr);
    line(370 + xr, 250 - xr, 370 - xr, 250 + xr);
  }

  if (!ordre && start && mode && !p2 && !end) {

    fill(251, 197, 49);
    noStroke();
    rect(0, 60, width, 50);

    textFont(font);
    fill(9, 132, 227);
    textSize(32);
    strokeWeight(5);
    text("Vous Voulez Jouer En :", 50, 95); 

    fill(251, 197, 49);
    noStroke();
    rect(80, 200, 100, 100, 10, 10, 10, 10);

    fill(251, 197, 49);
    noStroke();
    rect(width-180, 200, 100, 100, 10, 10, 10, 10);

    fill(251, 197, 49);
    noStroke();
    rect((width/2)-25, 225, 50, 50, 10, 10, 10, 10);

    fill(9, 132, 227);
    textSize(25);
    text("OU", 235, 260);

    stroke(0);
    textSize(64);
    text("1", 115, 270); 

    textSize(64);
    text("2", 350, 270);
  }

  if (start && mode && ordre) {
    background(156, 136, 255);
    strokeWeight(4);
    line(w, 0, w, boardHeight);
    line(w * 2, 0, w * 2, boardHeight);
    line(0, h, boardWidth, h);
    line(0, h * 2, boardWidth, h * 2);

    for (int j = 0; j < 3; j++) {
      for (int i = 0; i < 3; i++) {
        float x = w * i + w / 2;
        float y = h * j + h / 2;
        String spot = board[i][j];
        textSize(32);
        if (spot=="O") {
          noFill();
          ellipse(x, y, w / 2, w / 2);
        } else if (spot == "X") {
          float xr = w / 4;
          line(x - xr, y - xr, x + xr, y + xr);
          line(x + xr, y - xr, x - xr, y + xr);
        }
      }
    }

    result = checkWinner();
    if (result != null) {
      end = true;
    }

    if (end) {
      for (int i=0; i<drops.length; i++) {
        drops[i].fall();
        drops[i].show();
      }

      fill(251, 197, 49);
      noStroke();
      rect(0, 60, width, 80);

      textFont(font);
      fill(9, 132, 227);
      textSize(70);
      strokeWeight(5);
      if (result == "tie") {
        text("Tie!", 200, 125);
      } else {
        text(result+" wins!", 150, 125);
      }

      fill(251, 197, 49);
      noStroke();
      rect((width/2)-70, 220, 140, 50, 10, 10, 10, 10);
      noStroke();
      rect((width/2)-70, 290, 140, 50, 10, 10, 10, 10);

      fill(0, 102, 153);
      textSize(32);
      text("Rejouer", 185, 255); 
      text("Accueil", 200, 325);
    }
  }
}

void pcMove() {
  int indexI = 0, indexJ = 0;
  int bestScore = -9999;
  for (int i = 0; i < 3; i++) {
    for (int j = 0; j < 3; j++) {
      if (board[i][j] == "") {
        board[i][j] = player2;
        int score = minimax(board, false);
        board[i][j] = "";
        if (score > bestScore) {
          bestScore = score;
          indexI = i;
          indexJ = j;
          break;
        }
      }
    }
  }
  board[indexI][indexJ] = player2;
  currentPlayer = player1;
}


int minimax(String[][] board, boolean isMaximizing) {

  int bestScore;

  HashMap<String, Integer> scores = new HashMap<String, Integer>();
  scores.put(player2, 1);
  scores.put(player1, -1);
  scores.put("tie", 0);

  String result = checkWinner();
  if (result != null)
    return scores.get(result);

  if (isMaximizing) {
    bestScore = -9999;
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (board[i][j] == "") {
          board[i][j] = player2;
          int score = minimax(board, false);
          board[i][j] = "";
          bestScore = max(score, bestScore);
        }
      }
    }
  } else {
    bestScore = 9999;
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (board[i][j] == "") {
          board[i][j] = player1;
          int score = minimax(board, true);
          board[i][j] = "";
          bestScore = min(score, bestScore);
        }
      }
    }
  }
  return bestScore;
}
