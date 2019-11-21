//By Coat, 26-aug-2018
//Licensed under the Creative Commons - Attribution license.
//Cover cap for unwanted holes in cabinets, bookshelfs etc.
//cleaned up secondary parameters a little at 28-aug-2018, same functionality
//Update 29-aug-2018: plug got loose of the cap with higher diameters (> 30 mm) problem solved 


//Primary parameters
//Diameter of the plug or hole
diamplug = 8;
//Length of the plug (little less then the depth of the hole)
lengthplug = 8;
//Diameter of the cap
diamcap = 12;
//Thickness of the cap
capthick = 1;
//Do you want a round (1) or a square cap (0)
roundsquare = 1;

//The Parts
//****************************************
module cap(rr, dd)
{
  $fn=rr;
  difference()                 //cone minus cylinder gives the cap with chamfer 
  {                            //dd (diamcap) is also the height of the cone
    cylinder(h=dd, d1=dd, d2=0);   
    translate([0, 0, capthick])
      cylinder (h=dd, d=dd);
  }
}

//****************************************
module plug()
{
  //secondary parameters
  $fn = 32;
  hp = lengthplug/2;      //height of the two main parts body
  np = 0.95*diamplug;     //narrowest contour
  wp = min(1.04*diamplug, diamplug + 1); //widest contour, larger factor > tighter fit, limited to +1mm
  wwp = 0.8;              //width wall plug
  wg = 0.35*diamplug;      //width of grooves in plug, smaller > harder to get in/out
  hg = 2*hp*0.85;         //height grooves
  
  difference()
  {
    //body
    union()
    {  
      translate([0, 0, -hp]) 
        cylinder(h=hp, d1=wp, d2=np);
      translate([0, 0, -2*hp]) 
        cylinder(h=hp, d1=np, d2=wp);
    }
    //centerhole
    translate([0, 0, -3*hp])    //3 iso 2 is easier to see in openscad
      cylinder(h=3*hp, d=np-wwp*2);    
    //grooves
    translate([-0.5*wg, -diamplug, -hg])
      cube([wg, diamplug*2, hg]);
    translate([-diamplug, -0.5*wg, -hg])
      cube([diamplug*2, wg, hg]);
  }
}
//****************************************

//Main, the thing
rotate([0, 180, 45])
  union()
  {
    if (roundsquare) cap(64, diamcap); else cap(4, diamcap*sqrt(2));
    plug();
  }

