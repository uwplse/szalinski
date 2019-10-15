
// PTFE tube length
tube_length = 34.5;

// PTFE tube outside diameter 
tube_od = 4.2;

module jig(){
    buf = 1;
    jig_size = tube_od * 1.5;
    base_ht = 3;
    body_length = tube_length+(buf*2);
    base_off = 0.5;
    rotate([0,0,270])
    // put it on the platform
    translate([0,0,(jig_size/2 + base_ht/2)+base_off])
    {
    difference(){
        cube([body_length,jig_size,jig_size],center=true); // jig body
        cube([body_length,(tube_od/4),jig_size],center=true); // push slot
        translate([buf,0,0]) rotate(90,[0,1,0])
            cylinder(d=tube_od,h=tube_length, center=true); // tube hole
    }
    // base plate (offest to make a cutting base)
    cut_brd = jig_size;
    translate([cut_brd/2,0,(jig_size/2*-1)-base_off])
        cube([body_length+cut_brd,jig_size*3,base_ht],center=true);
    }
}

$fn=20;
jig();