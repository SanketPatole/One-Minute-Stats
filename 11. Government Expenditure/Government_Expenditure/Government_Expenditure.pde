
Table values;
Table ranks;
Table flags;
int n_cols;
int n_rows;
int n_bars;
int bar_spacing;
int max_bar_width;
int max_bar_height;
float left_margin;
float top_margin;
int [][] color_bar;
int day = 0;
int frame = 0;
int framerate = 30;
int marquee_x = 0;
PImage [][] flag_img;
PImage logo;
String project_path;
String flag_file_path;
String title = "Countries by Expenses (Billions)";
int adjustedDisplayWidth;
int adjustedDisplayHeight;

void setup() {
  project_path = sketchPath().substring(0,sketchPath().lastIndexOf('\\'));
  flag_file_path = project_path.substring(0,project_path.lastIndexOf('\\'));
  adjustedDisplayWidth = displayHeight;
  adjustedDisplayHeight = displayWidth;
  size(displayHeight, displayWidth);
  println(adjustedDisplayWidth, adjustedDisplayHeight);
  logo = loadImage(flag_file_path+"\\logo_transparent.PNG");
  logo.resize(adjustedDisplayWidth/5, adjustedDisplayHeight/5);
  values = loadTable(project_path+"\\values.csv", "header");
  ranks = loadTable(project_path+"\\ranks.csv", "header");
  flags = loadTable(flag_file_path+"\\flags.csv", "header");
  n_cols = values.getColumnCount();
  n_rows = values.getRowCount();
  n_bars = 10;
  bar_spacing = 10;
  max_bar_width = (adjustedDisplayWidth - (adjustedDisplayWidth/5)*2);
  max_bar_height = ((adjustedDisplayHeight - (adjustedDisplayHeight/5)*2) / n_bars);
  left_margin = adjustedDisplayWidth*25/100;
  top_margin = adjustedDisplayHeight/5;
  color_bar = new int [n_cols][3];
  for(int i=0; i<n_cols; i++) {
    color_bar[i][0] = int(random(200));
    color_bar[i][1] = int(random(200));
    color_bar[i][2] = int(random(200));
  }
  flag_img = new PImage[n_cols][2];
  for (int i=2; i<n_cols; i++) {
    String img_file_name = "unf.png";
    TableRow img_row_obj = flags.findRow( values.getColumnTitle(i), flags.getColumnTitle(0));
    if(img_row_obj != null) {
      img_file_name = img_row_obj.getString(1);
    }
    PImage img_obj1 = loadImage(flag_file_path+"\\flags\\"+img_file_name);
    PImage img_obj2 = loadImage(flag_file_path+"\\flags\\"+img_file_name);
    flag_img[i][0] = img_obj1;
    flag_img[i][1] = img_obj2;
    flag_img[i][0].resize(int((max_bar_height - 2*bar_spacing)*5/3), int((max_bar_height - 2*bar_spacing)*5/3));
    flag_img[i][1].resize(adjustedDisplayWidth/5, adjustedDisplayHeight/8);
  }
} 

void draw() {
  if (day == n_rows) {
    day = n_rows-1;
  }
  background(255, 255, 255);
  //image(logo, 0, 0);
  fill(255, 0, 0);
  textSize(40);
  textAlign(LEFT);
  if (marquee_x > adjustedDisplayWidth) {
    marquee_x = - int(textWidth("Like, Comment, Share and Subscribe to One Minute Stats"));
  }
  text("Like, Comment, Share and Subscribe to One Minute Stats", marquee_x, adjustedDisplayHeight*14/15);
  marquee_x++;
  textSize(65);
  textAlign(CENTER);
  text(title, adjustedDisplayWidth/2, adjustedDisplayHeight/8);
  textSize(70);
  text('1', adjustedDisplayWidth*2/5 + (adjustedDisplayWidth/5)*0.5, adjustedDisplayHeight*3/4);
  text('2', adjustedDisplayWidth*2/5 + (adjustedDisplayWidth/5)*1.5, adjustedDisplayHeight*3/4);
  text('3', adjustedDisplayWidth*2/5 + (adjustedDisplayWidth/5)*2.5, adjustedDisplayHeight*3/4);
  
  TableRow row_values = values.getRow(day);
  TableRow row_ranks = ranks.getRow(day);
  float max_value = 1;
  for(int i=2; i<n_cols; i++) {
    if(row_values.getFloat(i)>max_value) {
      max_value = row_values.getFloat(i);
    }
  }
  for(int i=2; i<n_cols; i++) {
    float rank_val = row_ranks.getFloat(i);
    float value = row_values.getFloat(i);
    if(rank_val<n_bars) {
      float bar_y = top_margin + (rank_val*max_bar_height) + bar_spacing;
      float bar_width = map(value, 0, max_value, 0, max_bar_width);
      float bar_height = max_bar_height - 2*bar_spacing;
      fill(color_bar[i][0], color_bar[i][1], color_bar[i][2]);
      stroke(color_bar[i][0]*3/4, color_bar[i][1]*3/4, color_bar[i][2]*3/4);
      rect(left_margin, bar_y, bar_width, bar_height);
      if(bar_width > bar_height*5/3) {
        image(flag_img[i][0], left_margin + bar_width - bar_height*5/3, bar_y - bar_height/3);
      }
      fill(color_bar[i][0]*3/4, color_bar[i][1]*3/4, color_bar[i][2]*3/4);
      textSize(bar_height*3/10);
      textAlign(RIGHT);
      text(row_values.getColumnTitle(i), left_margin - bar_spacing, bar_y + bar_height/2 + bar_spacing);
      textSize(bar_height*3/10);
      textAlign(LEFT);
      text(int(row_values.getFloat(i)), left_margin + bar_width + bar_spacing, bar_y + bar_height/2 + bar_spacing);
      if(rank_val<3) {
        image(flag_img[i][1], adjustedDisplayWidth*2/5 + (adjustedDisplayWidth/5)*rank_val - 10, adjustedDisplayHeight*3/4);
      }
    }
  }
  fill(0, 0, 0);
  textSize(max_bar_height*0.9);
  textAlign(CENTER);
  text(row_values.getString(0).substring(0, 10), adjustedDisplayWidth*65/100, adjustedDisplayHeight*65/100);

  day++;
  frame++;


  if (frame < n_rows) {
    saveFrame(project_path+"\\Movie\\image_#####.png");
    textSize(50);
    textAlign(CENTER);
    text("Recording in progress "+frame/framerate, adjustedDisplayWidth/2, adjustedDisplayHeight/8);
  }
  else {
    textSize(50);
    textAlign(CENTER);
    text("Recording Stopped "+frame/framerate, adjustedDisplayWidth/2, adjustedDisplayHeight/8);
    exit();
  }

}
