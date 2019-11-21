//


// print the under desk mount
print_under_desk_mount="true"; //[true:print_under_desk_mount, false:do_not_print_under_desk_mount]

//print the headset holder
print_headset_holder="true"; //[true:print_the_headset, false:do_not_print_headset]

// set to zero to remove the backplate
backplate=2;


hoerer_radius=100;

// make the holder wider
hoerer_left_right=140;

//defines if more flat or not
hoerer_top_down=70;

//increase to make it stronger
dicke=4;

//increase to make it the width of the headset
hoerer_breite=40;

//bottom thickness
boden_dicke=2;


//the camfer of the screws
connector_hole_outer_radius=5;
screw_radius=1.6;

//inner fixating block length 
verschraubung_cube_laenge=40;

// inner fixating block height
verschraubung_cube_hoehe=20;

//defines the position of the screws
verschraubung_abstand_rand=10;

//how thick in the inner fixating block
verschraubung_dicke=10;

//camfer large radius
senk1=3;

//camfer small radius
senk2=1.5; 

//camfer height
senk_h=2;

my_minko=2;

//under desk mount height
senkrechter_halter_laenge=35;
senkrechter_halter_dicke=3;
senkrechter_halter_schrauben_abstand_rand=8;

//under desk mount plate length
deckel_oben_laenge=25;
my_camfer_radius=5;


module my_minko_cube (breite,laenge,hoehe,minko) {
    translate ([minko,minko,minko])  minkowski () {
        cube ([breite-2*minko, laenge-2*minko, hoehe-2*minko]);
        sphere (r=minko, $fn=30);
    }
}

module camfer (camfer_radius, camfer_wandstaerke, camfer_laenge) {
difference () {
    cube ([camfer_radius+camfer_wandstaerke, camfer_laenge, camfer_radius+camfer_wandstaerke]);  
    translate ([camfer_wandstaerke+camfer_radius,0,camfer_wandstaerke+camfer_radius]) rotate ([-90,0,0]) cylinder (r=camfer_radius, h=camfer_laenge,$fn=40);
    }
}


module full_body_upper_half () {
    linear_extrude(height = hoerer_breite ) 
        difference () {
            resize([hoerer_left_right,hoerer_top_down])circle(r=hoerer_radius,$fn=100);
            translate ([-hoerer_left_right,-hoerer_top_down]) 
                square ([2*hoerer_left_right,hoerer_top_down]);
        }
}

module verschraubung_loecher () {
        translate ([verschraubung_cube_laenge/2-verschraubung_abstand_rand,0,0]) {
                cylinder (r=screw_radius,h=hoerer_breite,$fn=30);
                translate ([0,0,hoerer_breite-senk_h]) cylinder (r2=senk1,r1=senk2, h=senk_h,$fn=30);
                translate ([0,0,0]) cylinder (r1=senk1,r2=senk2, h=senk_h,$fn=30);
        }
        translate ([-verschraubung_cube_laenge/2+verschraubung_abstand_rand,0,0]) {
            cylinder (r=screw_radius,h=hoerer_breite,$fn=30);
            translate ([0,0,hoerer_breite-senk_h]) cylinder (r2=senk1,r1=senk2, h=senk_h,$fn=30);
            translate ([0,0,0]) cylinder (r1=senk1,r2=senk2, h=senk_h,$fn=30);
        }
}

module verschraubung () {
    difference () {
        intersection () {
            full_body_upper_half ();
            translate ([-verschraubung_cube_laenge/2,hoerer_top_down/2-verschraubung_cube_hoehe,0]) 
                    my_minko_cube (verschraubung_cube_laenge,verschraubung_cube_hoehe,verschraubung_dicke,my_minko);
            
        }//end intersection
        translate ([0,hoerer_top_down/2-verschraubung_cube_hoehe/2,-hoerer_breite+verschraubung_dicke])verschraubung_loecher ();
    }
        
}
    

module hollow_body () {
    verschraubung ();
    translate ([-hoerer_left_right/2,-boden_dicke,0]) cube ([hoerer_left_right,boden_dicke,hoerer_breite]);
    difference () {
        full_body_upper_half ();
        translate ([0,0,backplate]) linear_extrude(height = hoerer_breite ) resize([hoerer_left_right-dicke,hoerer_top_down-dicke])circle(r=hoerer_radius,$fn=100);
    }
}


module halter () {

//deckel oben
translate ([-verschraubung_cube_laenge/2,senkrechter_halter_laenge+senkrechter_halter_dicke,senkrechter_halter_dicke]) rotate ([90,90,0]) camfer (my_camfer_radius, senkrechter_halter_dicke, hoerer_breite);
//verstaerkungssteg

difference () {
    translate ([-verschraubung_cube_laenge/2,senkrechter_halter_laenge,senkrechter_halter_dicke]) rotate ([-90,0,0]) {
        difference () {
            my_minko_cube (verschraubung_cube_laenge,deckel_oben_laenge,senkrechter_halter_dicke,1);
            
            translate ([verschraubung_cube_laenge/2,deckel_oben_laenge/2,0]) 
                verschraubung_loecher ();
        }
     }
}


//senkrechte
difference () {
    translate ([-verschraubung_cube_laenge/2,0,0]) 
        my_minko_cube (verschraubung_cube_laenge,senkrechter_halter_laenge,senkrechter_halter_dicke,1);
    //die unteren loecher
    translate ([0,verschraubung_cube_hoehe/2,0]) {
        verschraubung_loecher ();
        
    }
    //die oberen loecher
    translate ([0,senkrechter_halter_laenge-senkrechter_halter_schrauben_abstand_rand,-hoerer_breite+senkrechter_halter_dicke]) {
        verschraubung_loecher ();
        cylinder (r2=senk1,r1=senk2, h=senkrechter_halter_dicke,$fn=30);
}
    
   }


}


if (print_headset_holder=="true") translate ([0,hoerer_breite,boden_dicke]) rotate ([90,0,0]) hollow_body ();

if (print_under_desk_mount=="true") translate ([hoerer_left_right/2-verschraubung_cube_laenge/2,-20,senkrechter_halter_laenge+senkrechter_halter_dicke]) rotate ([-90,0,0]) halter ();
