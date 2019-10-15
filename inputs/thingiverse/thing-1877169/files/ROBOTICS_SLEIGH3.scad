//preview[view:west]
Render_Quality = 50; // [50:10:150]

$fn = Render_Quality;

View_Mode = 4; // [1:main body,2:gift basket bottom,3:gift basket top,4:assembled view,5:None]
Top_of_Gift_Basket = 3; // [1:Yes, 2: No,3:None]

module main_body(){
  /*  
  difference(){
    difference(){
        cylinder(r=20, h=20, center = true);
        translate([-10,0,0]){
            cube([20,40,40],center=true);
        }
    }
    difference(){
        scale([.9,.9,1.1]){
            cylinder(r=20, h=20, center = true);
        }
        translate([-10,0,0]){
                cube([20,40,40],center=true);
            }
        }
     
}  // this made the bottom part of the gift holder
    */

cube([2,45,25],center=true); //the back support


translate([-2.5,-19,-2.5]){
    cube([5,2,20],center=true);
}//just a connector part for the looks
translate([-2.5,19,-2.5]){
    cube([5,2,20],center=true);
}//connector part 

translate([-14,0,-13]){
cube([30,50,5],center= true);
} //bottom part of sleigh where you'd put your feet

difference(){
translate([01,0,1.05]){
difference(){
difference(){
        difference(){
            translate([-30,0,-7]){
                rotate([90,0,0]){
                    cylinder(r=9.6,h=50, center = true);
                }
            }
            translate([-5,0,0]){
            cube([50,60,40],center=true);
            }
        }
        translate([-2,0,-2]){
            
                difference(){
                    scale([1.07,1,1]){
                    translate([-26,0,-4.6]){
                        rotate([90,0,0]){
                            cylinder(r=5,h=52, center = true);
                        }
                    }
                }
                    translate([-4.9,0,0]){
                   cube([46,60,40],center=true);
                    }
                }
        
    }   
}

translate([-30,0,20]){
cube([50,60,50],center = true);
}
}
} 
translate([-32,0,7]){
    rotate([0,-40,0]){
        cube([40,55,20],center = true);
    }
}
}


union(){
translate([-10,0,-8]){
    cube([20,35,5],center=true);
}// the seat part
 translate([-13,0,-5]){ 
    cube([8,4,2],center=true);
    intersection(){
            difference(){
            translate([0,0,1]){
                sphere(r=4,center=true);
            }
            translate([0,0,1]){
                scale([.9,.9,.9]){
                    sphere(r=4,center=true);
                }
            }
        }
        translate([0,0,20]){
            cube([40,1.5,40],center=true);
        }
    }
} 
translate([-13,0,-4]){
intersection(){
    sphere(r=4,center = true);
    translate([0,0,2]){
        cube([1,1,9],center = true);
    }
}
}
}



translate([-3,-20,-15]){
    cube([3,3,5],center=true);
}//little legs coming off of the bottom of the sleigh
translate([-28,20,-15]){
    cube([3,3,5],center=true);
}//little legs
translate([-28,-20,-15]){
    cube([3,3,5],center=true);
}//little legs
translate([-3,20,-15]){
    cube([3,3,5],center=true);
}//little legs


translate([-20,-20,-17.5]){
    cube([40,5,1],center=true);
}// the ski part of the sleigh
translate([-20,20,-17.5]){
    cube([40,5,1],center=true);
}//ski part

difference(){
translate([-40,-20,-14]){
    difference(){
    difference(){
        difference(){
            translate([0,0,0]){
                rotate([90,0,0]){
                    cylinder(r=4,h=5,center=true);
                }
            }

                translate([0,0,0]){
                    scale([.75,1.1,.75]){
                        rotate([90,0,0]){
                            cylinder(r=4,h=5,center=true);
                        }
                }
            }
        }
        translate([00,0,10]){
            cube([20,20,20],center = true);
        }
    }
    translate([0,-6,-10]){
        cube([5,10,20]);
    }
}
}//the front curved part of a ski
translate([-36,0,3]){
    rotate([0,-40,0]){
        cube([40,55,20],center = true);
    }
}
}
difference(){
 translate([-40,20,-14]){
     difference(){
    difference(){
        difference(){
            translate([0,0,0]){
                rotate([90,0,0]){
                    cylinder(r=4,h=5,center=true);
                }
            }

                translate([0,0,0]){
                    scale([.75,1.1,.75]){
                        rotate([90,0,0]){
                            cylinder(r=4,h=5,center=true);
                        }
                }
            }
        }
        translate([10,0,0]){
            cube([20,20,20],center = true);
        }
    }
    translate([00,0,10]){
            cube([20,20,20],center = true);
        }
    translate([0,-6,-10]){
        cube([5,10,20]);
    }
}
}//the front curved part of a ski
translate([-36,0,3]){
    rotate([0,-40,0]){
        cube([40,55,20],center = true);
    }
}
}


/*
translate([0,0,-10]){
    difference(){
            cylinder(r=20, h=2, center = true);
            translate([-10,0,0]){
                cube([20,40,40],center=true);
            }
        }
}//bottom part of basket to make sure presents dont fall out


union(){
translate([0,0,10]){
    difference(){
        scale([1,1,1]){
            difference(){
                difference(){
                    sphere(r=20,center=true);
                    translate([0,0,-10]){
                        cube([50,50,20],center=true);
                    }
                }
                translate([-10,0,0]){
                    cube([20,50,50],center = true);
                }
            } 
        } 
        translate([.5,0,-.1]){
            scale([.9,.9,.9]){
                scale([1,1,1]){
                    difference(){
                        difference(){
                            sphere(r=20,center=true);
                            translate([0,0,-10]){
                                cube([50,50,20],center=true);
                            }
                        }
                        translate([-10,0,0]){
                            cube([20,50,50],center = true);
                        }
                    } 
                } 
            }
        }
       
    }
        
}// top part of the basket 
}
*/
for(xx = [-5,-15,-25]){
    for(yy = [-10,0,10]){
        for(zz = [-15]){
            translate([xx,yy,zz]){
cube([3,3,6],center=true);
            }
        }
    }
}
}


 








 
module gift_basket_bottom(){
    
    difference(){
    difference(){
        cylinder(r=20, h=20, center = true);
        translate([-10,0,0]){
            cube([20,40,40],center=true);
        }
    }
    difference(){
        scale([.8,.8,1.1]){
            cylinder(r=20, h=20, center = true);
        }
        translate([-10,0,0]){
                cube([20,40,40],center=true);
            }
        }
     
}  // this made the bottom part of the gift holder
translate([0,0,-10]){
    difference(){
            cylinder(r=20, h=2, center = true);
            translate([-10,0,0]){
                cube([20,40,40],center=true);
            }
        }
}//bottom part of basket to make sure presents dont fall out
}

module gift_basket_top(){
    translate([0,0,-10]){
    union(){
translate([0,0,10]){
    difference(){
        scale([1,1,1]){
            difference(){
                difference(){
                    sphere(r=20,center=true);
                    translate([0,0,-10]){
                        cube([50,50,20],center=true);
                    }
                }
                translate([-10,0,0]){
                    cube([20,50,50],center = true);
                }
            } 
        } 
        translate([2,0,-.1]){
            scale([.8,.8,.8]){
                scale([1,1,1]){
                    difference(){
                        difference(){
                            sphere(r=20,center=true);
                            translate([0,0,-10]){
                                cube([50,50,20],center=true);
                            }
                        }
                        translate([-10,0,0]){
                            cube([20,50,50],center = true);
                        }
                    } 
                } 
            }
        }
       
    }
        
}// top part of the basket 
}
}
}


module assembled_view(){
    difference(){
    difference(){
        cylinder(r=20, h=20, center = true);
        translate([-10,0,0]){
            cube([20,40,40],center=true);
        }
    }
    difference(){
        scale([.9,.9,1.1]){
            cylinder(r=20, h=20, center = true);
        }
        translate([-10,0,0]){
                cube([20,40,40],center=true);
            }
        }
     
}  // this made the bottom part of the gift holder

cube([2,45,25],center=true); //the back support


translate([-2.5,-19,-2.5]){
    cube([5,2,20],center=true);
}//just a connector part for the looks
translate([-2.5,19,-2.5]){
    cube([5,2,20],center=true);
}//connector part 

translate([-14,0,-13]){
cube([30,50,5],center= true);
} //bottom part of sleigh where you'd put your feet


difference(){
translate([01,0,1.05]){
difference(){
difference(){
        difference(){
            translate([-30,0,-7]){
                rotate([90,0,0]){
                    cylinder(r=9.6,h=50, center = true);
                }
            }
            translate([-5,0,0]){
            cube([50,60,40],center=true);
            }
        }
        translate([-2,0,-2]){
            
                difference(){
                    scale([1.07,1,1]){
                    translate([-26,0,-4.6]){
                        rotate([90,0,0]){
                            cylinder(r=5,h=52, center = true);
                        }
                    }
                }
                    translate([-4.9,0,0]){
                   cube([46,60,40],center=true);
                    }
                }
        
    }   
}

translate([-30,0,20]){
cube([50,60,50],center = true);
}
}
} 
translate([-32,0,7]){
    rotate([0,-40,0]){
        cube([40,55,20],center = true);
    }
}
}


union(){
translate([-10,0,-8]){
    cube([20,35,5],center=true);
}// the seat part
 translate([-13,0,-5]){ 
    cube([8,4,2],center=true);
    intersection(){
            difference(){
            translate([0,0,1]){
                sphere(r=4,center=true);
            }
            translate([0,0,1]){
                scale([.9,.9,.9]){
                    sphere(r=4,center=true);
                }
            }
        }
        translate([0,0,20]){
            cube([40,1.5,40],center=true);
        }
    }
} 
translate([-13,0,-4]){
intersection(){
    sphere(r=4,center = true);
    translate([0,0,2]){
        cube([1,1,9],center = true);
    }
}
}
}



translate([-3,-20,-15]){
    cube([3,3,5],center=true);
}//little legs coming off of the bottom of the sleigh
translate([-28,20,-15]){
    cube([3,3,5],center=true);
}//little legs
translate([-28,-20,-15]){
    cube([3,3,5],center=true);
}//little legs
translate([-3,20,-15]){
    cube([3,3,5],center=true);
}//little legs


translate([-20,-20,-17.5]){
    cube([40,5,1],center=true);
}// the ski part of the sleigh
translate([-20,20,-17.5]){
    cube([40,5,1],center=true);
}//ski part

difference(){
translate([-40,-20,-14]){
    difference(){
    difference(){
        difference(){
            translate([0,0,0]){
                rotate([90,0,0]){
                    cylinder(r=4,h=5,center=true);
                }
            }

                translate([0,0,0]){
                    scale([.75,1.1,.75]){
                        rotate([90,0,0]){
                            cylinder(r=4,h=5,center=true);
                        }
                }
            }
        }
        translate([00,0,10]){
            cube([20,20,20],center = true);
        }
    }
    translate([0,-6,-10]){
        cube([5,10,20]);
    }
}
}//the front curved part of a ski
translate([-36,0,3]){
    rotate([0,-40,0]){
        cube([40,55,20],center = true);
    }
}
}
 difference(){
 translate([-40,20,-14]){
     difference(){
    difference(){
        difference(){
            translate([0,0,0]){
                rotate([90,0,0]){
                    cylinder(r=4,h=5,center=true);
                }
            }

                translate([0,0,0]){
                    scale([.75,1.1,.75]){
                        rotate([90,0,0]){
                            cylinder(r=4,h=5,center=true);
                        }
                }
            }
        }
        translate([10,0,0]){
            cube([20,20,20],center = true);
        }
    }
    translate([00,0,10]){
            cube([20,20,20],center = true);
        }
    translate([0,-6,-10]){
        cube([5,10,20]);
    }
}
}//the front curved part of a ski
translate([-36,0,3]){
    rotate([0,-40,0]){
        cube([40,55,20],center = true);
    }
}
}



translate([0,0,-10]){
    difference(){
            cylinder(r=20, h=2, center = true);
            translate([-10,0,0]){
                cube([20,40,40],center=true);
            }
        }
}//bottom part of basket to make sure presents dont fall out


union(){
translate([0,0,10]){
    difference(){
        scale([1,1,1]){
            difference(){
                difference(){
                    sphere(r=20,center=true);
                    translate([0,0,-10]){
                        cube([50,50,20],center=true);
                    }
                }
                translate([-10,0,0]){
                    cube([20,50,50],center = true);
                }
            } 
        } 
        translate([.5,0,-.1]){
            scale([.9,.9,.9]){
                scale([1,1,1]){
                    difference(){
                        difference(){
                            sphere(r=20,center=true);
                            translate([0,0,-10]){
                                cube([50,50,20],center=true);
                            }
                        }
                        translate([-10,0,0]){
                            cube([20,50,50],center = true);
                        }
                    } 
                } 
            }
        }
       
    }
        
}// top part of the basket 
}

for(xx = [-5,-15,-25]){
    for(yy = [-10,0,10]){
        for(zz = [-15]){
            translate([xx,yy,zz]){
cube([3,3,6],center=true);
            }
        }
    }
}
}
module None(){
    difference(){
        cube([4,4,4]);
        cube([4,4,4]);
    }
}
module None2(){
    difference(){
    cube([5,5,5]);
    cube([5,5,5]);
    }
}
module Yes(){
    main_body();
    translate([5,0,-7]){
        gift_basket_bottom();
    }
    translate([30,0,-18]){
        gift_basket_top();
    }
}
module No(){
    main_body();
    translate([5,0,-7]){
        gift_basket_bottom();
    }
}

if (View_Mode == 1){
    main_body();
}
if(View_Mode == 2){
    gift_basket_bottom();
}
if(View_Mode == 3){
    gift_basket_top();
}
if(View_Mode == 4){
    assembled_view();
}
if(View_Mode == 5){
    None();
}


if(Top_of_Gift_Basket ==1){
    Yes();
}
if(Top_of_Gift_Basket ==2){
    No();
}
if(Top_of_Gift_Basket == 3){
    None2();
}

