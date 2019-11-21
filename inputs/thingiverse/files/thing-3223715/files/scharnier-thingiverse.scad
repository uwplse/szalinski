//scharnier / hinge



//change this to either get a left or right mounted version
left_or_right_mount="left"; // [left:left_mount, right:right_mount]

//thickness of the hinge
scharnier_dicke=3;

//number of backplates to print
backplates=2; // [0, 1, 2 ]

//height of the hinge
hinge_height=40;

//length of the hinge
hinge_length=50;

//normally good enough to directly screw-in a machined 3mm screw
radius_screw_backplate=1.5;

//radius used by the hinge - either identical to radius_screw_backplate or slightly larger
radius_screw_hinge=1.7;

//the radius of the PIN to fix both halfes of the hinge. gets inserted into the "coupler"
pin_radius=2.2;

//increase this value to make a strong coupler
coupler_strength=2;

//distance from the fixating_holes to the edge
fixing_holes_distance_edge=10;
//change if you need more or less holes
fixing_holes_amount_vertical=3;
//change if you need more or less holes
fixing_holes_amount_horizontal=3;


//increase this value, if the PIN needs more air to fit into the hinge
pin_airgap=0.6;

scharnier_radius_innen=pin_radius+pin_airgap;
scharnier_radius_aussen=scharnier_radius_innen+coupler_strength;
pin_head_radius=scharnier_radius_aussen;

//In case the hinge needs more space left/right to turn more easily - increase it
extra_space_outer_diameter=0.7;

extra_space_scharnier_radius_aussen=scharnier_radius_aussen+extra_space_outer_diameter;

//the height of the PIN's head
pin_head_height=2;



//how many couplers to combine both parts
couplers_amount=3;

//increase this in case the hinge does not turn easy
couplers_air_between=0.15;

coupler_length=hinge_height/(2*couplers_amount)-couplers_air_between;






module pin () {
cylinder (r=pin_radius, h=hinge_height, $fn=30);
difference () {
    translate ([0,0,-pin_head_height]) cylinder (r=pin_head_radius,h=pin_head_height, $fn=20);
    translate ([-pin_head_radius,pin_radius,-pin_head_height]) cube ([pin_head_radius*2,pin_head_radius*2,pin_head_radius*2]);
}
    
}

module fixating_holes (radius) {
distance_vertical=(hinge_height-2*fixing_holes_distance_edge)/(fixing_holes_amount_vertical-1);
distance_horizontal=(hinge_length-2*fixing_holes_distance_edge)/(fixing_holes_amount_horizontal-1);
echo ("distance_horizontal", distance_horizontal);

//vertical
for (v=[0:1:fixing_holes_amount_vertical-1])
//horizontal
for (h=[0:1:fixing_holes_amount_horizontal-1]) {
    translate ([fixing_holes_distance_edge+v*distance_vertical,fixing_holes_distance_edge+h*distance_horizontal,0]) 
        cylinder (r=radius, h=2*scharnier_dicke,$fn=30);  
       }
}


module backplate (radius_screw) {
difference () {
    cube ([hinge_height,hinge_length,scharnier_dicke]);
    fixating_holes (radius_screw);
    }
}


module hohl_achse (mount,radius) {
    if (mount=="left") {
    for (a=[0:2:couplers_amount*2-1])
        translate ([a*(coupler_length+couplers_air_between),0,0]) rotate ([0,90,0]) difference () {
        cylinder (r=radius, h=coupler_length, $fn=30);
        cylinder (r=scharnier_radius_innen, h=coupler_length, $fn=30);
        }
    }
    else {
        for (a=[0:2:couplers_amount*2-1])
        translate ([(a+1)*(coupler_length+couplers_air_between)+couplers_air_between,0,0]) rotate ([0,90,0]) difference () {
        cylinder (r=radius, h=coupler_length, $fn=30);
        cylinder (r=scharnier_radius_innen, h=coupler_length, $fn=30);
        }
    }
}

module extra_space_hohl_achse (mount,radius) {
    hoehe=2*coupler_length+2*couplers_air_between;
    if (mount=="right") {
    echo ("extra -space right");
    for (a=[0:1:couplers_amount-1])
        translate ([a*hoehe,0,0]) 
            rotate ([0,90,0]) cylinder (r=radius, h=coupler_length+2*couplers_air_between, $fn=30);
        
    }
    else {
        echo ("leeeeft");
        for (a=[0:1:couplers_amount-1])
        translate ([a*hoehe+coupler_length,0,0]) 
            rotate ([0,90,0]) 
                cylinder (r=radius, h=coupler_length+2*couplers_air_between, $fn=30);
     
    }
}


module hinge () {
    difference () {
         translate ([0,0,-scharnier_radius_aussen]) 
            backplate (radius_screw_hinge);
        //rotate ([0,90,0]) cylinder (r=scharnier_radius_aussen, h=hinge_length, $fn=30);
        //extra space fuers scharnier
        extra_space_hohl_achse (left_or_right_mount,extra_space_scharnier_radius_aussen);
           
        
    }
    //extra_space_hohl_achse (left_or_right_mount,extra_space_scharnier_radius_aussen);
}



module scharnier_full () {
         hinge ();
         rotate ([0,0,0]) hohl_achse (left_or_right_mount,scharnier_radius_aussen);
            }
      


translate ([-5,hinge_length+scharnier_radius_aussen+5,-scharnier_dicke]) rotate ([-90,0,-90]) pin ();
scharnier_full ();
translate ([hinge_height,-2*scharnier_radius_aussen-5,0]) rotate ([0,0,180]) scharnier_full ();


for (b=[0:1:backplates-1]) 
    translate ([hinge_height+5,-b*(hinge_length+5),-scharnier_radius_aussen]) backplate (radius_screw_backplate);
            





