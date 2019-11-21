$fn = 200;
//Parameters
Large_End_Radius=53.625;
Large_End_Height=45;
Trans_Height=41;
Small_End_Radius=30.75;
Small_End_Height=35;
Wall_Thickness=2.4;

difference() {
    cylinder(h=Large_End_Height, r=Large_End_Radius, center=false);
    translate([0,0,-.1])cylinder(h=Large_End_Height+.2, r=Large_End_Radius-Wall_Thickness, center=false);
} 
difference() {
    translate([0,0,Large_End_Height])cylinder(h=Trans_Height, r1=Large_End_Radius, r2=Small_End_Radius, center=false);
    translate([0,0,Large_End_Height-.1])cylinder(h=Trans_Height+.2, r1=Large_End_Radius-Wall_Thickness, r2=Small_End_Radius-Wall_Thickness, center=false);
}
difference() {
    translate([0,0,Large_End_Height + Trans_Height])cylinder(h=Small_End_Height, r=Small_End_Radius, center=false);
    translate([0,0,Large_End_Height + Trans_Height-.1])cylinder(h=Small_End_Height+.2, r=Small_End_Radius-Wall_Thickness, center=false);
    
}
