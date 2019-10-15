// Matthew Sparks
// 2016-02-13
//
// units in 1mm
// Shim for scoped rifles in Stack-On gun cabinet model GCG-14P
// with adjustable drop section for shorter rifles
//
// Rev A - Trimmed sides flat to allow shims to be positioned in
//          adjacent slots.

// Changes the overall height of the shim.
dropDistance = 50;
// Changes the thickness of the vertical piece.
dropThickness = 8;
// Determines how far from the rear of the shim to place the vertical.
dropToBack = 40;
// Changes the length of the rear support.
rearDistance = 26;


difference(){ // trim sides
    union(){
        // top original section
        difference(){
            difference(){//cut taper
                union(){// re-add rounded edge
                    difference(){//cut curves
                        hull(){//main body
                        translate([15,0,0]){
                            cylinder(26.2,r=15,center=true);
                        }
                        translate([72.6,22.55,0]){
                            cylinder(26.2,d=9.9,center=true);
                        }
                        translate([72.6,-22.55,0]){
                            cylinder(26.2,d=9.9,center=true);
                        }
                        translate([21.4,30.8,0]){
                            cube([1,1,26.2],true);
                        }
                        translate([21.4,-30.8,0]){
                            cube([1,1,26.2],true);
                        }
                        }
                        //end main body


                        hull(){//back curve
                        translate([16.2,-26,0]){
                            cylinder(30,r=5.2,center=true);
                        }
                        translate([16.2,-40,0]){
                            cylinder(30,r=5.2,center=true);
                        }
                        translate([-20,0,0]){
                            cylinder(30,r=5.2,center=true);
                        }
                        }
                        hull(){
                        translate([16.2,26,0]){
                            cylinder(30,r=5.2,center=true);
                        }
                        translate([16.2,40,0]){
                            cylinder(30,r=5.2,center=true);
                        }
                        translate([-20,0,0]){
                            cylinder(30,r=5.2,center=true);
                        }
                        }//end back curve



                        hull(){//front curve
                        translate([94,22.55,0]){
                            cylinder(30,r=5.5,center=true);
                        }
                        translate([94,-22.55,0]){
                            cylinder(30,r=5.5,center=true);
                        }
                        translate([70.6,0,0]){
                            cylinder(30,r=14,center=true);
                        }
                        }        //end front curve
                        
                        // front edge
                        translate([84.15,0,0]){
                            cube([20,70,30],true);
                        } // end front edge
                        
                    }// end cut curves

                    // rounded edge
                    translate([72.6,22.55,0]){
                        cylinder(26.2,d=9.9,center=true);
                    }
                    translate([72.6,-22.55,0]){
                        cylinder(26.2,d=9.9,center=true);
                    } // end rounded edge
                } // end re-add rounded edge


                //taper top/bottom
                translate([-5,-32.5,13.1]){
                rotate(a=3.91,v=[0,1,0]){
                    cube([90,65,20]);
                }
                }
                translate([-5,-32.5,-33.1]){
                rotate(a=-3.91,v=[0,1,0]){
                    cube([90,65,20]);
                }
                }// end taper top/bottom
                
                // top bevel curve
                translate([5,29.5,0]){
                scale([1,0.75,1]){
                    sphere(d=40,center=true);
                }
                } // end top bevel curve

                // bottom bevel curve
                translate([5,-29.5,0]){
                scale([1,0.75,1]){
                    sphere(d=40,center=true);
                }
                } // end bottom bevel curve    
            } // end cut taper
            
            // cut off front
            translate([((dropToBack+(100-dropToBack)/2)-dropThickness)+1,0,0]){
                cube([(100-dropToBack),100,50],true);
            } // end cut off front
        }
        // end top original section

        // bottom original section
        difference(){    
            // original piece
            translate([0,0,-dropDistance]){
                difference(){//cut taper and holes
                    union(){// re-add rounded edge
                        difference(){//cut curves
                            hull(){//main body
                            translate([15,0,0]){
                                cylinder(26.2,r=15,center=true);
                            }
                            translate([72.6,22.55,0]){
                                cylinder(26.2,d=9.9,center=true);
                            }
                            translate([72.6,-22.55,0]){
                                cylinder(26.2,d=9.9,center=true);
                            }
                            translate([21.4,30.8,0]){
                                cube([1,1,26.2],true);
                            }
                            translate([21.4,-30.8,0]){
                                cube([1,1,26.2],true);
                            }
                            }
                            //end main body


                            hull(){//back curve
                            translate([16.2,-26,0]){
                                cylinder(30,r=5.2,center=true);
                            }
                            translate([16.2,-40,0]){
                                cylinder(30,r=5.2,center=true);
                            }
                            translate([-20,0,0]){
                                cylinder(30,r=5.2,center=true);
                            }
                            }
                            hull(){
                            translate([16.2,26,0]){
                                cylinder(30,r=5.2,center=true);
                            }
                            translate([16.2,40,0]){
                                cylinder(30,r=5.2,center=true);
                            }
                            translate([-20,0,0]){
                                cylinder(30,r=5.2,center=true);
                            }
                            }//end back curve



                            hull(){//front curve
                            translate([94,22.55,0]){
                                cylinder(30,r=5.5,center=true);
                            }
                            translate([94,-22.55,0]){
                                cylinder(30,r=5.5,center=true);
                            }
                            translate([70.6,0,0]){
                                cylinder(30,r=14,center=true);
                            }
                            }        //end front curve
                            
                            // front edge
                            translate([84.15,0,0]){
                                cube([20,70,30],true);
                            } // end front edge
                            
                        }// end cut curves

                        // rounded edge
                        translate([72.6,22.55,0]){
                            cylinder(26.2,d=9.9,center=true);
                        }
                        translate([72.6,-22.55,0]){
                            cylinder(26.2,d=9.9,center=true);
                        } // end rounded edge
                        
                    } // end re-add rounded edge


                    //taper top/bottom
                    translate([-5,-32.5,13.1]){
                    rotate(a=3.91,v=[0,1,0]){
                        cube([90,65,20]);
                    }
                    }
                    translate([-5,-32.5,-33.1]){
                    rotate(a=-3.91,v=[0,1,0]){
                        cube([90,65,20]);
                    }
                    }// end taper top/bottom
                    
                    // top bevel curve
                    translate([5,29.5,0]){
                    scale([1,0.75,1]){
                        sphere(d=40,center=true);
                    }
                    } // end top bevel curve

                    // bottom bevel curve
                    translate([5,-29.5,0]){
                    scale([1,0.75,1]){
                        sphere(d=40,center=true);
                    }
                    } // end bottom bevel curve    
                } // end cut taper and holes
            }   // end original piece

            // cut off rear
            translate([(dropToBack/2)-1,0,-dropDistance]){
                cube([dropToBack,100,50],true);
            } // end cut off rear
        }
        // end bottom original section
        
        // additional sections
        difference(){
            
            union(){
                // drop section
                translate([(dropToBack-(dropThickness/2)),0,-(dropDistance/2)]){
                    cube([dropThickness,70,dropDistance+50],true);
                }
                
                // rear section
                difference(){
                    translate([((dropToBack-dropThickness)-(((dropToBack-dropThickness)+rearDistance)/2)),0,-(dropDistance)]){
                        cube([((dropToBack-dropThickness)+rearDistance),80,22],true);
                    }
                    translate([-5,-50,13.1-dropDistance]){
                        rotate(a=3.91,v=[0,1,0]){
                            translate([-50,0,0]){
                                cube([150,100,25]);
                            }
                        }
                    }
                }// end rear section
            }
            
            //taper top/bottom
            translate([-5,-50,13.1]){
                rotate(a=3.91,v=[0,1,0]){
                    cube([90,100,50]);
                }
            }
            translate([-5,-50,-(dropDistance+38.1)]){
                rotate(a=-3.91,v=[0,1,0]){
                    translate([-50,0,0]){
                        cube([150,100,25]);
                    }
                }
            }
            translate([-50,31,-(dropDistance+20)]){
                cube([150,100,40]);
            }
            translate([-50,-131,-(dropDistance+20)]){
                cube([150,100,40]);
            }// end taper top/bottom
        }
        // end additional sections
    }
    
    // trim edges
    //top edge
    translate([0,0,0]){
        rotate(a=-4.203736,v=[0,0,1]){
            translate([-50,32.8,-(dropDistance+25)]){
                cube([150,65,dropDistance+50]);
            }
        }
    }
    // end top edge
    
    // bottom edge
    translate([0,0,0]){
        rotate(a=4.203736,v=[0,0,1]){
            translate([-50,-97.8,-(dropDistance+25)]){
                cube([150,65,dropDistance+50]);
            }
        }
    }
    // end bottom edge
    
    // main hole
    translate([44.3,0,0]){
    rotate([0,90,0]){
        cylinder(78.6,d=12.4,center=true);
    }
    } // end main hole
    
    // screw hole
    translate([20,0,0]){
    rotate([0,90,0]){
        cylinder(78.6,d=4.57,center=true);
    }
    } // end screw hole
}