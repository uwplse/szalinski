$fn=100*1;
// Dia = 20*1;
// Thk = 2.5*1;
tolerance=0.0; // [-0.3:0.05:0.3]

//Number of batterys
Batt_qty=1; //[1:6]

// wire width
busbar = 1.5;

// size (Type)
Battery = 2025; // [2012:CR2012,2016:CR2016,2025:CR2025,2032:CR2032,2320:CR2320,2325:CR2325,2330:CR2330,2354:CR2354,2430:CR2430,2450:CR2450,2477:CR2477,3032:CR3032]


Dia=((Battery-Battery%100)/100);
Thk=((Battery%100)/10);

MDia=Dia+3+2*tolerance;
BThk=Batt_qty*(Thk+tolerance);

rotate([-90,0,0])holder();

module holder(){
difference(){
    intersection(){
        translate([0,0.17*MDia,0])cube([MDia,0.64*MDia,4*BThk],center=true);
        union(){
            translate([0,0,BThk])cylinder(r=Dia/2+1.5+tolerance,h=1.5);
            translate([0,0,-1.5])cylinder(r=Dia/2+1.5+tolerance,h=1.5);
            rotate([0,0,-10])rotate_extrude(angle = 200, convexity = 2)
            translate([Dia/2+tolerance,0,0])
            square([1.5,BThk]);

        }
    }
    union(){
        translate([0,0.15*MDia,0])cube([busbar+0.5,1,15],center=true);
        translate([0,0.33*MDia,-1.3])cube([busbar+0.5,0.36*MDia,0.5],center=true);
        translate([0,0.33*MDia,BThk+1.3])cube([busbar+0.52,0.36*MDia,0.5],center=true);
        translate([6,0,BThk/2])cube([5,MDia,BThk],center=true);
        translate([-6,0,BThk/2])cube([5,MDia,BThk],center=true);
    }
}
translate([0,-0.7,-2])linear_extrude(height = 0.5)text("+",size=7,halign="center",valign="center");
rotate([0,0,180])translate([0,0,BThk+1.5])linear_extrude(height = 0.5)text(text=str("CR",Battery),size=4,halign="center",valign="center",font = "Arial:style=Bold" );
}
