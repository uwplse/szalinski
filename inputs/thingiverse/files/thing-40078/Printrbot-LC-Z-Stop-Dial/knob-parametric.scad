// knob for z axis

$fn=5*10;


//Total Dial Length mm
Length=65;

//Thickness of the dial head in mm
Dial=3;

// Knob add ons
add ="pointer"; //[none,pointer,knurled]

cylinder(h=Dial,r=10);

if (add=="knurled")
{
  for ( i = [0 : 10] )
  {
      translate([sin(i*36)*9,cos(i*36)*9, 0]) cylinder(h=Dial,r=3);
  }
}

if (add=="pointer")
{
    translate([-9,-9,0]) linear_extrude(height=Dial) polygon(points=[[0,0],[7,0],[0,7]], paths=[[0,1,2]]);
}

difference () {
cylinder(h=Length,r=4);
translate([0,0,Length-15]) cylinder(h=20,r=1.5);
}