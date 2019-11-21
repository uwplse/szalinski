

/*
Author: Lukas Süss aka mechadense
Title: Tractrix Horn Generator
License: CC-BY

Description:

This is a generator for horns with tractrix crossection.  
Those are not the same as spherical wave horns! see here:  
https://www.grc.com/acoustics/an-introduction-to-horn-theory.pdf  

Horns act as acoustic impedance matching transformators  
transformating high pressure low speed to low pressure high speed sound waves ore vice versa.  

Note that the sizes that are printable on common personal 3D printers  are only suitable for rather high frequencies (even for whistles).  

Example horn:  
cutoff frequency: 4500Hz  
inlet inner diameter: 20mm  
inlet outer diameter: 24mm  
inlet pipe length: 5mm  
horn length cropped to: 80%   
cropped horn mouth diameter: 126.5mm  
complete horn length: 129.9mm  
tractrix segment length: 124.9mm

--------------

maybe todo:
  add spherical wave horn alternative
  add exponential horn alternative
  look at alternative generation method (e.g. rotate extrude)
  refactor file for usage as library
*/


// set false for better phintbed-adhesion but worse inner surface
flip = true;

// resolution minimal angle per edge
$fa = 5;
// resolution: minimal length per edge
$fs = 0.2;

// lower cutoff frequency in Hz
fc = 4500;
// speed of sound
c_sound = 340;

//lower cutoff wavelength
lambda_c = c_sound/fc;
// horn mouth radius
rm = lambda_c*1000; 
//echo("Horn mouth diameter is: ",2*rm);

// inlet radius
r0 = 10;
// resolution: number of resolution steps
n = 32;

// radial stepsize
dr = (rm-r0)/n;

// tactric generation functions
function helper(rm,r) = sqrt(pow(rm,2)-pow(r,2));
function axial(rm,r) = rm*ln((rm+helper(rm,r))/r)-helper(rm,r);
//echo("z0:",axial(rm,rm)); // check for 0

// keep as close to 1 as possible (cripples horn)
crop_factor = 0.80;
nstart = round(n*(1-crop_factor));
//echo("nastart:",nstart);

echo("cropped horn: mouth diameter is: ",2*(rm-dr*nstart));
// size estimation cube
//cube([10,10,10],center=true);

// approximate wall thickness
twall = 1.5;

// inlet pipe thickness (>twall)
tinlet = 2;
// length of inlet pipe
hinlet = 5;

//renerding help (lim->0)
eps = 0.05;

htractrix = axial(rm,rm-dr*(n+0))-axial(rm,rm-dr*nstart);


if(flip)
{
  translate([0,0,htractrix+hinlet]) scale([1,1,-1])
  tractrixhorn();
} else
{
  tractrixhorn();
}


module tractrixhorn()
{
  difference()
  {
    union()
    {
      translate([0,0,0])
      {
        // mouth endcap
        cylinder(r=(rm-dr*nstart)+twall,h=twall);
        // inlet tube
        color("red")
          cylinder(r=r0+tinlet,h=htractrix+hinlet);
      }
      translate([0,0,-axial(rm,rm-dr*nstart)])
      difference()
      {
        // outer tractrix shell is shifted upwards (and outwards)  
        translate([0,0,twall]) tractrixhorn_shape(twall); // <<<<<<<<<

        // cutoff excess length
        // note that due to the outer shell up-shift
        // the end radius is a bit bigger than r0+twall
        translate([0,0,(twall+hinlet+2)/2+axial(rm,rm-dr*(n))-eps])
        cube([(r0+twall)*2+2,(r0+twall)*2+2,twall+hinlet+2],center=true);
        //cube([(r0)*2,(r0)*2,twall*2],center=true);
      }
    }
    translate([0,0,-axial(rm,rm-dr*nstart)])
    translate([0,0,-0.05]) tractrixhorn_shape(); // <<<<<<<<<<<<

    translate([16*0,0,htractrix-1]) cylinder(r=r0,h=hinlet+2);

  }
  echo("complete horn length is: ",htractrix+hinlet);
  echo("tractrix segment length is: ",htractrix);
  
}


module tractrixhorn_shape(r_add=0)
{
  for(i=[nstart:n-1])
  {
    //echo(axial(rm,rm-dr*i));
    translate([0,0,axial(rm,rm-dr*i)])
    cylinder(r1=rm-dr*i+r_add,r2=rm-dr*(i+1)+r_add,h=axial(rm,rm-dr*(i+1))-axial(rm,rm-dr*i)+eps);
  }
}

