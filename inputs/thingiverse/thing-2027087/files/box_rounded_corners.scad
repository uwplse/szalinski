wall_thickness = 0.82;          //Box perimiter thickness
lid_thickness = 0.82;           //lid top/bottom thickness
lid_clearance = 0.6;            //This sets the distance between the the lid and lower half of the box

//These dimensions are for the OUTSIDE of the inner box.
height = 20;
width = 25;
length = 25;
radius = 2;

//These dimensions are for the lid. 
lid_height = 15;


//Resolution of the fillets
resolution = 32;


module rounded_rect(x, y, radius, height){
    if (radius > 0){
        hull(){
            translate([-x/2 + radius, y/2 - radius, 0])
            cylinder(h = height, r = radius, center = true, $fn=$fn);
            
            translate([x/2 - radius, y/2 - radius, 0])
            cylinder(h = height, r = radius, center = true, $fn=$fn);
            
            translate([-x/2 + radius, -y/2 + radius, 0])
            cylinder(h = height, r = radius, center = true, $fn=$fn);
            
            translate([x/2 - radius, -y/2 + radius, 0])
            cylinder(h = height, r = radius, center = true, $fn=$fn);
        }
    }else{
        cube([x, y, height], center = true);
    }
}

module bottom(){
    translate([0,0,height/2])
        difference(){
            rounded_rect(width, length, radius, height, $fn=resolution);
            translate([0,0, lid_thickness])
            rounded_rect(width - wall_thickness * 2, length - wall_thickness * 2, radius, height, $fn=resolution);
        }
}

module top(){
    _outside_lid = wall_thickness * 2 + lid_clearance;
    translate([0,0,lid_height/2])
    difference(){
        rounded_rect(width + _outside_lid , length + _outside_lid , radius, lid_height, $fn=resolution);
        translate([0, 0, lid_thickness])
        rounded_rect(width + lid_clearance, length + lid_clearance, radius, lid_height, $fn=resolution);
    }
}

translate([-width * 0.55,0,0])
    bottom();
translate([width * 0.55,0,0])
    top();