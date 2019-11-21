adapterWidth = 10.0;//mm
spacerDiameter = 5.0;
spacerHeight = 3.2;
thickness = 3.0;

spaceBetween = 1.0;//spaceBetween objects

screwDiameter = 2.87 + 0.1;//fudge
slotDiameter = 4.0;


$fn = 50;

maxDistance = 23.0;
minDistance = 5.0;


module createBracket(minDistanceIN, maxDistanceIN, spacerHeightIN)
{
  difference()
  {

  union()
  {
    //create main body
    hull()
    {
    cylinder(d=adapterWidth,h=thickness,center=true);
    translate([0,maxDistanceIN,0]) cylinder(d=adapterWidth,h=thickness,center=true);
    }
    //add spacer support
    translate([0,maxDistanceIN,thickness]) cylinder(d1=spacerDiameter*1.5,d2=spacerDiameter,h=spacerHeightIN,center=true);
  }
  //remove hole for spacer screw
  translate([0,maxDistanceIN,0]) cylinder(d=screwDiameter,h=(thickness+spacerHeightIN)*3.0,center=true);

  slotLength = maxDistanceIN - minDistanceIN;
  //create slot
  hull()
  {
  cylinder(d=slotDiameter,h=thickness*3.0,center=true);
  translate([0,slotLength,0])cylinder(d=slotDiameter,h=thickness*3.0,center=true);
  }
  }
}

createBracket(14.5,15.5,0);
translate([adapterWidth+spaceBetween,0,0]) 
  createBracket(29.5,30.5,spacerHeight);//30
translate([2*(adapterWidth+spaceBetween),0,0]) 
  createBracket(23,23,spacerHeight);//23



