//This will adjust the open gap where the clip fits onto the gutter.
Gutter_Wall_Thickness = 2.5;
//The thickness of the clip walls. Try to make this a multiple of your printer nozzle width.
Coupling_wall_thickness = 1.6;
//How long do you want the coupling to be?
couplingLength = 12.5;//[5:50]


couplingWidth = 3*Coupling_wall_thickness + 2*Gutter_Wall_Thickness;
gutter_Coupling_Height = 24-1;
couplingHeight = gutter_Coupling_Height+Coupling_wall_thickness;



difference(){
    difference(){
        cube([couplingWidth,couplingLength,couplingHeight]);
        translate([Coupling_wall_thickness,0,0])
            cube([Gutter_Wall_Thickness,couplingLength ,gutter_Coupling_Height]);
    }
    translate([2*Coupling_wall_thickness+Gutter_Wall_Thickness,0,Coupling_wall_thickness])
        cube([Gutter_Wall_Thickness,couplingLength ,gutter_Coupling_Height]);
}