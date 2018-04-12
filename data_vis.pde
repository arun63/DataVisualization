int statYear = 2011;
int CurrentData = 0;
int CurrentDataNew;
int CurrentColor = 0;
int CurrentColorNew;
int CurrentAnimate = 0;
int CurrentAnimateNew;
int MiniBoxMouseN;
int StateMouseOver = 0;
int DataBoxOverlay,  SortBoxOverlay, AnimateBoxOverlay, BLACKCOLOR, WHITECOLOR, GRAYCOLOR;

int z;
String CurrentState, CurrentStateString, CurrentStateAbbr, CurrentStateMouseOver;

// CSV Table
Table popstat;

// Store table values into a list.
StringList State, StaticValues, AnimateStrings, SortStrings;

FloatList Total_pop, Male_pop, Fem_pop, Age_0_14, Age_15_24, Age_25_44, Age_45_64, Age_65plus, Total_single, Total_married;


FloatDict SortedData, SortedNames;

// Ireland SVG
//String[] StateString = { "Carlow","Cavan","Clare","Cork_City","Cork_County","Donegal","Dublin_City","Dun_Laoghaire_Rathdown","Fingal","Galway_City","Galway_County","Kerry",
//"Kildare","Kilkenny","Laois","Leitrim","Limerick","Longford","Louth","Mayo","Meath","Monaghan","Offaly","Roscommon","Sligo","South_Dublin","Tipperary","Waterford","Westmeath","Wexford","Wicklow"};

String[] StateString = {"CA","CV","CL","CO","CC","DO","DC","DL","FI","GA","GC","KE","KI","KL","LA","LE","LI","LO","LU","MA","ME","MO","OF","RO","SL","SD","TI","WF","WM","WE","WL"};


PShape States, Ireland, StateShape;

PGraphics Basemap;

// Amount of bars
int BARAMOUNT = 31;

// Pixel Distance from left to right
float DISTANCE = 100;

// Distance between bars
int SPREADOUT = 2;

// Bar Width
float BARWIDTH;

// Animation Speed (60 = 1 second)
int ANIMATIONSPEED = 30;

float x1, y1, x2, y2, x3, y3, x4, DATAVALUE, ADDVALUE, DATAVALUE2, DATADIVIDE, PERCENTDIVIDE, ColorBall1, ColorBall2, ColorBall3, MaxValue;
float DATADIVIDE2 = 1;

FloatList DATA, DATA2, DATACHECK, CURRENTCOLOR, CURRENTCOLOR2, COLORCHECK;

FloatList MouseXLeft, MouseXRight, MouseYUp, MouseYDown;

int DELAY = 0;
int DELAY1 = 0;
int DELAY2 = 0;
int DELAY3 = 0;

int SORT = 0;
int count = 0;

float MainColor1, MainColor2, MainColor3, ColorA, ColorB, ColorC, ColorD, ColorE, ColorF, ColorG, ColorH, ColorI, ColorJ, ColorK, ColorL;

// Color Scheme Boxes
color ColorScheme1, ColorScheme2, ColorScheme3, ColorScheme4, BasemapColor;

boolean MINIBOX = false;
float Right, Left, Up, Down;


int OverDataBox, OverPercentBox, OverColorBox, OverSortBox;

boolean REDRAW = true;
boolean SORTING = false;
boolean DATAOVER = false;
boolean SORTDATAOVER = false;
boolean ANIMATEDATAOVER = false;
boolean DATABOXES = false;
boolean SORTBOXES = false;
boolean ANIMATEBOXES = false;
boolean DATABOXESOVER = false;
boolean SORTBOXESOVER = false;
boolean ANIMATEBOXESOVER = false;

boolean REVERSE = false;
boolean PLAY = false;


void setup() {
  //size(displayWidth, displayHeight);
  size(1500, 920);
  surface.setTitle("Data Visualization");
  smooth();
  if(surface != null) {  
    surface.setResizable(true);
  }
    
  background(255);

  Ireland = loadShape("data/ireland_admin.svg");
  State = new StringList();
  StaticValues = new StringList();
  SortStrings = new StringList();
  AnimateStrings = new StringList();
  Total_pop = new FloatList();
  Male_pop = new FloatList();
  Fem_pop = new FloatList();
  Age_0_14 = new FloatList();
  Age_15_24 = new FloatList();
  Age_25_44 = new FloatList();
  Age_45_64 = new FloatList();
  Age_65plus = new FloatList(); 
  Total_single = new FloatList();
  Total_married = new FloatList();
  
  StaticValues.append("Total Population");
  StaticValues.append("Male Population");
  StaticValues.append("Female Population");
  StaticValues.append("Age: 0-14");
  StaticValues.append("Age: 15-24");
  StaticValues.append("Age: 25-44");
  StaticValues.append("Age: 45-64");  
  StaticValues.append("Age: 65-plus");
  StaticValues.append("Status: Single");
  StaticValues.append("Status: Married");
  
  SortStrings.append("Alphabetical");
  SortStrings.append("Ascending");
  SortStrings.append("Descending");
  
  AnimateStrings.append("Play");
  AnimateStrings.append("Stop");
  AnimateStrings.append("Reverse");
  
  popstat = loadTable("data/data_vis.csv", "header");
  
  for (TableRow row : popstat.rows()) {
    
    String state = row.getString("County");
    float total_pop = row.getInt("Total_Population_2011");
    float male_pop = row.getInt("Male_Population_2011");
    float fem_pop = row.getInt("Female_Population_2011");
    float age_0_14 = row.getInt("Age_Band_0_14_2011");
    float age_15_24 = row.getInt("Age_Band_15_24_2011");
    float age_25_44 = row.getInt("Age_Band_25_44_2011");
    float age_45_64 = row.getInt("Age_Band_45_64_2011");
    float age_65plus = row.getInt("Age_Band_65plus_2011");
    float total_single = row.getInt("Total_Single_2011");
    float total_married = row.getInt("Total_Married_2011");
 
    State.append(state);
    Total_pop.append(total_pop);     
    Male_pop.append(male_pop);
    Fem_pop.append(fem_pop);
    Age_0_14.append(age_0_14);
    Age_15_24.append(age_15_24);
    Age_25_44.append(age_25_44);
    Age_45_64.append(age_45_64);
    Age_65plus.append(age_65plus);
    Total_single.append(total_single);
    Total_married.append(total_married);
 
  }
    
  SortedNames = new FloatDict();
  SortedData = new FloatDict();    
  DATA = new FloatList();
  DATA2 = new FloatList();
  DATACHECK = new FloatList(); 
  CURRENTCOLOR = new FloatList();
  CURRENTCOLOR2 = new FloatList();
  COLORCHECK = new FloatList();
  
  MouseXRight = new FloatList();
  MouseXLeft = new FloatList();
  MouseYUp = new FloatList();
  MouseYDown = new FloatList();  
    
  for (int n = 0; n < BARAMOUNT; n++) {
    DATA2.append(height);
    CURRENTCOLOR2.append(0);
    CURRENTCOLOR2.append(0);
    CURRENTCOLOR2.append(0);
  }   
  
}


void draw() {
  update(mouseX, mouseY);
  
  if (BLACKCOLOR > 0) {
    BLACKCOLOR = BLACKCOLOR - 255/ANIMATIONSPEED;
  }
  if (BLACKCOLOR <= 0) {
    BLACKCOLOR = 0;
  }
  if (WHITECOLOR < 255) {
    WHITECOLOR = WHITECOLOR + 255/ANIMATIONSPEED;
  }
  if (WHITECOLOR >= 255) {
    WHITECOLOR = 255;
  }
  if (GRAYCOLOR > 50) {
    GRAYCOLOR = GRAYCOLOR - 155/ANIMATIONSPEED;
  }
  if (GRAYCOLOR <= 50) {
    GRAYCOLOR = 50;
  }
  
  smooth();
  background(WHITECOLOR);
  
  if (PLAY == true) {
    DELAY++;
    if (REVERSE == false) {
      if (DELAY == 120) {
        if(CurrentData == 9) {
          CurrentData = 0;
        }
        CurrentData++;
        DELAY = 0;
      }
    }
    if (REVERSE == true) {
      if (DELAY == 120) {
        if(CurrentData == 0) {
          CurrentData = 9;
        }
        CurrentData--;
        DELAY = 0;
      }
    }
  }
  
  textAlign(CENTER, CENTER);
  fill(BLACKCOLOR, BLACKCOLOR, BLACKCOLOR, 25);
  if (height >= width)
    {
    textSize(width*.5);
    }
  if (width > height)
    {
    textSize(height*.5);
    }
  text(statYear, width/2, 3*height/5);
  
  
  // Calculate New Data
  if (CurrentData != CurrentDataNew || REDRAW == true) {      
    CurrentDataNew = CurrentData;
    REDRAW = false;
    
    DATA = new FloatList();
    DATACHECK = new FloatList();
    CURRENTCOLOR = new FloatList();
    COLORCHECK = new FloatList();
    SortedNames = new FloatDict();
    SortedData = new FloatDict();    
    
    // Colors for the map    
    ColorA = 255; 
    ColorB = 255;
    ColorC = 204; 
    ColorD = 161; 
    ColorE = 218; 
    ColorF = 180; 
    ColorG = 65; 
    ColorH = 182;
    ColorI = 196;
    ColorJ = 34;
    ColorK = 94;
    ColorL = 168;
    
    for (int n = 0; n < 31; n++) {
      if (CurrentData == 0) {
        MaxValue = Total_pop.max();
        ADDVALUE = height - ((Total_pop.get(n)*(height/5))/Total_pop.max());
      } else if (CurrentData == 1) {
        MaxValue = Male_pop.max();
        ADDVALUE = height - ((Male_pop.get(n)*(height/5))/Male_pop.max());
      } else if (CurrentData == 2) {
        MaxValue = Fem_pop.max();
        ADDVALUE = height - ((Fem_pop.get(n)*(height/5))/Fem_pop.max());
      } else if (CurrentData == 3) {
        MaxValue = Age_0_14.max();
        ADDVALUE = height - ((Age_0_14.get(n)*(height/5))/Age_0_14.max());
      } else if (CurrentData == 4) {
        MaxValue = Age_15_24.max();
        ADDVALUE = height - ((Age_15_24.get(n)*(height/5))/Age_15_24.max());
      } else if (CurrentData == 5) {
        MaxValue = Age_25_44.max();
        ADDVALUE = height - ((Age_25_44.get(n)*(height/5))/Age_25_44.max());
      } else if (CurrentData == 6) {
        MaxValue = Age_45_64.max();
        ADDVALUE = height - ((Age_45_64.get(n)*(height/5))/Age_45_64.max());
      } else if (CurrentData == 7) {
        MaxValue = Age_65plus.max();
        ADDVALUE = height - ((Age_65plus.get(n)*(height/5))/Age_65plus.max());
      } else if (CurrentData == 8) {
        MaxValue = Total_single.max();
        ADDVALUE = height - ((Total_single.get(n)*(height/5))/Total_single.max());
      } else if (CurrentData == 9) {
        MaxValue = Total_married.max();
        ADDVALUE = height - ((Total_married.get(n)*(height/5))/Total_married.max());
      } 
      
      DATA.append(ADDVALUE);      
      DATADIVIDE = height;
    }
    
    for (int n = 0; n < DATA.size(); n++) {
      //print(StateString[n]);
      SortedData.set(StateString[n], DATA.get(n));
      SortedNames.set(State.get(n), DATA.get(n));
    }
    
    if (SORT == 1) {
      DATA.sortReverse();
      SortedData.sortValuesReverse();
      SortedNames.sortValuesReverse();
    } else if (SORT == 2) {
      DATA.sort();
      SortedData.sortValues();
      SortedNames.sortValues();
    } else{
    } 

    for (int n = 0; n < DATA.size(); n++) {
      // Lighter -- > Darker
      if (DATA.get(n)/height > (1 - (.25/4))) {
        MainColor1 = ColorA;
        MainColor2 = ColorB;
        MainColor3 = ColorC;
      }
      else if (DATA.get(n)/height > (1 - (.5/4))) {
        MainColor1 = ColorD;
        MainColor2 = ColorE;
        MainColor3 = ColorF;
      } else if (DATA.get(n)/height > (1 - (.75/4))) {
        MainColor1 = ColorG;
        MainColor2 = ColorH;
        MainColor3 = ColorI;
      } else if (DATA.get(n)/height >= 0) {
        MainColor1 = ColorJ;
        MainColor2 = ColorK;
        MainColor3 = ColorL;
      }
        
      CURRENTCOLOR.append(MainColor1);
      CURRENTCOLOR.append(MainColor2);
      CURRENTCOLOR.append(MainColor3);

      if (CURRENTCOLOR.get(3*n) > CURRENTCOLOR2.get(3*n)) {
        COLORCHECK.append((CURRENTCOLOR.get(3*n) - CURRENTCOLOR2.get(3*n))/ANIMATIONSPEED);
      }
      if (CURRENTCOLOR.get(3*n) < CURRENTCOLOR2.get(3*n)) {
        COLORCHECK.append((CURRENTCOLOR2.get(3*n) - CURRENTCOLOR.get(3*n))/ANIMATIONSPEED);
      }  
      if (CURRENTCOLOR.get(3*n) == CURRENTCOLOR2.get(3*n)) {
        COLORCHECK.append(0);
      }
        
      if (CURRENTCOLOR.get(3*n + 1) > CURRENTCOLOR2.get(3*n + 1)) {
        COLORCHECK.append((CURRENTCOLOR.get(3*n + 1) - CURRENTCOLOR2.get(3*n + 1))/ANIMATIONSPEED);
      }
      if (CURRENTCOLOR.get(3*n + 1) < CURRENTCOLOR2.get(3*n + 1)) {
        COLORCHECK.append((CURRENTCOLOR2.get(3*n + 1) - CURRENTCOLOR.get(3*n + 1))/ANIMATIONSPEED);
      }
      if (CURRENTCOLOR.get(3*n + 1) == CURRENTCOLOR2.get(3*n + 1)) {
        COLORCHECK.append(0);
      } 
        
      if (CURRENTCOLOR.get(3*n + 2) > CURRENTCOLOR2.get(3*n + 2)) {
        COLORCHECK.append((CURRENTCOLOR.get(3*n + 2) - CURRENTCOLOR2.get(3*n + 2))/ANIMATIONSPEED);
      }
      if (CURRENTCOLOR.get(3*n + 2) < CURRENTCOLOR2.get(3*n + 2)) {
        COLORCHECK.append((CURRENTCOLOR2.get(3*n + 2) - CURRENTCOLOR.get(3*n + 2))/ANIMATIONSPEED);
      } 
      if (CURRENTCOLOR.get(3*n + 2) == CURRENTCOLOR2.get(3*n + 2)) {
        COLORCHECK.append(0);
      } 
      
      // Animation speed
      if (DATA.get(n) > DATA2.get(n)) {    
        DATACHECK.append((DATA.get(n) - DATA2.get(n))/ANIMATIONSPEED);
      }
      if (DATA2.get(n) > DATA.get(n)) {    
        DATACHECK.append((DATA2.get(n) - DATA.get(n))/ANIMATIONSPEED);
      }
      if (DATA.get(n) == DATA2.get(n)) {    
        DATACHECK.append(0);
      }
    }
  }

  textAlign(CENTER, CENTER);
    
  DISTANCE = width*.1;  
  float BARWIDTH = (((width-(DISTANCE*2))  /  BARAMOUNT));
  float BARBETWEEN = (((width-(DISTANCE*2)) - (BARWIDTH + BARWIDTH*(DATA.size()-1))));
  
  x1 = DISTANCE;
  y1 = height-(height/16);
  x2 = BARWIDTH+DISTANCE;
  y2 = height-(height/16);
  x3 = BARWIDTH+DISTANCE;
  x4 = DISTANCE;  
      
  noStroke();    
      
  for (int n = 0; n < DATA.size(); n++) {
    // Redraw Functions.  Establishes size and bar-growth rate.
    DATADIVIDE2 = height/DATADIVIDE;
    
    if (DATADIVIDE != height) {
      DATA2.set(n, DATA.get(n)*DATADIVIDE2);
    }
    
    if (DATA.get(n)*DATADIVIDE2 > DATA2.get(n)) {
      DATA2.set(n, DATA2.get(n) + DATACHECK.get(n));
    }
    
    if (DATA2.get(n) > DATA.get(n)*DATADIVIDE2) {
      DATA2.set(n, DATA2.get(n) - DATACHECK.get(n));
    }
      
    // Pulls colors out of color array.
    if (CURRENTCOLOR.get(3*n) > CURRENTCOLOR2.get(3*n)) {
      CURRENTCOLOR2.set((3*n), CURRENTCOLOR2.get(3*n) + COLORCHECK.get(3*n));
    }
    if (CURRENTCOLOR.get(3*n) < CURRENTCOLOR2.get(3*n)) {
      CURRENTCOLOR2.set((3*n), CURRENTCOLOR2.get(3*n) - COLORCHECK.get(3*n));
    }
    if (CURRENTCOLOR.get(3*n) == CURRENTCOLOR2.get(3*n)) {
      CURRENTCOLOR2.set((3*n), CURRENTCOLOR2.get(3*n) - COLORCHECK.get(3*n));
    } 
      
    if (CURRENTCOLOR.get(3*n + 1) > CURRENTCOLOR2.get(3*n + 1)) {
      CURRENTCOLOR2.set((3*n + 1), CURRENTCOLOR2.get(3*n + 1) + COLORCHECK.get(3*n + 1));
    }
    if (CURRENTCOLOR.get(3*n + 1) < CURRENTCOLOR2.get(3*n + 1)) {
      CURRENTCOLOR2.set((3*n + 1), CURRENTCOLOR2.get(3*n + 1) - COLORCHECK.get(3*n + 1));
    }
    if (CURRENTCOLOR.get(3*n + 1) == CURRENTCOLOR2.get(3*n + 1)) {
      CURRENTCOLOR2.set((3*n + 1), CURRENTCOLOR2.get(3*n + 1) - COLORCHECK.get(3*n + 1));
    } 
      
    if (CURRENTCOLOR.get(3*n + 2) > CURRENTCOLOR2.get(3*n + 2)) {
      CURRENTCOLOR2.set((3*n + 2), CURRENTCOLOR2.get(3*n + 2) + COLORCHECK.get(3*n + 2));
    }
    if (CURRENTCOLOR.get(3*n + 2) < CURRENTCOLOR2.get(3*n + 2)) {
      CURRENTCOLOR2.set((3*n + 2), CURRENTCOLOR2.get(3*n + 2) - COLORCHECK.get(3*n + 2));
    }
    if (CURRENTCOLOR.get(3*n + 2) == CURRENTCOLOR2.get(3*n + 2)) {
      CURRENTCOLOR2.set((3*n + 2), CURRENTCOLOR2.get(3*n + 2) - COLORCHECK.get(3*n + 2));
    } 
     
    // Variable
    y3 = DATA2.get(n)-(height/16);
    
    String[] NewValues = SortedData.keyArray();
    CurrentStateAbbr = NewValues[n];
    
    stroke(0);
    strokeWeight(SPREADOUT);

    fill(CURRENTCOLOR2.get(3*n), CURRENTCOLOR2.get(3*n + 1), CURRENTCOLOR2.get(3*n + 2));
      
    // Bars
    quad(x1 + (BARWIDTH + BARBETWEEN/BARAMOUNT)*n, y2, x2 + (BARWIDTH + BARBETWEEN/BARAMOUNT)*n, y2, x3 + (BARWIDTH + BARBETWEEN/BARAMOUNT)*n, 
      y3, x4 + (BARWIDTH + BARBETWEEN/BARAMOUNT)*n, y3);
    
 
    PShape States = Ireland.getChild(CurrentStateAbbr);
    //print(CurrentStateAbbr);
    States.disableStyle();
    
    if(height >= width) {
      shape(States, ((width/2) - ((933*((width-100)*.001))/2)), 40, 933*((width-100)*.001), 670*((width-100)*.001));
    }
    else if (width > height && height >= 100) {
      shape(States, ((width/2) - ((933*((height-100)*.001))/2)), 40, 933*((height-100)*.001), 670*((height-100)*.001));
    }
    else if (height <= 100) {
    }
      
    if (n == 0) {
      MouseXRight = new FloatList();
      MouseXLeft = new FloatList();
      MouseYUp = new FloatList();
      MouseYDown = new FloatList();   
    }
      
    MouseXLeft.append(x1 + (BARWIDTH + BARBETWEEN/BARAMOUNT)*n);
    MouseXRight.append(x2 + (BARWIDTH + BARBETWEEN/BARAMOUNT)*n);
    MouseYUp.append(y3);
    MouseYDown.append(y1);

    // Adding the city names
    fill(BLACKCOLOR);
    textSize(width*.008);
    text(CurrentStateAbbr, x1 + (BARWIDTH + BARBETWEEN/BARAMOUNT)*n + 
      (x2 + (BARWIDTH + BARBETWEEN/BARAMOUNT)*n - (x1 + (BARWIDTH + BARBETWEEN/BARAMOUNT)*n))/2, height - (height/18));
  }
  
  if(MINIBOX == true) {
    // Highlight
    stroke(0, 0, 0, 100);
    fill(0, 0, 0, 100);    
    rect(Left, (height - (1)*(height/16)), Right - Left, Up - (height - (1)*(height/16)));
    
    PShape States = Ireland.getChild(CurrentStateString);
    States.disableStyle();
    
    if(height >= width) {
      shape(States, ((width/2) - ((933*((width-100)*.001))/2)), 40, 933*((width-100)*.001), 670*((width-100)*.001));
      
    } else if (width > height && height >= 100) {
      shape(States, ((width/2) - ((933*((height-100)*.001))/2)), 40, 933*((height-100)*.001), 670*((height-100)*.001));
      
    } else if (height <= 100) {
    }
  }
 
  // Adding the bar graph numbers
  for (int n = 0; n < 5; n++) {
    fill(BLACKCOLOR);
    textAlign(RIGHT, CENTER);
    textSize(width*.01);
    text(int((MaxValue/4)*n), (width*.1) - width*.01, height - (n+1)*(height/16));
    strokeWeight(2);
    stroke(BLACKCOLOR); 
    if (n >= 1) {
      strokeWeight(1);
      stroke(GRAYCOLOR);
    }
    line((width*.1 - 5), height - (n+1)*(height/16), (width + 5 - width*.1), height - (n+1)*(height/16));
  }
  
  // Text
  textAlign(CENTER, CENTER);
  textSize(width*.02);
  fill(BLACKCOLOR);
  text("IRELAND POPULATION STATS", (width*.7) - width*.2, 12);
  //text("POPULATION STATS", width - (width*.3) + width*.01, 12);
  
  
  if (width >= height) {
    textSize(height*.035); 
  }
  if (height > width) {
    textSize(width*.035);
  }
  text(StaticValues.get(CurrentData), width/2, height - height*.029);
  
  // Data Select
  strokeWeight(2);
  stroke(0);
  if (width >= height) {
    textSize(height*.013);
  }
  if (height > width) {
    textSize(width*.013);
  }
  textAlign(CENTER, CENTER);
  
  fill(200, 200, 200, 200);
  if (DATAOVER == true) {
    fill(240, 240, 240, 200);
  }
  rect(width*.1, (height - ((height*5)/16) - height*.001), (width - width*.2)/3, -height*.025);
  fill(0);
  text("CATEGORIES", (width*.2 + (width - width*.2)/3)/2, (height - ((height*5)/16) - height*.015));
  
  fill(200, 200, 200, 200);
  if (SORTDATAOVER == true) {
    fill(240, 240, 240, 200);
  }   
  rect(width*.1 + (width - width*.2)/3, (height - ((height*5)/16) - height*.001), (width - width*.2)/3, -height*.025);
  fill(0);
  text("TRANSFORM : SORT", (width*.2 + 3*(width - width*.2)/3)/2, (height - ((height*5)/16) - height*.015));
  
  fill(200, 200, 200, 200);
  if (ANIMATEDATAOVER == true) {
    fill(240, 240, 240, 200);
  }   
  rect(width*.1 + 2*(width - width*.2)/3, (height - ((height*5)/16) - height*.001), (width - width*.2)/3, -height*.025);
  fill(0);
  text("AUTOPLAY", (width*.2 + 5*(width - width*.2)/3)/2, (height - ((height*5)/16) - height*.015));
   
  textAlign(LEFT, CENTER);
  if (DATABOXES == true) {
    for (int n = 0; n < StaticValues.size(); n++) {
      strokeWeight(1);
      stroke(0);
      fill(200, 200, 200, 200);
      rect(width*.1, (height - ((height*5)/16) - height*.001) - height*.025*n - height*.025, (width - width*.2)/3, -height*.025);
      if (DataBoxOverlay == n) {
        noStroke();
        fill(0, 0, 0, 100);
        rect(width*.1, (height - ((height*5)/16) - height*.001) - height*.025*n - height*.025, (width - width*.2)/3, -height*.025);
        }
      fill(0);
      text(StaticValues.get(n), width*.1 + 2, (height - ((height*5)/16) - height*.015) - height*.025*n - height*.025);
    }
  }

  if (SORTBOXES == true) {
    for (int n = 0; n < SortStrings.size(); n++) {
      strokeWeight(1);
      stroke(0);
      fill(200, 200, 200, 200);
      rect(width*.1 + (width - width*.2)/3, (height - ((height*5)/16) - height*.001) - height*.025*n - height*.025, (width - width*.2)/3, -height*.025);
      if (SortBoxOverlay == n) {
        noStroke();
        fill(0, 0, 0, 100);
        rect(width*.1 + (width - width*.2)/3, (height - ((height*5)/16) - height*.001) - height*.025*n - height*.025, (width - width*.2)/3, -height*.025);
        }
      fill(0); 
      text(SortStrings.get(n), (width*.1 + (width - width*.2)/3) + 2, (height - ((height*5)/16) - height*.015) - height*.025*n - height*.025);
      }
    }

  if (ANIMATEBOXES == true) {
    for (int n = 0; n < AnimateStrings.size(); n++)
      {
      strokeWeight(1);
      stroke(0);
      fill(200, 200, 200, 200);
      rect(width*.1 + 2*(width - width*.2)/3, (height - ((height*5)/16) - height*.001) - height*.025*n - height*.025, (width - width*.2)/3, -height*.025);
      if (AnimateBoxOverlay == n) {
        noStroke();
        fill(0, 0, 0, 100);
        rect(width*.1 + 2*(width - width*.2)/3, (height - ((height*5)/16) - height*.001) - height*.025*n - height*.025, (width - width*.2)/3, -height*.025);
        }
      fill(0); 
      text(AnimateStrings.get(n), (width*.1 + 2*(width - width*.2)/3) + 2, (height - ((height*5)/16) - height*.015) - height*.025*n - height*.025);
      }
    }
    
  // Minibox!
  if(MINIBOX == true) {
    strokeWeight(2);
    stroke(ColorG, ColorH, ColorI);
    fill(BLACKCOLOR, BLACKCOLOR, BLACKCOLOR, 220);
    rect((Left + (BARWIDTH/2)) - 65, Up - 55, 130, 40, 7);
    fill(ColorG, ColorH, ColorI);
    stroke(ColorG, ColorH, ColorI);
    triangle((Left + (BARWIDTH/2)), Up - 7, (Left + (BARWIDTH/2))-5, Up - 14, (Left + (BARWIDTH/2))+5, Up - 14);
    fill(WHITECOLOR);
    textAlign(LEFT, CENTER);
    textSize(11);
    text(CurrentState, (Left + (BARWIDTH/2)) - 60, Up - 48);
    text("  " + int(((DATA.get(MiniBoxMouseN) - DATADIVIDE)*(-1)*MaxValue)/(DATADIVIDE/4)), (Left + (BARWIDTH/2)) - 60, Up - 35);
  }
   
  Basemap = createGraphics(width, height);
  Basemap.beginDraw();
  Basemap.background(0);
  Basemap.noSmooth();
  for (int n = 0; n < StateString.length; n++) {
    String[] NewValues = SortedData.keyArray();
    CurrentStateMouseOver = NewValues[n];
      
    PShape StateShape = Ireland.getChild(CurrentStateMouseOver);
    StateShape.disableStyle();
    Basemap.fill(n + 10, 0, 0);
    Basemap.noStroke();
    if(height >= width) {
      Basemap.shape(StateShape, ((width/2) - ((933*((width-100)*.001))/2)), 40, 933*((width-100)*.001), 670*((width-100)*.001));
    } else if (width > height && height >= 100) {
      Basemap.shape(StateShape, ((width/2) - ((933*((height-100)*.001))/2)), 40, 933*((height-100)*.001), 670*((height-100)*.001));
    } else if (height <= 100) {
    }
  }
  Basemap.endDraw();
  
  StateMouseOver = int(red(Basemap.get(mouseX, mouseY))) - 10;

  if (StateMouseOver >= 0 && StateMouseOver <= 50) {
    String[] NewValues2 = SortedNames.keyArray();
    String[] NewValues = SortedData.keyArray();

    if (DATAOVER == false && SORTDATAOVER == false && ANIMATEDATAOVER == false && DATABOXESOVER == false 
      &&  SORTBOXESOVER == false && ANIMATEBOXESOVER == false) {
       
      stroke(0, 0, 0, 100);
      fill(0, 0, 0, 100);    
      rect(MouseXLeft.get(StateMouseOver), (height - (1)*(height/16)), MouseXRight.get(StateMouseOver) - MouseXLeft.get(StateMouseOver), 
        MouseYUp.get(StateMouseOver) - (height - (1)*(height/16)));
      
      PShape States = Ireland.getChild(NewValues[StateMouseOver]);
      States.disableStyle();
      
      if(height >= width) {
        shape(States, ((width/2) - ((933*((width-100)*.001))/2)), 40, 933*((width-100)*.001), 670*((width-100)*.001));
      } else if (width > height && height >= 100) {
        shape(States, ((width/2) - ((933*((height-100)*.001))/2)), 40, 933*((height-100)*.001), 670*((height-100)*.001));
      } else if (height <= 100) {
        
      } 
   
      strokeWeight(2);
      stroke(ColorG, ColorH, ColorI);
      fill(WHITECOLOR, WHITECOLOR, WHITECOLOR, 235);
      rect(mouseX + 20, mouseY + 20, 130, 40, 0, 7, 7, 7);
      fill(BLACKCOLOR);
      textAlign(LEFT, CENTER);
      textSize(11); 
      text(NewValues2[StateMouseOver], mouseX + 25, mouseY + 27);
      text("  " + int(((DATA.get(StateMouseOver) - DATADIVIDE)*(-1)*MaxValue)/(DATADIVIDE/4)), mouseX + 25, mouseY + 40);   
    }
  }
  
  //saveFrame("artefact/vis_######.tif");
  
}


void mousePressed(){
  
  if (mouseButton == LEFT) {
    if (DATAOVER == true) {
      DATABOXES = true;
    } 
    if (DATABOXESOVER == true) {
      CurrentData = OverDataBox;
      DATABOXES = false;
    }
    if (ANIMATEDATAOVER == true){
      ANIMATEBOXES = true; 
    }      
    if (ANIMATEBOXESOVER == true){
      if (AnimateBoxOverlay == 0) {
        PLAY = true;
      }
      if (AnimateBoxOverlay == 1) {
        PLAY = false;
      }
      if (AnimateBoxOverlay == 2) {
        if (REVERSE == true) {
          REVERSE = false;
        } else {
          REVERSE = true;
        }
      }
      DELAY = 0;
      ANIMATEBOXES = false;
      }
    if (SORTDATAOVER == true) {
      SORTBOXES = true; 
    }    
      
    if (SORTBOXESOVER == true) {
      if (SortBoxOverlay == 0 && SORT != 0) {
        SORT = 0;
        REDRAW = true;
      } else if (SortBoxOverlay == 1 && SORT != 1) {
        SORT = 1;
        REDRAW = true;
      } else if (SortBoxOverlay == 2 && SORT != 2) {
        SORT = 2;
        REDRAW = true;
      } 
      SORTBOXES = false;
    }
  }
  if (mouseButton == RIGHT) {
    DATAOVER = false;
    SORTDATAOVER = false;
    ANIMATEDATAOVER = false;
    MINIBOX = false;
    DATABOXESOVER = false;
    SORTBOXESOVER = false;
    ANIMATEBOXESOVER = false;
    SORTING = false;
    DataBoxOverlay = -1;
    SortBoxOverlay = -1;
    AnimateBoxOverlay = -1;  
  }
}

void update(float x, float y) {  
  DATAOVER = false;
  SORTDATAOVER = false;
  ANIMATEDATAOVER = false;
  MINIBOX = false;
  DATABOXESOVER = false;
  SORTBOXESOVER = false;
  ANIMATEBOXESOVER = false;
  SORTING = false;
  DataBoxOverlay = -1;
  SortBoxOverlay = -1;
  AnimateBoxOverlay = -1;
    
  for(int i = 0;  i < MouseXRight.size(); i++) {
    if ((mouseX <= MouseXRight.get(i)) && (mouseX >= MouseXLeft.get(i)) && (mouseY >= MouseYUp.get(i)) && (mouseY <= MouseYDown.get(i))) {
      MINIBOX = true;
      String[] NewValues2 = SortedNames.keyArray();
      CurrentState = NewValues2[i];  
      String[] NewValues = SortedData.keyArray();
      CurrentStateString = NewValues[i];
      MiniBoxMouseN = i;
      Right = MouseXRight.get(i);
      Left = MouseXLeft.get(i);
      Up = MouseYUp.get(i);
      Down = MouseYDown.get(i);
    }
  }
  if ((mouseX <= width*.1 + (width - width*.2)/4) && (mouseX >= width*.1) && (mouseY >= (height - ((height*5)/16) - height*.001) - height*.025) 
    && (mouseY <= (height - ((height*5)/16) - height*.001))) {
    DATAOVER = true;
    DELAY1++;
    if (DELAY1 >= 30) {
      DATABOXES = true;
    }
  }
  if ((mouseX <= width*.1 + 3*(width - width*.2)/4) && (mouseX >= width*.1 + 2*(width - width*.2)/4) && (mouseY >= (height - ((height*5)/16) - height*.001) - height*.025) 
    && (mouseY <= (height - ((height*5)/16) - height*.001))) {
    SORTDATAOVER = true;
    DELAY2++;
    if(DELAY2 >= 30) {
      SORTBOXES = true;
    }
  }
  if ((mouseX <= width*.1 + 4*(width - width*.2)/4) && (mouseX >= width*.1 + 3*(width - width*.2)/4) && (mouseY >= (height - ((height*5)/16) - height*.001) - height*.025) 
    && (mouseY <= (height - ((height*5)/16) - height*.001))) {
    ANIMATEDATAOVER = true;
    DELAY3++;
    if(DELAY3 >= 30) {
      ANIMATEBOXES = true;
     }
  }    
  if (DATABOXES == true) {
    for (int n = 0; n < StaticValues.size(); n++) {
      if ((mouseX <= width*.1 + (width - width*.2)/4) && (mouseX >= width*.1) 
        && (mouseY <= (height - ((height*5)/16) - height*.001) - height*.025*n - height*.025) 
        && (mouseY >= (height - ((height*5)/16) - height*.001) - height*.025*n - 2*height*.025)) {
        DATABOXESOVER = true;
        OverDataBox = n;
        DataBoxOverlay = n;
      }
    }
  }
  if (DATAOVER == false && DATABOXESOVER == false) {
    DATABOXES = false;
    DELAY1 = 0;
  }   
  
  if (SORTBOXES == true) {
    for (int n = 0; n < SortStrings.size(); n++) {
      if ((mouseX <= width*.1 + 3*(width - width*.2)/4) && (mouseX >= width*.1 + 2*(width - width*.2)/4) 
        && (mouseY <= (height - ((height*5)/16) - height*.001) - height*.025*n - height*.025) 
        && (mouseY >= (height - ((height*5)/16) - height*.001) - height*.025*n - 2*height*.025)) {
        SORTBOXESOVER = true;
        SortBoxOverlay = n;
      }
    }
  }
  if (SORTDATAOVER == false && SORTBOXESOVER == false) {
    SORTBOXES = false;
    DELAY2 = 0;
  }
  if (ANIMATEBOXES == true) {
    for (int n = 0; n < AnimateStrings.size(); n++) {
      if ((mouseX <= width*.1 + 4*(width - width*.2)/4) && (mouseX >= width*.1 + 3*(width - width*.2)/4) 
        && (mouseY <= (height - ((height*5)/16) - height*.001) - height*.025*n - height*.025) 
        && (mouseY >= (height - ((height*5)/16) - height*.001) - height*.025*n - 2*height*.025)) {
        ANIMATEBOXESOVER = true;
        AnimateBoxOverlay = n;
      }
    }
  }
  if (ANIMATEDATAOVER == false && ANIMATEBOXESOVER == false) {
    ANIMATEBOXES = false;
    DELAY3 = 0;
  }  
  if (DATAOVER == true  ||  SORTDATAOVER == true || ANIMATEDATAOVER == true
    || DATABOXESOVER == true || SORTBOXESOVER == true|| ANIMATEBOXESOVER == true) {
      
    cursor(HAND);
    
  } else if (DATAOVER == false && SORTDATAOVER == false && ANIMATEDATAOVER == false && DATABOXESOVER == false 
    && SORTBOXESOVER == false && ANIMATEBOXESOVER == false) {
      
    cursor(ARROW);
  }
}


  
  