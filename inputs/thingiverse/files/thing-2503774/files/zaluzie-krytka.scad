

r = 4.1;
w = 25.2;
s = 1.11;
h = 9.11;

difference() {
    union()
    { 
        translate([r, -r,0]) cube([w-2*r+s, 2*r, h]);
        translate([r,0,0]) kraj(r);
        translate([w-r+s,0,0]) kraj(r);
    }
    
    union()
    {   
        translate([0,0,s]) {
    
            translate([r, -r+s,0]) cube([w-2*r+s, (2*r)-2*s, h]);
            translate([r,0,0]) kraj(r-s);  
            translate([w-r+s,0,0]) kraj(r-s);
        }
    }
    
}

module kraj(r = 4) {
    
    cylinder(h, r, r, $fn=200);
}

