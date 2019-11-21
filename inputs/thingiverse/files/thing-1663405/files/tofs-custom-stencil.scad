line1="MAKE";
line2="IT";
line3="YOURS!";
border=12;

difference() {
    $fn=32;
    minkowski() {
        union(){
            cube([max(len(line1),len(line2),len(line3))*7+border,15,0.75], center=true);
            if(line2||line3) {
                translate([0,-15,0]) cube([max(len(line1),len(line2),len(line3))*7+border,15,0.75], center=true);
            }
            if(line3) {
                translate([0,-30,0]) cube([max(len(line1),len(line2),len(line3))*7+border,15,0.75], center=true);
            }
        }
        cylinder(r=3,h=1);
    }
    
    union() {
            linear_extrude(height = 3, center=true) text(line1, font = "Allerta Stencil", "center", size = 10, valign="center", halign="center");
        if(line2) {
            translate([0,-15,0]) linear_extrude(height = 3, center=true) text(line2, font = "Allerta Stencil", "center", size = 10, valign="center", halign="center");
        }
        if(line3) {
            translate([0,-30,0]) linear_extrude(height = 3, center=true) text(line3, font = "Allerta Stencil", "center", size = 10, valign="center", halign="center");
        }
    }
}