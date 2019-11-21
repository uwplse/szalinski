
wing_length=80;
wing_chord = 120;


naca1 =.019;
naca2 =.35;
naca3 = .19;


sec_sweep = -250;
sec_scale =.7;


sec1pos = 1-sec_scale;
posa= -sec_sweep*sec1pos;
posb= posa*sec_scale;

show_skin = "yes"; // [yes,no] 
skin_thick = 2.2;



show_brace= "yes"; // [yes,no]
brace_thick = 8;



show_spars = "yes"; // [yes,no]
quanspars=4;//[2,4,6]


////////////////////////////////////////////////////////////


/////////////////modules///////////////////////

/////////////////////////////////////////////////////////////
//
translate([0,0,0]){
brace(wing_chord,naca1,naca2,naca3,brace_thick,skin_thick);
    }
//
     rotate([0,0,0]){
    skin (wing_chord,naca1,naca2,naca3,skin_thick,sec_sweep,sec_scale,wing_length);
    spar (wing_chord,naca1,naca2,naca3,skin_thick,brace_thick,skin_thick,quanspars,sec_sweep,sec_scale,wing_length);
    //
    translate([posb,0,wing_length-skin_thick]){
    brace(wing_chord*sec_scale,naca1,naca2,naca3,brace_thick,skin_thick);
    }
}
//


//
module brace(chord,naca1,naca2,naca3,brace_thick,skin_thick){
    linear_extrude(skin_thick) 
        translate ([0,0]){
        translate ([0,0])
        basic_brace(chord,naca1,naca2,naca3,brace_thick,skin_thick);
            }
    }
//
module skin (chord,naca1,naca2,naca3,skin_thick,sec_sweep,sec_scale,length){
    translate ([-sec_sweep*sec_scale,0]){
        linear_extrude(length,scale=[sec_scale,sec_scale]) 
        translate ([sec_sweep*sec_scale,0]){
            basic_skin(chord,naca1,naca2,naca3,skin_thick);
          }
        }
    }
//
 module spar (chord,naca1,naca2,naca3,skin_thick,brace_thick,skin_thick,quanspars,sec_sweep,sec_scale,length){
    translate ([-sec_sweep*sec_scale,0]){
        linear_extrude(length,scale=[sec_scale,sec_scale]) 
        translate ([sec_sweep*sec_scale,0]){
            //basic_skin(chord,naca1,naca2,naca3,skin_thick);
            basic_spar(chord,naca1,naca2,naca3,brace_thick,skin_thick,quanspars);
          }
        }
    }   
    
//
    
    
//    
module basic_skin(chord,naca1,naca2,naca3,skin_thick){
    if (show_skin=="yes"){
    difference(){
        base_airfoil(chord,naca1,naca2,naca3,skin_thick);
        base_airfoil_skin_hollow(chord,naca1,naca2,naca3,skin_thick);
        }}
    }
//
module basic_brace(chord,naca1,naca2,naca3,brace_thick,skin_thick){
    if (show_brace== "yes"){
    difference(){
        base_airfoil(chord,naca1,naca2,naca3,skin_thick);
        base_airfoil_brace_hollow(chord,naca1,naca2,naca3,skin_thick,brace_thick);
        }}
    }
//  
module basic_spar(chord,naca1,naca2,naca3,brace_thick,skin_thick,quanspars){
    if (show_spars== "yes"){
        intersection(){
            //
            translate([chord*naca2,0]){
            for (i=[1:quanspars] ){
                rotate([0,0,i*360/quanspars]){
                    translate([0,0,0]){
                        //square([chord,skin_thick*2]);
                        square([chord,skin_thick]); 
                    }}}}
            
            //
            difference(){
                base_airfoil(chord,naca1,naca2,naca3,skin_thick);
                base_airfoil_brace_hollow(chord,naca1,naca2,naca3,skin_thick,brace_thick*.9);
                }
                
                }}
    }
   
   
   
    
//    
module base_airfoil_skin_hollow(chord,naca1,naca2,naca3,skin_thick){
    translate([skin_thick,0]){
base_airfoil(chord-skin_thick*2,naca1,naca2,naca3,skin_thick);}}
//    
module base_airfoil_brace_hollow(chord,naca1,naca2,naca3,skin_thick,brace_thick){
    translate([brace_thick,0]){
base_airfoil(chord-brace_thick*3,naca1,naca2,naca3,skin_thick);}}
//
module base_airfoil(chord,naca1,naca2,naca3,skin_thick){
    $fn=50;
minkowski()
{airfoil(naca = [naca1,naca2,naca3], L=chord , N=256, open = false);
    circle(skin_thick/2);
};
    }
//    
    
//naca = [naca1,naca2,naca3], L=chord , N=64, open = false

/// Airfoil function //////

module airfoil(naca=12, L =100, N = 120, open = false)
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
