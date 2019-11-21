testing = [0.1, 0.15, 0.2, 0.25, 0.3, 0.35, 0.4, 0.45, 0.5];

n = len(testing);

$fn = 64;

difference(){
    translate([5, 5, 0])
    minkowski(){
        cube([15 * n - 10, 5, 3]);
        cylinder(h = 1, d = 10);
    }
    for(i = [0 : n - 1]){
        translate([i * 15 + 7.5, 7.5, 0])
        minkowski(){
            cylinder(d1 = 8, d2 = 13, h = 5);
            sphere(r = testing[i]);
        }
        
    }
}

    for(i = [0 : n - 1]){
        translate([i * 15 + 7.5, 7.5, 0])
        difference(){
            cylinder(d1 = 8, d2 = 13, h = 5);
    
            
            translate([0, 0, 4.8])
            linear_extrude(height = 10)
            text(str(testing[i] * 100), size = 6, font="Arial:style=bold", valign="center", halign = "center");
        }
    }