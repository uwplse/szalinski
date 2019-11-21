//Horizontal amount of bars
hori_bars = 1; // [1:1:20]

//Vertical amount of bars
vert_bars = 1; // [1:1:30]

//End of customizer variables

//Box
//15 long
//24 wide / 5 bars
//7.5 hight / 4 bars

//Bar
//4cm wide
//11.3 long
//1.7 high

//Average
//13.15 long
//4.4 wide
//1.8 high

h=18;
b=44;
l=131.5;

module multiBar(x, y){
  difference(){
    translate([2,-2,-2]){
      cube([l+2, x*(b+2)+2, y*(h+2)+2]);
    }
    for( i=[0:x-1]){
      for( j=[0:y-1]){
        translate([0,i*(b+2),j*(h+2)]){
          cube([l, b, h]);
        }
      }
    }
  }
}

multiBar(hori_bars, vert_bars);

