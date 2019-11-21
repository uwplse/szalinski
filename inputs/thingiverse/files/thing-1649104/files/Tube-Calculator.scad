/*[Standard Hole Pattern]*/
// Length of tube:
Length = 12;
//Width of tube:
Width = 2;
//Height of tube:
Height = 2;
/*[Advanced]*/
//Wall thickness:
Wall_Thickness = .125;
//Hole Diameter:
Hole_Size = .201;
//Distance between holes on Y axis
Hole_Spacing_On_Y_Axis = 0.5;
//Distance between holes on X Axis
Hole_Spacing_On_X_Axis = 0.5;

/*[hidden]*/
holes = 0;
nx = Length;
ny = Width-Wall_Thickness;
nz = Height - Wall_Thickness;
$fn = 100;


module tube() {
    difference() {
        scale([25.4, 25.4, 25.4]) cube([Length, Width, Height], center = true);
        scale([25.4, 25.4, 25.4]) cube ([nx, ny, nz], center = true);
    }
}
module tubewithtop() {
if (Width == 1) {
     difference() {
     tube();
       for (holes =[0:Hole_Spacing_On_X_Axis:(Length/2-Hole_Spacing_On_X_Axis)]) {
           scale([25.4, 25.4, 25.4]) translate ([holes,0 , 0])
               cylinder(d = Hole_Size, h = Height, center = true);
           scale([25.4, 25.4, 25.4]) translate ([- holes,0 , 0])
               cylinder(d = Hole_Size, h = Height, center = true);
     }
}
}
else if (Width == 2) {
    difference() {
        tube();
            for (holes = [0:Hole_Spacing_On_X_Axis:(Length/2-Hole_Spacing_On_X_Axis)]) {
        scale([25.4, 25.4, 25.4]) translate([holes, Hole_Spacing_On_X_Axis, 0])
            cylinder(d = Hole_Size, h = Height, center = true);
        scale([25.4, 25.4, 25.4]) translate([- holes, - Hole_Spacing_On_X_Axis, 0])
             cylinder(d = Hole_Size, h = Height, center = true);
        scale([25.4, 25.4, 25.4]) translate([holes, - Hole_Spacing_On_X_Axis, 0])
             cylinder(d = Hole_Size, h = Height, center = true);
        scale([25.4, 25.4, 25.4]) translate([- holes, Hole_Spacing_On_X_Axis, 0])
             cylinder(d = Hole_Size, h = Height, center = true);
    }
        scale([25.4, 25.4, 25.4]) translate([Length/2-Hole_Spacing_On_X_Axis, 0, 0])
            cylinder(d = Hole_Size, h = Height, center = true);
        scale([25.4, 25.4, 25.4]) translate([-Length/2+Hole_Spacing_On_X_Axis, 0, 0])
            cylinder(d = Hole_Size, h = Height, center = true);
}
}
}

if (Height == 1) {
    difference() {
       tubewithtop();
        for (holes =[0:Hole_Spacing_On_Y_Axis:(Length/2-Hole_Spacing_On_X_Axis)]) {
            scale([25.4, 25.4, 25.4]) rotate([90, 0, 0]) translate ([holes,0 , 0])
                cylinder(d = Hole_Size, h = Width, center = true);
             scale([25.4, 25.4, 25.4]) rotate([90, 0, 0]) translate ([-holes,0 , 0])
                cylinder(d = Hole_Size, h = Width, center = true);
        }
    }
}
else if (Height == 2) {
    difference() {
        tubewithtop();
            for (holes = [0:Hole_Spacing_On_Y_Axis:(Length/2-Hole_Spacing_On_Y_Axis)]) {
            scale([25.4, 25.4, 25.4]) rotate([90, 0, 0]) translate ([holes, Hole_Spacing_On_Y_Axis , 0])
                cylinder(d = Hole_Size, h = Width, center = true);  
            scale([25.4, 25.4, 25.4]) rotate([90, 0, 0]) translate ([-holes,Hole_Spacing_On_Y_Axis , 0])
                cylinder(d = Hole_Size, h = Width, center = true);
            scale([25.4, 25.4, 25.4]) rotate([90, 0, 0]) translate ([holes, -Hole_Spacing_On_Y_Axis , 0])
                cylinder(d = Hole_Size, h = Width, center = true);
            scale([25.4, 25.4, 25.4]) rotate([90, 0, 0]) translate ([-holes,-Hole_Spacing_On_Y_Axis , 0])
                cylinder(d = Hole_Size, h = Width, center = true);
            }
        scale([25.4, 25.4, 25.4]) rotate([90, 0, 0]) translate([Length/2-Hole_Spacing_On_Y_Axis, 0, 0])
            cylinder(d = Hole_Size, h = Width, center = true);
        scale([25.4, 25.4, 25.4])rotate([90, 0, 0])translate([-Length/2+Hole_Spacing_On_Y_Axis, 0, 0])
            cylinder(d = Hole_Size, h = Width, center = true);

}
}

        
