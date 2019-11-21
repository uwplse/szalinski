use<write/Write.scad>

//radius of star   
radius=32; //[25:52]
//thickness of backing
thickness=4;
//text size 
textSize=8;//[5:11]
//text embossing height (raised above backing)
textHeight=1;//[.3:Small,1:Normal,2.5:High]
//Text to center on badge - 64 character limit!
labelText="Sheriff";


//draw triangle, add points
module drawTriangle(rad,thick) {
  //radius of star without rounded points - ignore this
  rad=rad/1.15;
  union() {
    cylinder(r=rad,thick,center=true, $fn=3);
    translate([rad,0,0])cylinder(r=rad*.15, thick, center=true, $fn=24);
    translate([-rad*sin(30),rad*cos(30),0])cylinder(r=rad*.15,thick,center=true, $fn=24);
    translate([-rad*sin(30),-rad*cos(30),0])cylinder(r=rad*.15,thick,center=true, $fn=24);
  }
}


module drawStar(rad,thick){
  //tip length - ignore this!
  tlen=((2*(rad*(cos(30))))/3)/2;
  //draw the two halves of the star, make a cutout for a pin
  difference(){
    union() {
        drawTriangle(rad,thick);
        rotate([0,0,180]) drawTriangle(rad,thick);
    }
    translate([0,tlen,-2*thick+2.5])cube([tlen*2,2.5,thick*3],center=true);
  }
}



//join the text to the star
union(){
  color("blue")rotate([0,0,0])translate([0,0,thickness/2])drawStar(radius,thickness);
  color("red")translate([0,0,.5*textHeight+thickness])write(labelText,t=textHeight+1,h=textSize,center=true);
//  color("red")translate([0,(-textSize/2)-textSize*.6,thickness-1])label(labelText, size=textSize, height=textHeight+1);
}
