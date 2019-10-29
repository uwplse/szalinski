//--Parameters
//--Diameter of the antenna base
diameter = 15;//[10:50]
//--Thickness of the front and back piece
thickness1 = 10;//[10:50]
//--Thickness of the middle piece
thickness = 17;//[10:50]
translate([50,25,-(thickness/2 - thickness1/2)])
rotate([0,0,0])
difference(){
  cube([40,40,thickness1],center=true);
//--We make the moulding where antenna fits
//--Note the way we translate. The antenna holder must be placed in this piece with an offset for allow a strong attachment when we'll screw the 3 pieces.
  translate([0,0,(thickness1/2)+(diameter/(diameter-7))])
  rotate([90,0,0])
  cylinder(r=diameter/2, h=50,$fn=50,center=true);
//--We make the M5 holes
//--Note that the holes are automatically positioned depending of the diameter of your antenna for ensuring a good adjustment and preventing overlap 
  translate([(20-(diameter/2))/2+(diameter/2),(20-(diameter/2))/2+(diameter/2),0])
  cylinder(r=2.5, h=40,$fn=50,center=true);
  translate([-((20-(diameter/2))/2+(diameter/2)),-((20-(diameter/2))/2+(diameter/2)),0])
  cylinder(r=2.5, h=40,$fn=50,center=true);
  translate([((20-(diameter/2))/2+(diameter/2)),-((20-(diameter/2))/2+(diameter/2)),0])
  cylinder(r=2.5, h=40,$fn=50,center=true);
  translate([-((20-(diameter/2))/2+(diameter/2)),((20-(diameter/2))/2+(diameter/2)),0])
  cylinder(r=2.5, h=40,$fn=50,center=true);
}

difference(){
  cube([40,40,thickness],center=true);
//--We make the moulding where antenna fits
  translate([0,0,thickness/2])
  rotate([90,0,0])
  cylinder(r=diameter/2, h=50,$fn=50,center=true);
//--We make the moulding where it is attached to the Turnigy 9x.
  rotate([0,90,0])
  translate([thickness/2,0,0])
  cylinder(r=2, h=50,$fn=50,center=true);
//--We make the M5 holes
//--Note that the holes are automatically positioned depending of the diameter of your antenna for ensuring a good adjustment and preventing overlap 
  translate([(20-(diameter/2))/2+(diameter/2),(20-(diameter/2))/2+(diameter/2),0])
  cylinder(r=2.5, h=40,$fn=50,center=true);
  translate([-((20-(diameter/2))/2+(diameter/2)),-((20-(diameter/2))/2+(diameter/2)),0])
  cylinder(r=2.5, h=40,$fn=50,center=true);
  translate([((20-(diameter/2))/2+(diameter/2)),-((20-(diameter/2))/2+(diameter/2)),0])
  cylinder(r=2.5, h=40,$fn=50,center=true);
  translate([-((20-(diameter/2))/2+(diameter/2)),((20-(diameter/2))/2+(diameter/2)),0])
  cylinder(r=2.5, h=40,$fn=50,center=true);
}

translate([0,50,-(thickness/2 - thickness1/2)])
rotate([180,0,0])
translate([])
difference(){
  cube([40,40,thickness1],center=true);
//--We make the moulding where it is attached to the Turnigy 9x.
  rotate([0,90,0])
//--Note the way we translate. The turnigy 9x holder must be placed in this piece with an offset for allow a strong attachment when we'll screw the 3 pieces.
  translate([(thickness1/2)+0.3,0,0])
  cylinder(r=2, h=50,$fn=50,center=true);
//--We make the M5 holes
//--Note that the holes are automatically positioned depending of the diameter of your antenna for ensuring a good adjustment and preventing overlap 
  translate([(20-(diameter/2))/2+(diameter/2),(20-(diameter/2))/2+(diameter/2),0])
  cylinder(r=2.5, h=40,$fn=50,center=true);
  translate([-((20-(diameter/2))/2+(diameter/2)),-((20-(diameter/2))/2+(diameter/2)),0])
  cylinder(r=2.5, h=40,$fn=50,center=true);
  translate([((20-(diameter/2))/2+(diameter/2)),-((20-(diameter/2))/2+(diameter/2)),0])
  cylinder(r=2.5, h=40,$fn=50,center=true);
  translate([-((20-(diameter/2))/2+(diameter/2)),((20-(diameter/2))/2+(diameter/2)),0])
  cylinder(r=2.5, h=40,$fn=50,center=true);
}