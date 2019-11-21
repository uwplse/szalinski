//move the parts seperate for easy viewing
view_extend =10;

//airfoil - camber 0 = symmetrical foil
naca1 =.035;//

//airfoil -foil max thickness along chord .5= midchord
naca2 =.33;//

//airfoil thickness multiplier-  .11-.40 recommended
naca3 = .25;//

//Total Wing length
length=300;//

//base section chord
chord = 120;//


//Wing Dihedral angle
wing_camber = 5;//


//center section - percentage of total wing length
sec_length1 = .125;//
//center section Sweep & scale
sec_sweep1 = -70;//
sec_scale1 = .7;//


//inner wing - percentage of total wing length
sec_length2 = .125;///////
//inner wing Sweep & scale
sec_sweep2 = -150;//
sec_scale2 = .90;//


//main wing- percentage of total wing length
sec_length3 = .5;//////
//iner section Sweep & scale
sec_sweep3 = -190;//
sec_scale3 = .70;//


//wingtip - percentage of total wing length
sec_length4 = .25;/////
//iner section Sweep & scale
sec_sweep4 = -110;//
sec_scale4 = .70;//

//////Include Wing Spars 1- yes 0- no
///////spars=1;//[0:1]

//quantity of spars
quansparsw=4;//[2,4,6] 


//skin thickness
skin_thick = .7;

//Spar and Rib thickness
brace_thick = 3;


//show the skin  1=yes 0=no
skin=0;//[0:1]


//Flaperon - Percentage of wing chord the control surfaces take.
flap_Size = 25;



flapsz = flap_Size/100;
flapaft=chord-chord*flapsz;
//


spread(wing_camber);


module spread(wing_camber){
rotate([90-wing_camber,0,0]){full_wing(chord,sec_sweep1,sec_scale1,sec_sweep2,sec_scale2,sec_sweep3,sec_scale3,sec_sweep4,sec_scale4,skin_thick,brace_thick,naca1,naca2,naca3,quansparsw,skin);}
mirror([0,1])
translate([0,0-view_extend,0]){
rotate([90-wing_camber,0,0]){full_wing(chord,sec_sweep1,sec_scale1,sec_sweep2,sec_scale2,sec_sweep3,sec_scale3,sec_sweep4,sec_scale4,skin_thick,brace_thick,naca1,naca2,naca3,quansparsw,skin);}}
}
module full_wing(chord,sec_sweep1,sec_scale1,sec_sweep2,sec_scale2,sec_sweep3,sec_scale3,sec_sweep4,sec_scale4,skin_thick,brace_thick,naca1,naca2,naca3,quansparsw,skin){
translate([0,0,0]){
    wing_section(1,chord,sec1l,sec_sweep1,sec_scale1,skin_thick,brace_thick,naca1,naca2,naca3,quansparsw,skin);
    }
    sec1l=sec_length1*length;
    echo(sec1l,sec2l,sec3l,sec4l);
    sec1pos = 1-sec_scale1;
    sec1posa = -sec_sweep1*sec1pos;
    sec1posb= sec1posa*sec_scale1;
    chord2 = chord*sec_scale1;
    
translate([sec1posb,0,sec1l+view_extend]){
 wing_section(1,chord2,sec2l,sec_sweep2,sec_scale2,skin_thick,brace_thick,naca1,naca2,naca3,quansparsw,skin);
  }
    sec2l=sec_length2*length;
    sec2pos = 1-sec_scale2;
    sec2posa = -sec2pos*sec_sweep2;
    sec2posb= sec2posa*sec_scale2;
    sec2tsl = sec2posa+sec1posa;
    chord3 = chord2*sec_scale2;
    
translate([sec2posb+sec1posb,0,sec1l+sec2l+view_extend+view_extend]){
wing_section(2,chord3,sec3l,sec_sweep3,sec_scale3,skin_thick,brace_thick,naca1,naca2,naca3,quansparsw,skin);}
    
    sec3l=sec_length3*length;
    sec3pos = 1-sec_scale3;
    sec3posa = -sec3pos*sec_sweep3;
    sec3posb= sec3posa*sec_scale3;
    sec3tsl =sec2tsl+sec3posa;
    chord4 = chord3*sec_scale3;
    
translate([sec2posb+sec1posb+sec3posb,0,sec1l+sec2l+sec3l+view_extend+view_extend+view_extend]){
    wing_section(1,chord4,sec4l,sec_sweep4,sec_scale4,skin_thick,brace_thick,naca1,naca2,naca3,quansparsw,skin);
    }
    sec4l=sec_length4*length;
    sec4pos = 1-sec_scale4;
    sec4posa = -sec4pos*sec_sweep4;
    sec4posb= sec4posa*sec_scale4;
    sec4tsl =sec3tsl+sec4posa;
}
    
    


//

module wing_section(sectype,chord,sec_length,sec_sweep,sec_scale,skin_thick,brace_thick,naca1,naca2,naca3,quansparsw,skin){
    if (sectype==1){
        solid_section(chord,sec_length,sec_sweep,sec_scale,skin_thick,brace_thick,naca1,naca2,naca3,quansparsw,skin);
        }
    if (sectype==2){
        cs_section(chord,sec_length,sec_sweep,sec_scale,naca1,naca2,naca3,flapsz,brace_thick,skin_thick);
        }
    else {}
    }


//
module solid_section(chord,sec_length,sec_sweep,sec_scale,skin_thick,brace_thick,naca1,naca2,naca3,quansparsw,skin){
//inner bulkhead
    translate([0,0,0]){
        outline_bulkhead3d(chord,naca1,naca2,naca3,brace_thick,skin_thick);
        }
///Lengthwise Spar
    translate([-sec_sweep*sec_scale,0]){
        linear_extrude(sec_length,convexity = 10,scale = [sec_scale,sec_scale])
            translate([sec_sweep*sec_scale,0,0])
            length_braces(chord,brace_thick,skin_thick,quansparsw,naca1,naca2,naca3,brace_thick);
            }
///Skin
    if(skin==1){
    translate([-sec_sweep*sec_scale,0,skin_thick]){
        linear_extrude(sec_length,convexity = 10,scale = [sec_scale,sec_scale])
            translate([sec_sweep*sec_scale,0,0])
        outline_bulkhead(chord,naca1,naca2,naca3,skin_thick);
            }
            
            }else {;}
    //End cap Position math
    pos = 1-sec_scale;
    posa= -sec_sweep*pos;
    posb= posa*sec_scale;
    chord2 =chord*sec_scale;
    ////        
/////End Bulkhead
    translate([posb,0,sec_length]){
        outline_bulkhead3d(chord2,naca1,naca2,naca3,brace_thick*sec_scale,skin_thick);
        } 
        
    }
// 
  //cs_skin_wall(chord,naca1,naca2,naca3,flapsz,skin_thick,sec_scale1); 
  
        
module cs_skin_wall(chord,naca1,naca2,naca3,flapsz,skin_thick,sec_scale){
      union(){
    difference(){
  cs(chord,0,0,naca1,naca2,naca3,flapsz,brace_thick,skin_thick);
  cs(chord-skin_thick*8,0,0,naca1,naca2,naca3,flapsz,brace_thick,skin_thick);}
  flapaft=chord-chord*flapsz;
   translate([flapaft,flapaft*naca1]){
       difference(){
            circle(chord*naca3*flapsz,$fn=36);
           circle(chord*naca3*flapsz-skin_thick,$fn=36);}
            
        }}
    difference(){
                translate([flapaft,flapaft*naca1]){
                circle(chord*naca3*flapsz+skin_thick*3,$fn=36);}
                cs_inner_bulkhead_knockout(chord,naca1,naca2,naca3,flapsz,skin_thick);
            }
        }            
//

//cs_section(chord,50,-250,.5,naca1,naca2,naca3,flapsz,brace_thick,skin_thick); 
        
//
 module cs_section(chord,sec_length,sec_sweep,sec_scale,naca1,naca2,naca3,flapsz,brace_thick,skin_thick){ 
    pos = 1-sec_scale;
    posa= -sec_sweep*pos;
    posb= posa*sec_scale;
    chord2 =chord*sec_scale;
////  end cap
translate([posb,0,sec_length+skin_thick]){
   mirror([0,0,1])
 cs_combined_mount(chord2,sec_length,sec_sweep,sec_scale,naca1,naca2,naca3,flapsz,brace_thick,skin_thick);
    }
///
///Lengthwise Spar
    translate([-sec_sweep*sec_scale,0,skin_thick*4]){
        linear_extrude(sec_length-skin_thick*8,convexity = 10,scale = [sec_scale,sec_scale])
            translate([sec_sweep*sec_scale,0,0])
            length_braces(chord,brace_thick,skin_thick,quansparsw,naca1,naca2,naca3,brace_thick);
            }
///Skin
    if(skin==1){
    translate([-sec_sweep*sec_scale,0,skin_thick*5]){
        linear_extrude(sec_length-skin_thick*9,convexity = 10,scale = [sec_scale,sec_scale])
            translate([sec_sweep*sec_scale,0,0])
        union(){
      cs_skin_wall(chord,naca1,naca2,naca3,flapsz,skin_thick);
    
    intersection(){
            cs_mount_bulkheadc(chord,naca1,naca2,naca3,flapsz,brace_thick,skin_thick);
            outline_bulkhead(chord,naca1,naca2,naca3,skin_thick);
        }
    }    
       
            
            }
            }else {;}
///  base  
translate(0,0,0){
 cs_combined_mount(chord,sec_length,sec_sweep,sec_scale,naca1,naca2,naca3,flapsz,brace_thick,skin_thick);}
 }   
//


// 
module cs_combined_mount(chord,sec_length,sec_sweep,sec_scale,naca1,naca2,naca3,flapsz,brace_thick,skin_thick){ 
    //
    cs_mount_bulkheada3d(chord,sec_length,sec_sweep,sec_scale,naca1,naca2,naca3,flapsz,brace_thick,skin_thick);    
    //
    translate([0,0,skin_thick]){
      cs_mount_bulkheadb3d(chord,sec_length,sec_sweep,sec_scale,naca1,naca2,naca3,flapsz,brace_thick-1,skin_thick);
      }
    //
    translate([0,0,skin_thick*3]){  
      cs_mount_bulkheadc3d(chord,sec_length,sec_sweep,sec_scale,naca1,naca2,naca3,flapsz,brace_thick-1,skin_thick);
      }
      //
    translate([0,0,skin_thick*4]){  
        cs_mount_bulkheadc3d(chord,sec_length,sec_sweep,sec_scale,naca1,naca2,naca3,flapsz,brace_thick-1,skin_thick);
        }
    translate([0,0,skin_thick*4]){ 
        cs3d(chord,naca1,naca2,naca3,brace_thick,skin_thick,,sec_sweep,sec_scale);
        }
    //
      }
//
module cs_mount_bulkheada3d(chord,sec_length,sec_sweep,sec_scale,naca1,naca2,naca3,flapsz,brace_thick,skin_thick){
    linear_extrude(skin_thick*1,scale = [1,1])
cs_mount_bulkheada(chord,naca1,naca2,naca3,flapsz,brace_thick,skin_thick);}

//
module cs_mount_bulkheadb3d(chord,sec_length,sec_sweep,sec_scale,naca1,naca2,naca3,flapsz,brace_thick,skin_thick){
    linear_extrude(skin_thick*2)
cs_mount_bulkheadb(chord,naca1,naca2,naca3,flapsz,brace_thick,skin_thick);}

//
module cs_mount_bulkheadc3d(chord,sec_length,sec_sweep,sec_scale,naca1,naca2,naca3,flapsz,brace_thick,skin_thick){
    linear_extrude(skin_thick)
cs_mount_bulkheadc(chord,naca1,naca2,naca3,flapsz,brace_thick,skin_thick);}

//  
 module cs_mount_bulkheada(chord,naca1,naca2,naca3,flapsz,brace_thick,skin_thick){
     //outline_bulkhead(chord,naca1,naca2,naca3,brace_thick,skin_thick);
     flapaft=chord-chord*flapsz;
     difference(){
     solid_bulkhead(chord,naca1,naca2,naca3);
    translate([flapaft,flapaft*naca1]){
        circle(2,$fn=36);}}
        translate([flapaft,flapaft*naca1]){
        circle(.25,$fn=36);}
     }  
//// 
 module cs_mount_bulkheadb(chord,naca1,naca2,naca3,flapsz,brace_thick,skin_thick){
     //outline_bulkhead(chord,naca1,naca2,naca3,brace_thick,skin_thick);
     flapaft=chord-chord*flapsz;
     difference(){
     solid_bulkhead(chord,naca1,naca2,naca3);
    translate([flapaft,flapaft*naca1]){
        circle(2,$fn=36);}}
        translate([flapaft,flapaft*naca1]){
        circle(1.5,$fn=36);}
     }  
//
 module cs_mount_bulkheadc(chord,naca1,naca2,naca3,flapsz,brace_thick,skin_thick){
     flapaft=chord-chord*flapsz;
     
     translate([flapaft,flapaft*naca1]){
                circle(1.5,$fn=36);}
     union(){
        difference(){
            outline_bulkhead(chord,naca1,naca2,naca3,brace_thick);
            cs_inner_bulkhead_knockout(chord,naca1,naca2,naca3,flapsz,skin_thick);
            }
        difference(){
            translate([flapaft,flapaft*naca1]){
                circle(chord*naca3*flapsz+skin_thick*3,$fn=36);}
                cs_inner_bulkhead_knockout(chord,naca1,naca2,naca3,flapsz,skin_thick);
            }    
        }
    }
 
//     
module outline_bulkhead3d(chord,naca1,naca2,naca3,brace_thick,skin_thick){
    linear_extrude(skin_thick)
            difference(){
                outline_bulkhead(chord,naca1,naca2,naca3,brace_thick);
                airfoil_solid_knockout(chord,naca1,naca2,naca3);
        }
    }    
//    
module outline_bulkhead(chord,naca1,naca2,naca3,bulk_thick){
   
        difference(){
            solid_bulkhead(chord,naca1,naca2,naca3);
            translate([bulk_thick,bulk_thick]){
                solid_bulkhead(chord,naca1,naca2,naca3);
                }
            }
         difference(){
            solid_bulkhead(chord,naca1,naca2,naca3);
            translate([bulk_thick,-bulk_thick]){
                solid_bulkhead(chord,naca1,naca2,naca3);
                }
            }   
        }
  
//
module solid_bulkhead3d(chord,naca1,naca2,naca3,skin_thick){
linear_extrude(skin_thick)
            difference(){  
                solid_bulkhead(chord,naca1,naca2,naca3);
                airfoil_solid_knockout(chord,naca1,naca2,naca3,brace_thick);
                }
            }
//
            
//            
module solid_bulkhead(chord,naca1,naca2,naca3){
    base_airfoil(chord,naca1,naca2,naca3);
    }

//

module cs_knockout(chord,naca1,naca2,naca3,flapsz,brace_thick){
    airfoil_solid_knockout(chord,naca1,naca2,naca3);
    flapaft=chord-chord*flapsz;
    translate([flapaft,flapaft*naca1]){
        difference(){
            translate([-chord,-chord/2]){square([chord,chord]);}
            circle(chord*naca3*flapsz,$fn=36);
            
            }
        }
    }

//    
module cs_inner_bulkhead_knockout(chord,naca1,naca2,naca3,flapsz,skin_thick){
    airfoil_solid_knockout(chord,naca1,naca2,naca3);
    flapaft=chord-chord*flapsz;
    translate([flapaft,flapaft*naca1]){
    circle(chord*naca3*flapsz+skin_thick,$fn=36);
    translate([0,-chord/2]){square([chord,chord]);}}
    }
//    
module airfoil_solid_knockout(chord,naca1,naca2,naca3){    
difference(){
   translate([-chord/2,-chord]){
       square([chord*2,chord*2]);
       } 
    solid_bulkhead(chord,naca1,naca2,naca3);
    }
}
//
module cs3d(chord,naca1,naca2,naca3,brace_thick,skin_thick,sec_sweep,sec_scale){
    linear_extrude(skin_thick)
            difference(){
                cs(chord,sec_sweep,sec_scale,naca1,naca2,naca3,flapsz,brace_thick,skin_thick);
                airfoil_solid_knockout(chord,naca1,naca2,naca3);
        }
    }    
//

//
module cs(chord,sec_sweep,sec_scale,naca1,naca2,naca3,flapsz,brace_thick,skin_thick){difference(){
        solid_bulkhead(chord,naca1,naca2,naca3);
        cs_knockout(chord,naca1,naca2,naca3,flapsz,brace_thick);}
    }
//
    
//cs_combined_knockout(chord,naca1,naca2,naca3,flapsz,skin_thick);
    
module cs_combined_knockout(chord,naca1,naca2,naca3,flapsz,skin_thick){
    intersection(){
 cs_inner_bulkhead_knockout(chord,naca1,naca2,naca3,flapsz,skin_thick);
 cs_knockout(chord,naca1,naca2,naca3,flapsz,brace_thick);
        }
    }

//
module airfoil_outline_plug(chord,naca1,naca2,naca3,wide){    
    difference(){
        difference(){
           translate([-chord/2,-chord]){
               square([chord*2,chord*2]);
               } 
           outline_bulkhead(chord,naca1,naca2,naca3,wide);
               }
        airfoil_solid_knockout(chord,naca1,naca2,naca3);
        }
}
//

module length_braces(chord,brace_thick,skin_thick,quanspars,naca1,naca2,naca3,bulk_thick){
    intersection(){
        outline_bulkhead(chord,naca1,naca2,naca3,bulk_thick*.75);
        translate([chord*naca2,0]){
            for (i=[1:quanspars] ){
                rotate([0,0,i*360/quanspars]){
                    translate([0,0,0]){
                        square([chord,skin_thick*2]);
                        }
                    }
                }
        
            }
        }
    }

//

module base_airfoil(chord,naca1,naca2,naca3){
    airfoil(naca = [naca1,naca2,naca3], L=chord , N=64, open = false);
    translate([chord-brace_thick,-skin_thick/2]){
    square([brace_thick,skin_thick]);
};
    }
//
    
    
//naca = [naca1,naca2,naca3], L=chord , N=64, open = false

/// Airfoil function //////
{
module airfoil(naca=12, L =100, N = 81, open = false)
{
  polygon(points = airfoil_data(naca, L, N, open)); 
}
//



// this is the main function providing the airfoil data
function airfoil_data(naca=12, L = 100, N = 81, open = false) = 
  let(Na = len(naca)!=3?NACA(naca):naca)
  let(A = [.2969, -0.126, -.3516, .2843, open?-0.1015:-0.1036])
  [for (b=[-180:360/(N):179.99]) 
    let (x = (1-cos(b))/2)  
    let(yt = sign(b)*Na[2]/.2*(A*[sqrt(x), x, x*x, x*x*x, x*x*x*x])) 
    Na[0]==0?L*[x, yt]:L*camber(x, yt, Na[0], Na[1], sign(b))];  

// helper functions
function NACA(naca) = 
  let (M = floor(naca/1000))
  let (P = floor((naca-M*1000)/100)) 
  [M/10, P/10, floor(naca-M*1000-P*100)/100];  

function camber(x, y, M, P, upper) = 
  let(yc = (x<P)?M/P/P*(2*P*x-x*x): M/(1-P)/(1-P)*(1 - 2*P + 2*P*x -x*x))
  let(dy = (x<P)?2*M/P/P*(P-x):2*M/(1-P)/(1-P)*(P-x))
  let(th = atan(dy))
  [upper ? x - y*sin(th):x + y*sin(th), upper ? yc + y*cos(th):yc - y*cos(th)];
}
