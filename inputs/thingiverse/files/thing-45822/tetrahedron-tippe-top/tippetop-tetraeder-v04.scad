// radius of the balls
radius = 9.5;

// overlap between the balls  
overlap = 0.5;

//thickness of the bottom balls (multiples of nozzle diam)
shell = 0.8;

//thickness of the top ball
shelltop = 0.8;

//add support for top ball
str_support = "yes"; // [yes, no]

//split object in two halves for printing
str_twohalves = "no"; // [yes, no]

a = radius;
c = sqrt(3) * a;
hb = 1/sqrt(3) * a;
h = sqrt(2/3)*2*a;

module basesphere()
{
  difference(){
    sphere(radius, center=true, $fn=100);
    sphere(radius-shell, center=true, $fn=100);
  }
}

module topsphere()
{
  difference(){
    sphere(radius, center=true, $fn=100);
    sphere(radius-shelltop, center=true, $fn=100);
  }
}

module support()
{
  union() {
    translate([0,hb-overlap/2,-radius]) cylinder(h=h-1, r1=1, r2=0.4, $fn=20);
    translate([0,hb-overlap/2,h-overlap-radius-1.5]) cylinder(h=2, r=0.25);
  }
}

module allspheres()
{
  union(){
    translate([-(a-overlap),0,0])  basesphere();
    translate([a-overlap,0,0])  basesphere();
    translate([0,c-overlap,0])  basesphere();
    translate([0,hb-overlap/2,h-overlap])  topsphere();
  }
}

module tippetop()
{
  if (str_support == "yes") { 
    union(){
      allspheres();
      support();
    }
  } else {
    allspheres();
  }
}

module halve()
{
  rotate(a=-90, v=[0, 1, 0])
	intersection() {
   	 translate([0, -25, -25])
        cube(50, 50, 50);
  	tippetop();
}
}

if (str_twohalves == "yes")
{
	halve();
	translate([2*h, 0, 0]) mirror([1,0,0]) {halve();}
} else {
	tippetop();
}
