/////////////////////////////////////////////////////////////
// Variables

// Thickness of Bracket
bracketHeight = 3;

// Space between servo stoppers
servoBraceSpace = 5.2;

// Hole for Servo Diameter
servoHoleDiameter = 7.3;

// Center of Servo Hole distance from far edge of bracket
servoHoleXLoc = 40;

// Length of Bracket
bracketLength = 51;

/* [Hidden] */
bracketLength = 51;
bracketWidth = 24;

servoBraceLength = 15;
servoBraceWidth = 5;

//Bracket

rotate ([180,0,0])
{
difference()
{
    linear_extrude(height=bracketHeight)
    {
        rounded_square([bracketLength,bracketWidth], corners=[2,12,2,12]);
    }
    
    translate ([4,4,-.01]) screwHole();
    translate ([4,12,-.01]) screwHole();
    translate ([4,20,-.01]) screwHole();
    translate ([servoHoleXLoc,bracketWidth/2,-.01]) servoHole();
}

//LeftBrace
translate ([servoHoleXLoc-servoBraceLength-(servoHoleDiameter/2),(bracketWidth/2)-(servoBraceSpace/2)-servoBraceWidth,0]) servoBrace();

//RightBrace
translate ([servoHoleXLoc-servoBraceLength-(servoHoleDiameter/2),(bracketWidth/2)+(servoBraceSpace/2),0]) servoBrace();

}
//////////////////////////////////////////////////////////////
// Modules
module servoBrace()
{
translate ([0,5,-4]) 
rotate ([0,270,180])
    linear_extrude(height = servoBraceLength)
    {
    rounded_square([7,servoBraceWidth], corners=[2,0,2,0]);
    }
}
module servoHole()
{
    cylinder(d=servoHoleDiameter, h=bracketHeight+.1, $fn=40);
}
module screwHole()
{
    cylinder(r=2, h= bracketHeight+.1, $fn=40);
}


module rounded_square(dim, corners=[10,10,10,10], center=false){
  w=dim[0];
  h=dim[1];

  if (center){
    translate([-w/2, -h/2])
    rounded_square_(dim, corners=corners);
  }else{
    rounded_square_(dim, corners=corners);
  }
}

module rounded_square_(dim, corners, center=false){
  w=dim[0];
  h=dim[1];
  render(){
    difference(){
      square([w,h]);

      if (corners[0])
        square([corners[0], corners[0]]);

      if (corners[1])
        translate([w-corners[1],0])
        square([corners[1], corners[1]]);

      if (corners[2])
        translate([0,h-corners[2]])
        square([corners[2], corners[2]]);

      if (corners[3])
        translate([w-corners[3], h-corners[3]])
        square([corners[3], corners[3]]);
    }

    if (corners[0])
      translate([corners[0], corners[0]])
      intersection(){
        circle(r=corners[0]);
        translate([-corners[0], -corners[0]])
        square([corners[0], corners[0]]);
      }

    if (corners[1])
      translate([w-corners[1], corners[1]])
      intersection(){
        circle(r=corners[1]);
        translate([0, -corners[1]])
        square([corners[1], corners[1]]);
      }

    if (corners[2])
      translate([corners[2], h-corners[2]])
      intersection(){
        circle(r=corners[2]);
        translate([-corners[2], 0])
        square([corners[2], corners[2]]);
      }

    if (corners[3])
      translate([w-corners[3], h-corners[3]])
      intersection(){
        circle(r=corners[3]);
        square([corners[3], corners[3]]);
      }
  }
}