// accu drill holder

// most drillers are conical. larger-radius
driller_radius_large=54/2;
//if conical, enter small radius here. if not conical, enter same radius as the larger one
driller_radius_small=47/2;

//the height of the whole body and the conical mounting-hole
driller_height=26;

// you may want some extra-space/distance at the rear to fit your driller
space_rear=8;

// material thickness
sourrounding_thickness=5;

// you could create a version which is half-open. The value entered here is the space longer then the half. Default-values provide enclosed body
surrounding_larger_then_half=driller_radius_large+sourrounding_thickness;


//depending on the screw fit this value
mounting_hole_radius=2;

//the radius of the screw's head
mounting_hole_screw_head_radius=4;

//the hight of your screw's head
mounting_hole_screw_head_depth=3;

//no change here
mounting_hole_length=space_rear+driller_radius_large-driller_radius_small;

//this should fit your screw-driver or drilling tool
front_mounting_hole_radius=9;

// rear mount width
upper_rear_mount_width=18;

//rear_mount thickness
upper_rear_mount_thickness=5;

//rear mount height
upper_rear_mount_height=17;

//you might want to change the position of the screw-hole
upper_rear_mount_screw_distance_from_upper=7;

//rounded corners radius
my_minko=2;

//no changes here
width=2*driller_radius_large+2*sourrounding_thickness;
//no changes here
length=driller_radius_large+surrounding_larger_then_half+space_rear;


module my_minko_cube (breite,laenge,hoehe,minko) {
    translate ([minko,minko,minko])  minkowski () {
        cube ([breite-2*minko, laenge-2*minko, hoehe-2*minko]);
        sphere (r=minko, $fn=30);
    }
}


module upper_rear_mount_single_ear () {

    difference () {
        cube ([upper_rear_mount_width,upper_rear_mount_thickness,upper_rear_mount_height]);
        translate ([upper_rear_mount_width/2,0,upper_rear_mount_height-upper_rear_mount_screw_distance_from_upper]) rotate ([-90,0,0]) {
            cylinder (r1=mounting_hole_screw_head_radius,r2=mounting_hole_radius,h=mounting_hole_screw_head_depth,$fn=30);
            cylinder (r=mounting_hole_radius,h=upper_rear_mount_thickness,$fn=30);
    
        }
   
}
}
module upper_rear_mount () {
    offset=driller_radius_large+space_rear-upper_rear_mount_thickness;
    translate ([width/2-my_minko-upper_rear_mount_width,offset,driller_height]) 
            upper_rear_mount_single_ear ();
    translate ([-width/2+my_minko,offset,driller_height]) 
            upper_rear_mount_single_ear ();
}

module mounting_hole () {
    diff=(driller_radius_large-driller_radius_small)/2;
    cylinder (r=mounting_hole_radius,h=mounting_hole_length,$fn=30);
    translate ([0,0,diff]) cylinder (r1=mounting_hole_screw_head_radius,r2=mounting_hole_radius,h=mounting_hole_screw_head_depth,$fn=30);
    cylinder (r=mounting_hole_screw_head_radius,h=diff,$fn=30);
    
}

module body () {
    difference () {
        //full body
        translate ([-width/2,0,0]) my_minko_cube (width,length,driller_height,my_minko,"");
        //cube ([width,length,driller_height]);
        //driller
        translate ([0,surrounding_larger_then_half,0]) cylinder (r2=driller_radius_large,r1=driller_radius_small,h=driller_height,$fn=100);
        //mounting holes
    
    }
}


module all () {
    difference () {
        body ();
        translate ([0,length-mounting_hole_length,driller_height/2]) 
            rotate ([-90,0,0]) 
                mounting_hole();
        translate ([0,-length/2,driller_height/2]) rotate ([-90,0,0]) cylinder (r=front_mounting_hole_radius, h=length,$fn=30);
    }
}

translate ([0,-surrounding_larger_then_half,0]) all ();
upper_rear_mount ();

//upper_rear_mount_single_ear ();
//mounting_hole ();

