$fn=20;
height=13;
width=13;
length=100;
numholes=2;
holeradius=2;
countersinkradius=4;

difference() {
  translate([0,0,width]) rotate([270,0]) linear_extrude(height=length) polygon(points=[[0,0],[height,0],[height+width,width],[0,width],[0,0]]);    
  for(hole=[length/numholes/2:length/numholes:length-1]) {
      translate([height/2,hole,-1]) cylinder(r=holeradius,h=width+2);
  }
  for(hole=[length/numholes/2:length/numholes:length-1]) {
      translate([height/2,hole,-0.01]) cylinder(r1=countersinkradius,r2=0,h=width/4);
  }
}
