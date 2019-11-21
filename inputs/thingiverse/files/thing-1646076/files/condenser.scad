$fn=10;

slack = 0.2;
slack_joint = 0.5;
pipe  = 3;
gauge = 2;
hose  = 9/2;
print_joint = true;
print_condenser = false;

tube    = pipe+slack;   //print=3.2
coolout = tube*2;   //print=6.4
coolin  = coolout-gauge;   
shift   = (coolout*2-2.5);
slope   = shift/100;    //print=9
joint   = tube+coolout+gauge*1.5;





//Joint
if(print_joint){
    difference(){
        scale([1,1,1.2]){
            sphere(r=joint,$fn=50);
        }
        union(){
            translate([0,0,shift]){midsection_extra(slack_joint);}
            translate([0,0,0]){midsection_extra(slack_joint);}
            translate([0,0,-shift]){midsection_extra(slack_joint);}
            translate([0,0,-2*shift]){midsection_extra(slack_joint);}
            translate([-25,-25,joint/1.5]){ cube([50,50,10]);}
            translate([-25,-25,-joint/1.5-10]){ cube([50,50,10]);}
        }
    }
}



if(print_condenser){
    difference(){  
        union(){
            bottom_positive();
            translate([0,0,shift])  {midsection_positive();}
            translate([0,0,shift*2]){midsection_positive();}
            translate([0,0,shift*3]){midsection_positive();}
        }
        union(){
            bottom_negative();
            translate([0,0,shift])  {midsection_negative();}
            translate([0,0,shift*2]){midsection_negative();}
            translate([0,0,shift*3]){midsection_negative();}
            
            translate([0,0,-10]){cylinder(r=tube,h=100,$fn=50);}                    
            translate([-25,-25,shift/2+shift*3]){cube([50,50,20]);}
          
        }   
    }
}



module bottom_positive(){
render(){
    for(i=[0:1:100]){
        translate([0,0,i*slope]){
            rotate([0,0,i*3.6]){
                rotate([0,90,0]){
                    translate([0,tube,0]){
                        cylinder(r=coolout,h=0.61,center=true,$fn=24);
                    }
               }
            }
        }
    }            
    rotate([0,0,0]){
        rotate([0,90,0]){
            base = pipe*2;
            translate([0,tube,base/2]){                                  
                cylinder(r=coolout,h=base,center=true,$fn=48);
            }
            translate([0,tube,5+base]){                                  
                cylinder(r=hose,h=10,center=true,$fn=48);                
                translate([0,0,3]) {scale([1,1,0.25]){ sphere(r=hose+0.5,$fn=50);}}
                translate([0,0,1]) {scale([1,1,0.25]){ sphere(r=hose+0.5,$fn=50);}}
                translate([0,0,-1]){scale([1,1,0.25]){ sphere(r=hose+0.5,$fn=50);}}
            }
        }
    }        
    translate([0,0,-coolout-3]){
        cylinder(r=pipe*2,h=coolout+3,$fn=50); 
        
    }
}
}


module bottom_negative(){
   render(){
    union(){
        for(i=[0:1:100]){
            translate([0,0,i*slope]){
                rotate([0,0,i*3.6]){
                    rotate([0,90,0]){
                        translate([0,tube,0]){                                  
                            cylinder(r=coolin,h=0.612,center=true);
                        }
                    }
                }
            }
        }
        rotate([0,0,0]){
            rotate([0,90,0]){
                translate([0,tube,20]){
                    cylinder(r=hose-gauge,h=40,center=true);
                }
            }
        }                                              
    }
      translate([0,0,-coolout-3.01]){cylinder(r=tube+1,h=3,$fn=50);}
    
 }
}




module midsection_extra(extra){
   for(i=[1:1:100]){
        translate([0,0,i*slope]){
            rotate([0,0,i*3.6]){
                rotate([0,90,0]){
                    translate([0,tube,0]){
                        cylinder(r=coolout+extra,h=0.61,center=true,$fn=24);
                    }
               }
            }
        }
    }   
}




module midsection_positive(){
  //render(){
    for(i=[1:1:100]){
        translate([0,0,i*slope]){
            rotate([0,0,i*3.6]){
                rotate([0,90,0]){
                    translate([0,tube,0]){
                        cylinder(r=coolout,h=0.61,center=true,$fn=24);
                    }
               }
            }
        }
    }
 //  }            
}


module midsection_negative(){
  // render(){
    union(){
        for(i=[1:1:100]){
            translate([0,0,i*slope]){
                rotate([0,0,i*3.6]){
                    rotate([0,90,0]){
                        translate([0,tube,0]){                                  
                            cylinder(r=coolin,h=0.612,center=true);
                        }
                    }
                }
            }
        }
    }       
//}
}





