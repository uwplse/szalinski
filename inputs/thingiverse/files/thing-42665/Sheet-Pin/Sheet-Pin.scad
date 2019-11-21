
//Part
part = "both"; // [pin,snapring,both,cutter]

//Axle diameter
daxle = 5;

//Thickness of material to hold together
tsheet = 4;

//Head Diameter   -- make relative
dhead = 8;

//Thickness of head 
thead = 2;


// How many handles shall the snap ring have? recomm:(1,3)
handle = 1; // [0,1,2,3,4]

//Depth of groove for snap ring
ddgroove =1;

//Snap ring thickness
tsnap = 1.75;

//Snap ring radial thickness (must be greater than groovedepth)
ddsnapring = 2.5;

//overstand on snap ring side
tover = 1.5;

// radial cutter clearance
tclear = 0.1;

// clearing
clr = 0.1;




/*
2013 Lukas Süss
A pin & clamping ring combo to clamp thin plates together.
e.g. usable as connectors for scissor mechanisms.
*/


$fa= 5;
$fs=0.2;



if(part == "pin"){ pin(); }
if(part == "snapring"){ snapring(); }
if(part == "both")
{ 
  pin();
  translate([-dhead*0.6,0,0]) snapring();
}
if(part == "cutter"){ cutter(); }



module pin(t=0)
{
  tges = thead+tsheet+tsnap+tover; 
  cutrat = 1/sqrt(2); // 1/sqrt(2) | cos(30)
  din = daxle-ddgroove;

  translate([0,0,((daxle)*cutrat+2*t)/2])
  difference()
  {
    intersection()
    {
      rotate(90,[0,1,0])
      union()
      {
        cylinder(r=daxle/2+t,h=tges);
        cylinder(r=dhead/2+t,h=thead);
      }
      cube([tges*3,20,(daxle)*cutrat+2*t],center=true);
    }
    rotate(90,[0,1,0]) translate([0,0,thead+tsheet])
    {
      difference()
      {
        cylinder(r=daxle/2*1.2+t,h=tsnap+clr);
        translate([0,0,-tsnap*0.1])
        cylinder(r=(daxle-ddgroove)/2+t,h=tsnap*1.2);
      }
      // rotation retention spike
      translate([-din/2-clr,0,]) cylinder(r=daxle/2*0.5,h=tsnap+clr,$fn=4);
    }

  }
}

module snapring()
{
  dout = daxle-ddgroove+ddsnapring;
  din = daxle-ddgroove;
  dhandle = 2.5;
  shift = dhandle*1.5;

  difference()
  {
    union()  // base body
    {
      cylinder(r=dout/2,h=tsnap);
      if (handle > 0)
      {
        for(i=[-(handle-1)/2:+(handle-1)/2])
        {
          rotate(90*i,[0,0,1])
          {
            translate([-shift/2 -din/2,0,tsnap/2])
            cube([shift,ddsnapring,tsnap],center=true);
 
            translate([-shift -din/2,0,0])
            cylinder(r=(dhandle+ddsnapring)/2,h=tsnap);
          }
        }
      } 

    }

    translate([0,0,-tsnap*0.1]) // main cemntral cuts
    {
      cylinder(r=din/2,h=tsnap*1.2);
      rotate(-45,[0,0,1])
      cube([dout*0.6,dout*0.6,tsnap*1.2]);
    }

    if (handle > 0) // handle hole cutting
    {
      for(i=[-(handle-1)/2:+(handle-1)/2])
      {
        rotate(90*i,[0,0,1])
        {
          translate([-shift -din/2,0,-tsnap*0.1])
          cylinder(r=dhandle/2,h=tsnap*1.2);
        }
      }
    }

  }
  //rotation retention spike
  translate([-din/2-clr,0,0]) cylinder(r=daxle/2*0.5,h=tsnap,$fn=4);
}

module cutter(clearance)
{
  pin(t=clearance);
}