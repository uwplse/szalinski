$fn=50;
width=12;
length=120;
height=2.4;

cylinder (d=width,h=height);
translate ([0,-width/2,0])
cube([length-width,width, height]);
translate ([length-width,0,0])
cylinder (d=width, h=height);