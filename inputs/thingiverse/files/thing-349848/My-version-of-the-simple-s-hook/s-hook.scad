hook_1_diameter = 32 ; // [10:100]
hook_2_diameter = 20 ; // [10:100]
bar_diameter = 5 ;     // [3:12]

$fn = 20 ;	      //  [20:120]

SHook(hook_1_diameter / 2, hook_2_diameter / 2, bar_diameter) ;

module SHook(r1, r2, thick) {
    three_quarter_circle(r1, thick) ;

    translate([(r1 + r2 + thick) *  -sin(45), (r1 + r2 + thick) * sin(45), thick])
    rotate([180, 0, -45])
    three_quarter_circle(r2, thick) ;
}

module three_quarter_circle(radius, thick) {
    difference() {
        translate([0, 0, thick/2])
        rotate_extrude()
        translate([radius + thick/2, 0, 0])
        circle(r=thick/2) ;

        translate([0, 0, -1])
        cube([radius + thick + 1, radius + thick + 1, thick + 2]) ;

        rotate([0, 0, 45])
        translate([0, 0, -1])
        cube([radius + thick + 1, radius + thick + 1, thick + 2]) ;
    }
}