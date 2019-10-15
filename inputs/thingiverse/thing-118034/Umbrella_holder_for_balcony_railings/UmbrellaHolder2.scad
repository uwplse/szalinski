
// 2013 Lukas Süss aka mechadense
// License CC-BY-NC
// Umbrella holder





// Diameter of the umbrellas tube (+0.5mm)
dtube = 38.5;
//38;
rtube = dtube/2;

// Width of the bands used to fixate the holder onto one of the rectangular bars
wband = 20;

// hight of the rectangulat bar on which to mount the holder
sbar0 = 50;

// thickness of hook
shook = 4;

// depth of hook
dhook = 8;

sbar = sbar0+shook;
//50.5

//----

// baseplate thickness
tplate = 3.0;

// tubeholder thickness 
ttubewall = 3.0; // wall thickness of the pipe segment


// width of gap to adjust for tube diameter variations
adjustgap = 4;

// thickness of adjustment brackets
tadjust = 5;
// size of brackets
sadjust = 16;

// width of outer band guides
wrim = 3;

// hight of outer band guides
hrim = 3;


// resolution: minimum facet length
$fs=0.4;
// resolution: maximal facet angle
$fa=5;

// baseplate groovedepth for soft material
tinset = 2;

// total length of part
lges = dtube+2*ttubewall+2*wband+2*wrim;

// screw diameter
dscrew = 6;

// screw clearance
scrclr = 0.2;

// nut or screwhead wrench size
s = 10.1;



difference()
{
  union()
  {
    //Baseplate
    translate([tplate/2-tinset/2,0,0*sbar/2])
    cube([tplate+tinset,lges,sbar],center=true);
 
    //Tubeholder Basebody
    translate([(rtube+ttubewall),0,0])
      cylinder(r1=rtube+ttubewall,r2=rtube+ttubewall-0,h=sbar,center=true);

    // inner band guides and structural integrity
    translate([(rtube+ttubewall)/2,0,0])
    {
      translate([0,-tplate/2+(rtube+ttubewall),0])
        cube([(rtube+ttubewall),tplate,sbar],center=true);
      translate([0,-(-tplate/2+(rtube+ttubewall)),0])
        cube([(rtube+ttubewall),tplate,sbar],center=true);
    }
    // outer band guides
    translate([(tplate+hrim)/2,0,0])
    {
      translate([0,+(lges/2-wrim/2),0])
        cube([tplate+hrim,wrim,sbar],center=true);
      translate([0,-(lges/2-wrim/2),0])
        cube([tplate+hrim,wrim,sbar],center=true);
    }

    // base body for clamping bracket
    hull()
    {
      translate([(dtube+2*ttubewall)/2,0,0])
        cube([dtube+2*ttubewall,tadjust*2+adjustgap,3*sadjust],center=true);
      translate([(dtube+2*ttubewall+sadjust)/2,0,0])
        cube([dtube+2*ttubewall+sadjust,tadjust*2+adjustgap,sadjust],center=true);
    }
    hull()
    {
      translate([-dhook/2-tinset,0,-sbar/2+shook/2])
      cube([dhook,lges-2*dhook,shook],center=true);

      translate([-1/2-tinset,0,-sbar/2+shook/2])
      cube([1,lges,shook],center=true);
    }
  }

  //Tube holder cut
  translate([(rtube+ttubewall),0,0])
    cylinder(r=rtube,h=sbar*1.2,center=true);

  // adjustment gap cutter
  translate([dtube*1.5,0,0])
    cube([dtube,adjustgap,sbar*1.2],center=true);

  // inset cutter
  translate([0,0,shook/2])
  hull()
  {
    translate([-(tinset+1)/2,0,0])
    cube([tinset+1,lges-2*wrim,sbar0-2*wrim-2*tinset],center=true);

    translate([-1/2-tinset,0,0])
    cube([1,lges-2*wrim,sbar0-2*wrim],center=true);
  }

  // clamp screwhole
  // asserted: clampthickness < smaller tubeholder
  translate([dtube+2*ttubewall+sadjust/2,0,0]) rotate(90,[1,0,0])
    cylinder(r=dscrew/2+scrclr/2,h=dtube,center=true);
  // add hex inset for nut!
  translate([dtube+2*ttubewall+sadjust/2,adjustgap/2+tadjust-2,0]) // <<<<< 
    rotate(30,[0,1,0]) rotate(-90,[1,0,0])
    cylinder(r=s/2/cos(30)+scrclr/2,h=dtube,$fn=6,center=false);

 
  //several material saving cuts
  /*
  translate([0,+rtube*0.61803,0]) cuts1();
  translate([0,-rtube*0.61803,0]) cuts1();
  */
  translate([+rtube,0,+sbar/2]) rotate(90,[0,1,0])
    cylinder(r=10,h=dtube*1.5,$fn=4);
  //translate([+rtube,0,-sbar/2]) rotate(90,[0,1,0])
  //  cylinder(r=10,h=dtube*1.5,$fn=4);

  //translate([0,lges/2+1,0]) cuts2(20);
  //translate([0,-(lges/2+1),0]) cuts2(20);
}

module cuts1()
{
  translate([0,0,-0.05])
    cylinder(r1=sbar/8*1.6,r2=0,h=sbar/4*1.4,$fn=4);
    translate([0,0,+0.05]) scale([1,1,-1])
    cylinder(r1=sbar/8*1.6,r2=0,h=sbar/4*1.4,$fn=4);

}

module cuts2(s)
{
  hull()
  {
    cube([20,2,sbar*0.75],center=true);
    cube([20,2+s,sbar*0.75-1.5*s],center=true);
  }
}
