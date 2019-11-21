//simple wall mount hook with rounded tops

$fn=100;
// overall width of the hook mount
length=45;        
front_hook_height=50;
back_hook_height=200;
// thickness the walls of the hook and base
thickness=5;
// adjust to make the hook base larger or smaller; add double thickness for precision fits!
base_depth=54;        


// hook base
cube([base_depth,length,thickness]);

difference() {
    hull() {
    // top of back hook circle        
            rotate([0,90,0]) {
                translate([back_hook_height-(thickness/2),length/2,0]) cylinder(d=length,h=thickness);
            }
            
    // back of hook
            rotate([0,90,0]) {
                   cube([back_hook_height,length,thickness]);
            }
        }
    // screw holes        
            rotate([0,90,0]) {
                #translate([(length/2) + (back_hook_height*.75) + (thickness/2),length/2,-1*(thickness)]) cylinder(d=5,h=thickness*5);
            }
            rotate([0,90,0]) {
                #translate([(length/2) + (back_hook_height*.40) + (thickness/2),length/2,-1*(thickness)]) cylinder(d=5,h=thickness*5);
            }
            
    // cube to cut excess circle from bottom
    #translate([0,0,thickness]) cube([base_depth, length,length]);
}


difference() {
// front of hook
    hull() {
        rotate([0,90,0]) {
            #translate([front_hook_height-(thickness/2),length/2,base_depth-thickness]) cylinder(d=length,h=thickness);
        }
        rotate([0,90,0]) {
            translate([0,0,base_depth-thickness]) cube([front_hook_height,length,thickness]);
        }
    }
// cube to cut excess circle from bottom
    #translate([0,0,thickness]) cube([base_depth, length,length]);

}
