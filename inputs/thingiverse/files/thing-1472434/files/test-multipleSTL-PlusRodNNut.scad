// Choose your part!
part = "first"; // [first:Board Holder,second:Rod Drop,third:Bottle Holder,all:All]

/////// Params

// Board Holder Only. Consider this lenght will be 5mm less on the x and y axis due to the curvature
lenght=70; // [70:200]

// Board Holder Only. Height of the board. Allow 1mm extra for easy fit.
board_size=11; // [3:20]

// Board Holder Only. Space bewteen honeycomb
w=1; // [1,2,3,4,5]

// Board Holder Only. Size of the hexagons
d=4; // [4:2:20]

// Bottle Holder Only. Height of the bottom part
tall=17; // [10:30]

// Bottle Holder Only. Thickness of the spirals
spiral=2; // [2:0.1:3]

// Bottle Holder Only. Radius of the bottom part. Minimum is 8.5 mm and maximum is 10 mm.
radius=9; 


// ignore this variable!
dx=d*sin(360/6);
h=50;
x=200;
y=200;


/////// Print part

print_part();

module print_part() {
	if (part == "first") {
		board_holder();
	} else if (part == "second") {
		rod_drop();
	} else if (part == "third") {
		bottle_holder();
	} else if (part == "all") {
		all();
	} else {
		all();
	}
}

//////// modules

module rod_drop () {
    difference () {
         rotate ([0,180,0]) {
             translate ([20,20,-5]) {
                hull () {
                    cylinder (5,14.5,17);
                    translate ([-14.5,-14.5,0]) {
                        cylinder (5,1,1);
                    }
                }
            }
        }
        translate ([-20,20,0]) {
            cylinder (5,14,14);
        }
    }

    union () {
        translate ([-20,20,0]){
            intersection () {
                import ("Nut_v6.stl");
                cylinder (5,14,14);
            }
        }
    }
    
}



module bottle_holder() {
	translate ([0,0,tall+8]) {
        rotate ([0,180,0]) {
            difference () {
                union () {
                    /////top
                    translate ([0,0,tall]){
                        difference () {
                            import ("Rod_v6.stl");
                            translate ([-15,-15,8]) {
                                cube ([30,30,9]);
                            }
                        }
                    }
                
                    /////bottom
                    $fn=30;
                        cylinder (tall,radius,radius);
                      
                    linear_extrude(height = tall, center = false, convexity = 10, twist = 720, $fn = 20)
                    translate([radius-1.7, 0, 0])
                    circle(r = spiral);
                        
                    rotate ([0,0,90]) {
                        linear_extrude(height = tall, center = false, convexity = 10, twist = 720, $fn = 20)
                        translate([radius-1.7, 0, 0])
                        circle(r = spiral);
                    }
                    
                    rotate ([0,0,180]) {
                        linear_extrude(height = tall, center = false, convexity = 10, twist = 720, $fn = 20)
                        translate([radius-1.7, 0, 0])
                        circle(r = spiral);
                    }
                    
                    rotate ([0,0,270]) {
                        linear_extrude(height = tall, center = false, convexity = 10, twist = 720, $fn = 20)
                        translate([radius-1.7, 0, 0])
                        circle(r = spiral);
                    }
                }
                
            
            cylinder (tall+10,7.8,7.8);
                
            }
        }
    }
}



module board_holder() {
	intersection () {
        union () {
         /// side
            union () {
                cube ([1,lenght,board_size+5]); 
                cube ([lenght,1,board_size+5]); 
            }
            
            
        /// base    
            union () {
                difference () {
                    cube ([lenght,lenght,5]);
                    translate ([32/1.1,32/1.1,0]) {
                                hull () {
                                    cylinder (5,14.5,17);
                                    translate ([-14.5,-14.5,0]) {
                                        cylinder (5,1,1);
                                }
                    }
                }
            }
        }
        
        /// top
            union () {
                difference () {
                    union () {
                        translate ([0,0,board_size+4]) {  
                            difference () {
                                cube ([lenght,lenght,1]);
                                
                            }
                        }
                    }
                    
                    union () {
                    translate ([5,5,0]) {
                        union () {
                                for (j=[0:2:y/(d)])
                                for (i=[0:x/(dx)]) {
                                    translate ([i*(dx+w), j*(d+w), -1]) {
                                        rotate ([0,0,360/6/2]) {
                                            cylinder (h+2,d/2,d/2, $fn=6);
                                        }
                                    }
                                    translate ([i*(dx+w)+(dx+w)/2, (j+1)*(d+w), -1]) {
                                        rotate ([0,0,360/6/2]) {
                                            cylinder (h+2,d/2,d/2,$fn=6);
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        
        $fn=100;
        sphere (lenght-5);
}
}


module all() {
	rotate ([90,0,0]) {
 intersection () {
        union () {
         /// side
            union () {
                cube ([1,lenght,board_size+5]); 
                cube ([lenght,1,board_size+5]); 
            }
            
            
        /// base    
            union () {
                difference () {
                    cube ([lenght,lenght,5]);
                    translate ([32/1.1,32/1.1,0]) {
                                hull () {
                                    cylinder (5,14.5,17);
                                    translate ([-14.5,-14.5,0]) {
                                        cylinder (5,1,1);
                                }
                    }
                }
            }
        }
        
        /// top
            union () {
                difference () {
                    union () {
                        translate ([0,0,board_size+4]) {  
                            difference () {
                                cube ([lenght,lenght,1]);
                                
                            }
                        }
                    }
                    
                    union () {
                    translate ([5,5,0]) {
                        union () {
                                for (j=[0:2:y/(d)])
                                for (i=[0:x/(dx)]) {
                                    translate ([i*(dx+w), j*(d+w), -1]) {
                                        rotate ([0,0,360/6/2]) {
                                            cylinder (h+2,d/2,d/2, $fn=6);
                                        }
                                    }
                                    translate ([i*(dx+w)+(dx+w)/2, (j+1)*(d+w), -1]) {
                                        rotate ([0,0,360/6/2]) {
                                            cylinder (h+2,d/2,d/2,$fn=6);
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        
        $fn=100;
        sphere (lenght-5);
}
}



translate ([40,40,5]) {
    rotate ([180,0,0]) {
        difference () {
         rotate ([0,180,0]) {
             translate ([20,20,-5]) {
                hull () {
                    cylinder (5,14.5,17);
                    translate ([-14.5,-14.5,0]) {
                        cylinder (5,1,1);
                    }
                }
            }
        }
        translate ([-20,20,0]) {
            cylinder (5,14,14);
        }
    }

    union () {
        translate ([-20,20,0]){
            intersection () {
                import ("Nut_v6.stl");
                cylinder (5,14,14);
            }
        }
    }
    }
}

translate ([55,20,25]) {
    rotate ([180,0,0]) {
translate ([0,0,tall+8]) {
        rotate ([0,180,0]) {
            difference () {
                union () {
                    /////top
                    translate ([0,0,tall]){
                        difference () {
                            import ("Rod_v6.stl");
                            translate ([-15,-15,8]) {
                                cube ([30,30,9]);
                            }
                        }
                    }
                
                    /////bottom
                    $fn=30;
                        cylinder (tall,radius,radius);
                      
                    linear_extrude(height = tall, center = false, convexity = 10, twist = 720, $fn = 20)
                    translate([radius-1.7, 0, 0])
                    circle(r = spiral);
                        
                    rotate ([0,0,90]) {
                        linear_extrude(height = tall, center = false, convexity = 10, twist = 720, $fn = 20)
                        translate([radius-1.7, 0, 0])
                        circle(r = spiral);
                    }
                    
                    rotate ([0,0,180]) {
                        linear_extrude(height = tall, center = false, convexity = 10, twist = 720, $fn = 20)
                        translate([radius-1.7, 0, 0])
                        circle(r = spiral);
                    }
                    
                    rotate ([0,0,270]) {
                        linear_extrude(height = tall, center = false, convexity = 10, twist = 720, $fn = 20)
                        translate([radius-1.7, 0, 0])
                        circle(r = spiral);
                    }
                }
                
            
            cylinder (tall+10,7.8,7.8);
                
            }
        }
    }
}
}
}
