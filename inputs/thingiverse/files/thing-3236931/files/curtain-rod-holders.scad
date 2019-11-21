// How much to dilate holes
print_dilation=0.2;
rod_diameter=21.6;
screw_diameter=3.7;
screw_head_diameter=11.2;
// Distance between screw holes
screw_distance=37.5;
// Wall thickness
thickness=2.5;
// Stretch screw holes by
screw_slot_extra=1;

rod_r=rod_diameter/2+print_dilation;
screw_hole_r=screw_diameter/2 + print_dilation;
screw_head_r=screw_head_diameter/2;
width=screw_head_r*2+thickness*2;
extra_width=screw_head_r+thickness;

$fa=3;
$fs=0.2;
module box(low, high){
    translate(low){
        cube(high-low);
    }
}

module screw_hole(){
    hull(){
        translate([-screw_slot_extra*0.5,0,0])cylinder(3*rod_r, r=screw_hole_r);
        translate([screw_slot_extra*0.5,0,0])cylinder(3*rod_r, r=screw_hole_r);
    }
    hull(){
        translate([-screw_slot_extra*0.5,0,thickness*2])cylinder(3*rod_r, r=screw_head_r);
        translate([screw_slot_extra*0.5,0,thickness*2])cylinder(3*rod_r, r=screw_head_r);
    }
}

difference(){
    union(){
        hull(){
            cylinder(width, r=rod_r+thickness);
            box([-screw_distance*0.5-extra_width,-rod_r-thickness, 0],[screw_distance*0.5+extra_width, -rod_r, width]);
        }
        
    }
    #cylinder(width+1, r=rod_r);
    translate([-screw_distance*0.5, -rod_r-thickness-0.01, width*0.5]){
        rotate(-90, v=[1,0,0]){
            # screw_hole();
        }
    }    
    translate([screw_distance*0.5, -rod_r-thickness-0.01, width*0.5]){
        rotate(-90, v=[1,0,0]){
            #screw_hole();
        }
    }
    
    translate([0, 0, width*0.5]){
        rotate(-90, v=[1,0,0]){
            #cylinder(rod_r+10, r=screw_hole_r);
        }
    }
}