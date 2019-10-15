//Set resolution - best to leave at 200
$fn = 200; 

//Radius of pad (long)
l = 5.5; 

//Radius of pad (short)
w = 3.5; 

//Thickness of pad
t = 1.5; 

//Pin length
pl = 4; 

//Pin width
pw = 1.5; 

//Pin height
ph = 3; 

//Pin rotation (degrees)
pr = 10;

//Add oval module
module oval(w,h, height, center = false) { 
  scale([1, h/w, 1]) cylinder(h=height, r=w, center=center);
}



oval(l,w,t);
rotate([0,0,pr])
translate([-pl/2,-pw/2,0])
cube([pl,pw,ph+t]);