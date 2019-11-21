//The following parameters can be changed in customizer

//BEGIN CUSTOMIZER

/*[Jack O'Lantern Parameters] */

//Choose which part(s) to render *not all options are printable without modifications*
parts_to_render=1;  //[1:pumpkin_body_with_face_and_lid, 2:printable_pumpkin_lid, 3:printable_pumpkin_body_with_face_and_supports, 4:pumpkin_body_with_face, 5:printable_pumpkin_body_no_face]   


//Use draft to preview / production to print
render_quality=20;  //[20:draft, 60:production]


//Approximate size of pumpkin body with lid, mm *addtional supports may be needed to print larger sizes*
project_size=65; // [20:250]

//END CUSTOMIZER



//
//The following parameters cannot be changed in customizer 
/*[Hidden]*/

$fn=render_quality;


scale ([project_size/65,project_size/65,project_size/65]){
    
    if (parts_to_render==1){    //make pumpkin body and face and pumpkin top
        body ();
        translate ([0,0,-2]){
            pumpkintop ();
        }
    }
    if (parts_to_render==2){    //make pumpkin lid
        translate ([0,0,-2]){
            pumpkintop ();
        }
    }

    if (parts_to_render==3){    //make pumpkin body and face with supports so it is printable
        body ();

        //farthest left support
        intersection (){
            translate ([-12.3,-22,-13]){
                support ();
            }
            difference () {
                allslices ();
                translate ([0,0,3]){
                    sphere (r=27.8);
                }
            }
        }
        //second support from left
        intersection (){
            translate ([-3.1,-22,-13]){
                support ();
            }
            difference () {
                allslices ();
                translate ([0,0,3]){
                    sphere (r=27.8);
                }
            }
        }

        //third support from left
        intersection (){
            translate ([2.2,-22,-13]){
                support ();
            }
            difference () {
                allslices ();
                translate ([0,0,3]){
                    sphere (r=27.8);
                }
            }
        }

        //fourth support from left 
        intersection (){
            translate ([13.2,-22,-13]){
                support ();
            }
            difference () {
                allslices ();
                translate ([0,0,3]){
                    sphere (r=27.8);
                }
            }
        }
    }

    if (parts_to_render==4){    //make pumpkin body and face with no supports (not printable)
        body ();
    }

    if (parts_to_render==5){    //make pumpkin body with no face (printable)
        difference () {
            allslices ();
            translate ([0,0,3]){
                sphere (r=27.8);
            }
            translate ([-30, -30, -85]){
                cube ([60, 60, 60]);
            }
            translate ([-30, -30, 20]){
                cube ([60, 60, 60]);
            }
        }
    }
}


//pumpkin top that can be removed from body to put in a light or something else
module pumpkintop(){
    scale ([1,1,.7]){
        difference (){
            translate ([0,0,15]){
                intersection () {
                    difference (){
                        allslices ();
                        sphere (r=27.8);
                    }
                    translate ([-30, -30, 20]){
                        cube ([60, 60, 60]);
                    }
                }
            }
        }
    }
    //pumpkin stem
    translate ([1,0,35]){
        rotate ([0,12,0]){
            minkowski (){
                difference (){
                    cylinder (r=4,h=10,center=true);
                    for (i=[0:60:300]){
                        rotate ([0,0,i]){
                            translate ([3.6,0,-20]){
                                cube ([5,40,40]);
                            }
                        }
                    }
                }
                sphere (r=1);
            }
        }
    }
}


//pumpkin body
module body (){
    difference () {
        allslices ();
        translate ([0,0,3]){
            sphere (r=27.8);
        }
        translate ([-30, -30, -85]){
            cube ([60, 60, 60]);
        }
        translate ([-30, -30, 20]){
            cube ([60, 60, 60]);
        }
        
        //mouth
        scale ([1,1,.8]){
            translate ([0,-25,-2]){
                difference (){
                    rotate ([-90,0,0]){
                       difference (){
                            cylinder (r=20, h=15, center=true);
                            translate ([-30,-55,-20]){
                                cube ([60,60,60]);
                            }
                        }
                    }
                    translate ([2,-15,-10]){
                        cube ([11,30,35]);
                    }
                    translate ([-12,-15,-11]){
                        cube ([9,30,35]);
                    }
                    translate ([-3,-15,-55]){
                        cube ([10,30,40]);
                    }
                }
            }
        }
        //cut out eye
        translate ([2,-40,-5]){
            triangle ();
        }
        //cut out eye
        translate ([-20,-40,-5]){
            triangle ();
        }
        //cut out nose
        translate ([-4,-40,-8]){
            scale ([.4,.5,.5]){
                triangle ();
            }
        }
    }
}


//triangle shape for eye and nose cut out
module triangle (){
    difference (){
        cube ([20,30,20]);
        translate ([0,-10,8]){
            rotate ([0,-55,0]){
                cube ([20,60,20]);
            }
        }
        translate ([18,-10,6]){
            rotate ([0,-35,0]){
                cube ([30,60,20]);
            }
        }
        translate ([-5,-10,-32]){
            cube ([40,60,40]);
        }
    }
}

//all notches on pumpkin
module allslices (){
    for (i=[0:20:160]){
        rotate ([0,0,i]){
            slice ();
       }
   }
}


//cut out to notch pumpkin sides
module slice (){
    scale ([1.15,.6,1]){
        sphere (r=30);
    }
}


module support(){
    scale ([.5,10,1]){
        cylinder (r=1.3, h=17, center=true);
    }
}