/* [Box Dimensions] */
//internal X Dimension
intX = 45;
//internal Y Dimension
intY = 50;
extWall = 2;

/* [Text] */
//2 dimensional array for text on lid in the format [["abc", "qrs"], ["xyz", "123"]]
strings = [["AM1", "AM2"], ["PM1", "PM2"]];
//height of text as percentage of one row height
textSize = 45; //[1:100]

module deboss(strings = [["a", "b", "c"], ["1", "2", "3"]], rot = 0) {
  xTrans = (intX + 2*extWall)/len(strings[0]);
  yTrans = (intY + 2*extWall)/len(strings);
  textHeight = textSize/100 * yTrans;

  rotate([0, 0, 90 * rot])
  translate([(-xTrans*(len(strings[0])-1))/2, (yTrans*(len(strings)-1))/2, 0]){
    for (i = [0:len(strings)-1]) {
      for (j = [0:len(strings[i])-1]) {
        translate([xTrans*(j), yTrans*(-i), 0])
          linear_extrude(height = extWall) {
            text(strings[i][j], halign = "center", valign = "center", size = textHeight);
          }
      }
    }
  }
}
deboss(strings = strings);
