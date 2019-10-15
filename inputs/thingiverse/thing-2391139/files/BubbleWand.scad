inch=25.4;

build_stl=true;
thickness_inches=0.03125;
fineness_stl=200;
fineness_low=40;

nubs=48;

ring_radius_inches=0.5;
stick_length_inches=3;

fineness=build_stl?fineness_stl:fineness_low;

thickness=thickness_inches*inch;
ring_size=ring_radius_inches*inch;
stick_length=stick_length_inches*inch;

edge_a=thickness*6+ring_size;
edge_b=thickness*5+ring_size;
edge_c=thickness*2+ring_size;
edge_d=thickness+ring_size;


module stick(){   
    translate([0,-ring_size-thickness*5,thickness/2])
    rotate([90,0,0])
    scale([1,0.5,1])
    cylinder(stick_length,thickness*3,thickness*3,$fn=fineness);
}

module ring_of_nubs(){
    for (i=[0:nubs]){
        rotate([0,0,i*(360/nubs)]){
            translate([ring_size,-thickness,-2*thickness])
            cube([thickness*3,thickness,thickness*5]);
            
            translate([ring_size+thickness*4,-thickness,-2*thickness])
            cube([thickness*3,thickness,thickness*5]);
        }
    }
}

module outer_band(){
    difference(){
        cylinder(thickness,edge_a,edge_a,$fn=fineness);
        
        translate([0,0,-0.001])
        cylinder(thickness+0.002,edge_b,edge_b,$fn=fineness);
    }
}

module inner_band(){
    difference(){
        cylinder(thickness,edge_c,edge_c,$fn=fineness);
        
        translate([0,0,-0.001])
        cylinder(thickness+0.002,edge_d,edge_d,$fn=fineness);
    }
}

module ring(){
    union(){
        difference(){
            cylinder(thickness,edge_a,edge_a,$fn=fineness);
            
            translate([0,0,-0.001])
            cylinder(thickness+0.002,edge_d,edge_d,$fn=fineness);
        }
        
        translate([0,0,thickness-0.001])
        outer_band();
        
        translate([0,0,thickness-0.001])
        inner_band();

        translate([0,0,-thickness+0.001])
        outer_band();

        translate([0,0,-thickness+0.001])
        inner_band();
    }
}
module handle_ring(){
    union(){
        translate([0,0,-thickness/2])
        difference(){
            cylinder(thickness*2,edge_a,edge_a,$fn=fineness);
            
            translate([0,0,-0.001])
            cylinder(thickness*2+0.002,edge_d,edge_d,$fn=fineness);
        }
        
        translate([0,0,thickness-0.001])
        outer_band();
        
        translate([0,0,thickness-0.001])
        inner_band();

        translate([0,0,-thickness+0.001])
        outer_band();

        translate([0,0,-thickness+0.001])
        inner_band();
    }
}

module nubby_ring(){
    ring();
    ring_of_nubs();
}

module bubble_wand(){
    union(){
        stick();
        translate([0,-stick_length-ring_size*2-10*thickness,0])
        handle_ring();
        nubby_ring();
    }
}

bubble_wand();

//cube([1.5*inch,1,1]);