/* [PEGS] */
numberPegs = 2; //[0, 1, 2, 3, 4]

// Container is exactly: 2.0" x 2.75"

difference()
{
 ring();
 holes();
}

if (numberPegs > 3)
{ 
    translate([20, 10, 0]) peg();
}
if (numberPegs > 2)
{ 
    translate([20, -10, 0]) peg();
}
if (numberPegs > 1)
{ 
    translate([-20, 10, 0]) peg();
}
if (numberPegs > 0)
{ 
    translate([-20, -10, 0]) peg();
}


module baseCylinder()
{
    cylinder(d=mm(2), h=20, center=true, $fn=50);
}

module container()
{
 translate([mm(.75/2),0,0]) baseCylinder();
 translate([-mm(.75/2),0,0]) baseCylinder();
 cube([mm(0.75), mm(2), 20], center=true);    
}

module ring()
{
intersection()
{
 difference()
 {
  cube([mm(3.5),mm(2.5),10], center=true);
  // slight upscale needed for tolerance. Increase for looser fit, decrease for tighter fit
  scale([1.01,1.01,1]) container();
 }
  // sets the thickness of the ring
  scale([1.2,1.2,1.1]) container(); 
}
}

module holes()
{
 rotate ([0,90,0]) hole();
 rotate ([90,0,0]) hole();  
}

module hole()
{
    cylinder(d=7, h=300, $fn=50, center=true);    
}

module peg()
{
  rotate([22.5,0,0]) rotate ([0,90,0]) cylinder(d=6.8, h=10, $fn=8, center=true);  
}


// converts x from inches to mm
function mm(x) = 25.4*x;