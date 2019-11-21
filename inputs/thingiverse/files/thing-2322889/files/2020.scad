length=100;

tslot20(length);

module tslot20(length) {
    $fn=50;
    height=20; 
    inner_size=7.32;
    diag_width=1.5;
    gap=5.26;
    inner_depth=6.8;
    full_depth=9.18;
    through_rad=4.19/2;
    inside_gap=11.99;
    edge_thickness=1.5;
    
    module outer_edge() {
        intersection() {
            difference() {
                union() {
                    difference() {
                            square(size=height, center=true);    
                            
                        square(size=(height-edge_thickness*2), center=true);            
                        for(rot = [0:90:270]) {
                            rotate([0,0,rot]) 
                            translate([0,height/2,0])
                            square([gap,10],true);
                        }
                    }
                    corner_boxes();            
                    diag_beams();
                }
            }    
            minkowski() {
                            square(size=height-2, center=true);    
                            circle(r=1);
                        }
        }
    }

    module corner_boxes() {
        for(rot=[0:90:270]) {
            rotate([0,0,rot])
            translate([-height/2,-height/2,0])        
            square(size=(height-inside_gap)/2);
        }    
    }

    module inner_section() {
        difference() {
            square(size=inner_size,center=true);
            circle(through_rad);
        }
    }

    module diag_beams() {
        for(rot = [45:90:90*3+45]) {
            rotate([0,0,rot]) 
            translate([-diag_width/2,4,0])
            square([diag_width,13
            ], false);
        }
    }

    linear_extrude(length) {
        outer_edge();
        inner_section();
    }

}

