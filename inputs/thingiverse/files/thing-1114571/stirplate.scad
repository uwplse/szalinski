$fn=100;

height    = 35;
width     = 120;
depth     = 120;
corner    = 20;
wall      = 4;
top       = 2;
bottom    = 3;
screwhole = 3;
slip      = 0.25;
fanwidth  = 80;
fanheight = 26;
fancorner = 2;
fancore   = 35;
fandip    = 1.5;

intersection(){
    translate([0,depth/2,-50]){
       //cube([200,200,200]);
    }

union(){
translate([width+10,0,-height*2]){lid();}
translate([0,depth/2+fancore,0]){fan(false);}
case();
}
}

module fan(show){
    
    translate([(width-fanwidth)/2+fancorner,(depth-fanwidth)/2+fancorner,4.5]){
        
        if(show){
        difference(){
            minkowski(){
                cube([fanwidth-fancorner*2,fanwidth-fancorner*2,fanheight]);
                cylinder(r=fancorner,h=0.01);
            }
            translate([fanwidth/2-fancorner,fanwidth/2-fancorner,-0.01]){
                cylinder(r=fanwidth/2-2,h=fanheight+0.03);
            }
        }        
        translate([-fancorner,-fancorner+fanwidth/2-3,fanheight-2]){
                cube([fanwidth,6,2]);
        }        
        translate([-fancorner+fanwidth/2-3,-fancorner,fanheight-2]){
                cube([6,fanwidth,2]);
        }
        translate([fanwidth/2-fancorner,fanwidth/2-fancorner,fandip]){
            cylinder(r=fancore/2,h=fanheight-fandip);
        }
    }
    
    //magnetcaddy
    difference(){
        translate([fanwidth/2-fancorner,fanwidth/2-fancorner,fandip-4]){
            cylinder(r=fancore/2+2,h=8);           
        }
        union(){
        translate([fanwidth/2-fancorner,fanwidth/2-fancorner,fandip]){
            cylinder(r=fancore/2+0.2,h=fanheight-fandip);
            
            for(i=[0:360/7:360]){
                rotate([0,0,i]){
                    translate([fancore/2,0,fandip+1.5]){
                        cube([6,12,6],center=true);
                    }
                }
            }
           
            translate([4.75,0,-3.6]){
                cylinder(r=4.2,h=4);
           } 
            translate([14.25,0,-3.6]){
                cylinder(r=4.2,h=4);
           }
           
           
           translate([-4.75,0,-3.6]){
                cylinder(r=4.2,h=4);
           } 
            
           translate([-14.25,0,-3.6]){
                cylinder(r=4.2,h=4);
           } 
        }
    
       


    }
}

 
        
        
        
    }
}




module lid(){
    difference(){
        translate([corner+wall/2+slip/2,corner+wall/2+slip/2,height*2]){
            minkowski(){
                cube([width-corner*2-wall-slip,depth-corner*2-wall-slip,bottom]);
                cylinder(r=corner,h=0.01);
            }
        }
        translate([0,0,height*2-0.02]){
            screwneg();
        }
    }
}


module case(){

    difference(){
        translate([corner,corner,0]){
            minkowski(){
                cube([width-corner*2,depth-corner*2,height]);
                cylinder(r=corner,h=0.01);
            }
        }

        translate([corner+wall,corner+wall,top]){
            minkowski(){
                cube([width-corner*2-wall*2,depth-corner*2-wall*2,height]);
                cylinder(r=corner,h=0.01);
            }
        }

        translate([corner+wall/2,corner+wall/2,height-bottom]){
            minkowski(){
                cube([width-corner*2-wall,depth-corner*2-wall,height]);
                cylinder(r=corner,h=0.01);
            }
        }
        
        //Magnethole
        translate([width/2,depth/2,1]){
            cylinder(r=fancore/2+2+2,h=fanheight-fandip);
        }
        
    }
    screwpos();
    
    //fanmount
    difference(){
    
        union(){    
            translate([width/2-fanwidth/2+2,depth/2-fanwidth/2+2,0]){
                cylinder(r=5,h=8);
            }
            translate([width/2+fanwidth/2-2,depth/2-fanwidth/2+2,0]){
                cylinder(r=5,h=8);
            }
            translate([width/2-fanwidth/2+2,depth/2+fanwidth/2-2,0]){
                cylinder(r=5,h=8);
            }
            translate([width/2+fanwidth/2-2,depth/2+fanwidth/2-2,0]){
                cylinder(r=5,h=8);
            }
        }
        fan(true);
    }
    
}


module screwneg(){
    v = corner*0.293+(screwhole/2+2+wall)/1.4;
    translate([v,v,0]){ screwcone(); }
    translate([width-v,v,0]){ screwcone(); }
    translate([v,depth-v,0]){ screwcone(); }
    translate([width-v,depth-v,0]){ screwcone(); }
    v2=wall+screwhole/2;
    translate([width/2,v2,0]){ screwcone(); }
    translate([width/2,depth-v2,0]){ screwcone(); }
    translate([v2,depth/2,0]){ screwcone(); }
    translate([width-v2,depth/2,0]){ screwcone(); }
}







module screwpos(){
    v = corner*0.293+(screwhole/2+2+wall)/1.4;
    translate([v,v,0]){ screwcylinder(); }
    translate([width-v,v,0]){ screwcylinder(); }
    translate([v,depth-v,0]){ screwcylinder(); }
    translate([width-v,depth-v,0]){ screwcylinder(); }
    v2=wall+screwhole/2;
    translate([width/2,v2,0]){ screwcylinder(); }
    translate([width/2,depth-v2,0]){ screwcylinder(); }
    translate([v2,depth/2,0]){ screwcylinder(); }
    translate([width-v2,depth/2,0]){ screwcylinder(); }
}

module screwcone(){
    cylinder(r1=screwhole/2, r2=screwhole/2+2,  h=bottom+0.1);   
}


module screwcylinder(){
     difference(){
        cylinder(r=screwhole/2+2,h=height-bottom); 
        translate([0,0,top]){  
            cylinder(r=screwhole/2,h=height-top);   
        }
     }
}





