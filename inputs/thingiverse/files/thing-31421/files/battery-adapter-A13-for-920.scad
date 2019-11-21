
// diameter of the original (bigger) battery
dBig=11.5;

// height of the original (bigger) battery
hBig=5.2;

// diameter of the smaller battery that you have (hole in the big one)
dSmall=7.8;

// height of the smaller battery
hSmall=5.2;

// Tolerance on height, tune according to your result
hTol=1;

// Some tolerance on the diameters (else the fit may be a bit tight)
dTol=0.8;

// The small battery protrude a bit of the big diameter
holeShift= 0.4;

// Button/Cell battery adapter
// jeremie.francois@gmail.com / http://www.thingiverse.com/MoonCactus
// http://betterprinter.blogspot.fr/
// Licence: CC-BY-NC
//
// Print temp 212 (intead of ~234 usually!), cooling enabled
// 0.2 layer thickness, 0 top and bottom layer fill
// 0.8 wall tickness
// 0% fill
// 10s minimal time between layers
// 0.4 nozzle size
//


// No need to tweak this:
$fn=0+40;
tol=0+0.1;
dBigR= dBig - dTol;
dSmallR= dSmall - dTol;
hBigR= hBig - hTol;

difference()
{
  cylinder(r=dBigR/2, h=hBigR);
  translate([(dBigR-dSmallR)/2+holeShift,0,hBigR-hSmall-tol])
  hull()
  {
    cylinder(r=dSmallR/2, h=hSmall+2*tol);
    translate([10,0,0]) cylinder(r=dSmallR/2-2, h=hSmall+2*tol);
  }
}