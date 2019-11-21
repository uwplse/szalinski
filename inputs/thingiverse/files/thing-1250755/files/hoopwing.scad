//Visibility Spread 
spread = 20;//[0,20,40]

//Wing Angle
angle = 06;//[0:10]


//difference(){
wing_pair(120,angle,spread);
//translate([10,-0,-20]){cube([60,50,40],center = true);}//}
//translate([10,-0,-20]){cube([59,49,38],center = true);}


    module wing_pair(length,angle,spread){
        translate([0,-spread/2,0]){wings(length,angle);}
        mirror([0,1]){translate([0,-spread/2,0]){wings(length,angle);}}
        
    }
module wings(length,angle){
    difference(){
        translate([0,0,0]){wing(length,angle);}
        translate([-length,0,-length]){cube([2*length,length,length*2]);}
        }
    translate([0,0,0]){rotate([90,0,0]){bulkhead(1,length,1,1);}}
    //translate([0,1.5,0]){mirror([0,1]){wing(length,angle);}}
}
//

//

module wing(length,angle){
    rotate([90,0,0]){
        translate([0,0,-.5]){bulkhead(1,length*.8,.8,.8);}}
    rotate([90,0,0]){
        rotate([-angle,0,0]){
            difference(){
        translate([00,0,0]){wing_part(length,50,1);}
        translate([10,0,50-4.5+spread]){wing_part(78,100,2);}}
        translate([10,0,50-4.5+spread]){wing_part(78,100,2);
            }
            }
        }
    }
//

//

module wing_part(chord,length,part_type){
    if (part_type==1){
        sec1l= .7*length;
        sec2l= .3*length;
        sec3l= -5;//the socket
        sec1sc= .79;
        sec2sc= .905;
        sec3sc= 1;//the socket
        sec1sw= -30;
        sec2sw= -50;
        sec3sw= 0;//the socket
        p1 = 1-sec1sc;
        p1a = -sec1sw*p1;
        p2 = 1-sec2sc;
        p2a = -sec2sw*p2;
        p3 = 1-sec3sc;
        p3a = -sec3sw*p3;
        
        wing_section(chord,sec1sw,sec1sc,sec1l,sec2sw,sec2sc,sec2l,sec3sw,sec3sc,sec3l);
        translate([p1a+p2a+p3a,0,sec1l+sec2l+sec3l]){
            bulkhead(sec1sc*sec2sc*sec3sc,chord*sec1sc*sec2sc*sec3sc,1,sec1sw);
            echo(sec1l);
            echo(p1a+p2a+p3a);
            }
            }
           
    if (part_type==2){
        sec1l= 5;
        sec2l= 0;
        sec3l= length-5;
        sec1sc= 1;
        sec2sc= 1.1;
        sec3sc= .4;
        sec1sw= 4;
        sec2sw= 10;
        sec3sw= -60;
        p1 = 1-sec1sc;
        p1a = -sec1sw*p1;
        p2 = 1-sec2sc;
        p2a = -sec2sw*p2;
        p3 = 1-sec3sc;
        p3a = -sec3sw*p3;
        
        wing_section(chord,sec1sw,sec1sc,sec1l,sec2sw,sec2sc,sec2l,sec3sw,sec3sc,sec3l);
        translate([p1a+p2a+p3a,0,sec1l+sec2l+sec3l]){
            bulkhead(sec1sc*sec2sc*sec3sc,chord*sec1sc*sec2sc*sec3sc,1,sec1sw);
            }
        }
    }
//

//

module wing_section(chord,sweep1,scale1,length1,sweep2,scale2,length2,sweep3,scale3,length3){
   
    
    bulkhead(1,chord,1,sweep1);
    
    translate([0,0,0]){
        skin(scale1,chord,length1,sweep1);}
        position1 = 1-scale1;
        position1a= -sweep1*position1;
        
       
    translate([position1a,0,length1]){
        skin(scale2,chord2,length2,sweep2);}
        
        chord2 =chord*scale1;
        position2 = 1-scale2;
        position2a= -sweep2*position2;
        
        
        chord3 =chord2*scale2;
    
    translate([position1a+position2a,0,length2+length1]){
        skin(scale3,chord3,length3,sweep3);}
        
        position3 = 1-scale3;
        position3a= -sweep3*position3;
        
    }
/////////////////////////////////////////


//
module skin(skscale,chord,length,sweep){
        translate([-sweep,0,length/2]){
        linear_extrude(length,convexity = 10,center=true,scale = [skscale,skscale]){
        translate([sweep,0,0])
        airfoil_outline(chord,1);
        translate([sweep,0,0]){square([chord,1],center =true);}}
        }
    }

///////////////////////////////////////

module bulkhead(bkscale,chord,length,sweep){
    translate([-sweep,0,-length/2]){
    linear_extrude(1,convexity = 10,center=true,scale = [1,1])
    translate([sweep,0,0])
        difference(){
    airfoil_outline(chord,100);
            translate([-20*bkscale,0])circle(5*bkscale);
            translate([-40*bkscale,0])circle(4*bkscale);
            translate([-1*bkscale,0])circle(5*bkscale);
            translate([20*bkscale,0])circle(5*bkscale);
            }
    }
}
//

//

module airfoil_outline(chord,thick = 1){
    naca1 =.000;
    naca2 =.35;//max hump location
    naca3 = .19;//thickness
    translate([-chord/2,0]){
    difference(){
    airfoil(naca = [naca1,naca2,naca3], L=chord , N=64, open = false);  
    translate([thick,thick]){airfoil(naca = [naca1,naca2,naca3], L=chord , N=64, open = false);
        }
    }
difference(){
airfoil(naca = [naca1,naca2,naca3], L=chord, N=64, open = false);  
translate([thick,-thick]){airfoil(naca = [naca1,naca2,naca3], L=chord , N=64, open = false);}
}
}}
//


/// Airfoil function //////

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


