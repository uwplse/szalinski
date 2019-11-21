//Super Mario "BOO" Style Ghost
//Joe Brown

//The Quality of The Model
model_quality = 50;//[1:100]
//The Scale Of the Model
model_scale_percent = 60; //[50:200]
//What Should Be Rendered?
model_render = "Full"; //[All, Base, Hat, Extras, Full]
//Include Hat in Model?
include_hat = "Yes"; //[Yes,No] 
//Include Teeth in Model?
include_teeth = "Yes"; //[Yes,No] 
//Include Arms in Model?
include_arms = "Yes"; //[Yes,No]
//Show the Tail End Support for the model?
show_support = "Yes"; //[Yes,No]

height = 50*1; //model base height (scale will be used so this is hidden)
$fn = model_quality*1; 
model_scale = model_scale_percent / 100; 

rotate([0,0,180]) {
    All();
}

module All() {
difference() {
    //the ghost itself
    scale([model_scale,model_scale,model_scale]) {
        translate([0,0,height]) {
            difference() {
                if (model_render=="All" || model_render=="Base") {
                    ghost(); //the ghost model
                }
                else if (model_render == "Full") {
                    ghost_full();
                }
                if (include_hat == "Yes" && (model_render=="All" || model_render=="Base" || model_render == "Full")) {
                    hat_base(); //makes room for the hat
                }
            }
        }
    }
    if (model_render=="All" || model_render=="Base") {
    //the difference stuff, this is to flatten the tail mainly
    translate([-50,-40,0]) {
            rotate([0,90,0]) {
                cube([20,80,100]);
            }
        }
    }
}

//The Hat for the full render
if (model_render=="Full" && include_hat =="Yes") {
        scale([model_scale,model_scale,model_scale]) {
            translate([0,0,height]) {
            hat_full();
        }
    }
}

//Render the Extras in the middle?
if (model_render == "Extras") {
    scale([model_scale,model_scale,model_scale]) {
        ghost_parts();
    }
}

//Render the hat WITH the other models?
if (include_hat == "Yes" && (model_render=="All")) {
    scale([model_scale,model_scale,model_scale]) {
            translate([120,0,height-(height*1.55)]) {
                hat(); //the hat. Not Unioned, as it is a seperate piece.
            }
     }
}

//Or render the hat model by itself
if (model_render == "Hat") {
   scale([model_scale,model_scale,model_scale]) {
            translate([0,0,0]) {
                hat_alone(); //the hat. Not Unioned, as it is a seperate piece.
            }
     } 
}

}

module ghost() {
    
    //body
    if (model_render=="Base" || model_render=="All") {
    difference() {
    union() { //keeps the body together
        difference() {
        sphere(r=height);
        //eyes
            
            //left
            translate([height/2,height,height/2]) {
                cylinder(h=height/2,r1=height/3.5,r2=height/3.5,center=true);
            }
            //right
            translate([-height/2,height,height/2]) {
                cylinder(h=height/2,r1=height/3.5,r2=height/3.5,center=true);
            }
        //mouth
            translate([0,50,-10]) {
                    translate([0,0,-4]) {
                        cylinder(h=25,r1=20,r2=30,center=true);
                    }                
                    
            }

        
        
        
        //eyebrow
            translate([height-(height/1.6),height-(height/4),height-(height/2)]) {
                rotate([0,-90,90]) {
                     difference() {
                        cylinder(r=10,h=10);
                        union() {
                            translate([0,0,-.1])  cylinder(r=9,h=11); 
                      
                            translate([-10,0,5])  cube([30,30,12],center=  true); 
                        }
                    }
                }
            }
            
            translate([-(height-(height/1.6)),height-(height/4),height-(height/2)]) {
                rotate([0,-90,90]) {
                     difference() {
                        cylinder(r=10,h=10);
                        union() {
                            translate([0,0,-.1])  cylinder(r=9,h=11);
                      
                            translate([-10,0,5])  cube([30,30,12],center=  true);
                        }
                    }
                }
            }
        }
        
        //mouth backing
        //this fills in the back of the mouth to make sure there is not
        //a gaping hole, but rather a solid back like in the Mario Series
        translate([-height/2,height/5,-height/2]) {
            cube([50,25,25]);
        }
        
        //tongue
        //tongue, extrudes from mouth and then droops down
        translate([-height/4,height/3,-height/2]) {
            //intial extrude
            minkowski() {
                cube([25,32,5]);
                sphere(r=2);
            }
            //outer "droop" of the tongue
            translate([0,-10,0]) {
                hull() {
                    translate([0,35,-23]) {
                        minkowski() {
                            cube([25,8,28]);
                            sphere(r=2);
                        }
                    }
                    translate([0,35,-23]) {
                        minkowski() {
                            cube([25,15,5]);
                            sphere(r=2);
                        }
                    }
                }
            }
        }
        
       
        //tail
        //tiny extrude from backend of body
        translate([0,-height/1.5,-height/1.5]) {
            rotate([0,45,90]) {
               cylinder(h=29,r1=10,r2=25,center=true);
            }
                
        }
        
        //support for tail
        
        if (show_support == "Yes") {
            translate([-1.5,-height+(-0.6),-height*1]) {
                cube([3,2,13.4]);
            }
        }
 
    }
    
    //start differencing the extra parts
     //arms
        //as seen in the mario games, these are simple extrudes capped with circles
               
    if (include_arms == "Yes") {
        translate([height,0,0]) {
            union() {
                rotate([0,-90,0]) {
                    cylinder(h=30,r1=6,r2=23,center=true);
                }
                translate([14,0,0]) {
                    sphere(r=6);
                }
            }
        }
        translate([-height,0,0]) {
            union() {
                rotate([0,90,0]) {
                    cylinder(h=30,r1=6,r2=23,center=true);
                }
                translate([-14,0,0]) {
                    sphere(r=6);
                }
            }
        }
    }
}
}
    
    //extra parts
    if (model_render == "All") {
            //teeth
            if (include_teeth == "Yes") {
            translate([0,100,-height+(height/8.3)]) {
                rotate([0,-180,0]) {
                cylinder(h=9,r1=2,r2=7,center=true);
                }
            }
            //slightly larger "fangs"
            translate([16,100,-height+(height/6.3)]) {
                rotate([0,-180,0]) {
                cylinder(h=12,r1=2,r2=7,center=true);
                }
            }
            translate([-16,100,-height+(height/6.3)]) {
                rotate([0,-180,0]) {
                cylinder(h=12,r1=2,r2=7,center=true);
                }
            }
        }
            
            //physical arms, seperated
        if (include_arms == "Yes") {
        translate([-height,130,height-(height*1.74)]) {
                union() {
                    rotate([0,-180,0]) {
                        cylinder(h=25,r1=5,r2=14,center=true);
                    }
                    translate([0,0,11]) {
                        sphere(r=5);
                    }
                }
            }
            translate([height,130,height-(height*1.74)]) {
                union() {
                    rotate([0,-180,0]) {
                        cylinder(h=25,r1=5,r2=14,center=true);
                    }
                    translate([0,0,11]) {
                        sphere(r=5);
                    }
                }
            }
            
        }
    }
        
}

//module for the ghost "extra" parts alone
module ghost_parts() {
    //extra parts
        //teeth
        translate([0,0,6]) {
            rotate([0,-180,0]) {
            cylinder(h=9,r1=2,r2=7,center=true);
            }
        }
        //slightly larger "fangs"
        translate([16,0,8]) {
            rotate([0,-180,0]) {
            cylinder(h=12,r1=2,r2=7,center=true);
            }
        }
        translate([-16,0,8]) {
            rotate([0,-180,0]) {
            cylinder(h=12,r1=2,r2=7,center=true);
            }
        }
        
        //physical arms, seperated
    translate([-height,0,12.5]) {
            union() {
                rotate([0,-180,0]) {
                    cylinder(h=25,r1=5,r2=14,center=true);
                }
                translate([0,0,11]) {
                    sphere(r=5);
                }
            }
        }
        translate([height,0,12.5]) {
            union() {
                rotate([0,-180,0]) {
                    cylinder(h=25,r1=5,r2=14,center=true);
                }
                translate([0,0,11]) {
                    sphere(r=5);
                }
            }
        }
}

module hat_base() { //this is simply used to different the top to make room for the hat
    translate([0,0,height-(height/20)]) {
    cylinder(h=20,r1=50,r2=50,center=true);
    }
}

module hat() { //the actual hat. not unioned because it is a seperate piece
    union() {
    //base
        translate([0,0,height-(height/2.6)]) {
            cylinder(h=5,r1=50,r2=50,center=true);
        }
        //top part
        translate([0,0,height+20]) {
            cylinder(h=80,r1=35,r2=1,center=true);
        }
    }
}

module hat_alone() { //the hat alone to be rendered in the center
    union() {
        //base
        translate([0,0,2.5]) {
            cylinder(h=5,r1=50,r2=50,center=true);
        }
        //top part
        translate([0,0,40]) {
            cylinder(h=80,r1=35,r2=1,center=true);
        }
    }
}

module ghost_full() {
    
    //body
    union() { //keeps the body together
        difference() {
        sphere(r=height);
        //eyes
            
            //left
            translate([height/2,height,height/2]) {
                cylinder(h=height/2,r1=height/3.5,r2=height/3.5,center=true);
            }
            //right
            translate([-height/2,height,height/2]) {
                cylinder(h=height/2,r1=height/3.5,r2=height/3.5,center=true);
            }
        //mouth
            translate([0,50,-10]) {
                    translate([0,0,-4]) {
                        cylinder(h=25,r1=20,r2=30,center=true);
                    }                
                    
            }

        
        
        
        //eyebrow
            translate([height-(height/1.6),height-(height/4),height-(height/2)]) {
                rotate([0,-90,90]) {
                     difference() {
                        cylinder(r=10,h=10);
                        union() {
                            translate([0,0,-.1])  cylinder(r=9,h=11); 
                      
                            translate([-10,0,5])  cube([30,30,12],center=  true); 
                        }
                    }
                }
            }
            
            translate([-(height-(height/1.6)),height-(height/4),height-(height/2)]) {
                rotate([0,-90,90]) {
                     difference() {
                        cylinder(r=10,h=10);
                        union() {
                            translate([0,0,-.1])  cylinder(r=9,h=11);
                      
                            translate([-10,0,5])  cube([30,30,12],center=  true);
                        }
                    }
                }
            }
        }
        
        //mouth backing
        //this fills in the back of the mouth to make sure there is not
        //a gaping hole, but rather a solid back like in the Mario Series
        translate([-height/2,height/5,-height/2]) {
            cube([50,25,25]);
        }
        
            //teeth
        if (include_teeth == "Yes") {
        translate([0,41.7,-7]) {
        cylinder(h=9,r1=2,r2=7,center=true);
        }
        //slightly larger "fangs"
        translate([16,38,-7]) {
        cylinder(h=12,r1=2,r2=7,center=true);
        }
        translate([-16,38,-7]) {
        cylinder(h=12,r1=2,r2=7,center=true);
        }
        }
        
        //tongue
        //tongue, extrudes from mouth and then droops down
        translate([-height/4,height/3,-height/2]) {
            //intial extrude
            minkowski() {
                cube([25,32,5]);
                sphere(r=2);
            }
            //outer "droop" of the tongue
            translate([0,-10,0]) {
                hull() {
                    translate([0,35,-23]) {
                        minkowski() {
                            cube([25,8,28]);
                            sphere(r=2);
                        }
                    }
                    translate([0,35,-23]) {
                        minkowski() {
                            cube([25,15,5]);
                            sphere(r=2);
                        }
                    }
                }
            }
        }
        
        //arms
        //as seen in the mario games, these are simple extrudes capped with circles
        if (include_arms == "Yes") {
        translate([height,0,0]) {
            union() {
                rotate([0,-90,0]) {
                    cylinder(h=35,r1=5,r2=20,center=true);
                }
                translate([14,0,0]) {
                    sphere(r=6);
                }
            }
        }
        translate([-height,0,0]) {
            union() {
                rotate([0,90,0]) {
                    cylinder(h=35,r1=5,r2=20,center=true);
                }
                translate([-14,0,0]) {
                    sphere(r=6);
                }
            }
        }
    }
        
        //tail
        //tiny extrude from backend of body
        translate([0,-height/1.5,-height/1.5]) {
            rotate([0,45,90]) {
               cylinder(h=18,r1=10,r2=25,center=true);
            }
        }
    }
}

module hat_full() { //the hat for the preview render
    union() {
    //base
        translate([0,0,height-(height/5)]) {
            cylinder(h=5,r1=50,r2=50,center=true);
        }
        //top part
        translate([0,0,height+20]) {
            cylinder(h=80,r1=35,r2=1,center=true);
        }
    }
}