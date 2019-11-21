

/********** CUSTAMIZABLE PERAMITORS ***********/
tube_r      = 40;   //distance of ball from center
inc         = 35;   //inraments i.e number of balls
ball_r      = 13.8; //ball radius, change will auto update ball spacing
tweak_ball_r= 10;   //changes ball radius without altering spacing
tweak_spac  = 72.;  //0-100% +or- overlap of neighbouring spheres
tweak_h     = 74;   //0-100% tweak height 
shell_off   = 0;    //0=off 1=on (set to off to speed up preview)
shell       = 75;   //0-100% 
inner_edge  = 50;   //0-100%. 0=no hard inner edge
flat_bottom = 1;    //gives tube a flat bottom
add_base    = 1;    //0=dont add base, 1=add base. flat_bottom must also =1.  
$fn         = 40;   //smooth global. Tet to 60+ for render
seed        = 942;  //random number seed used to calculate look direction


/************* Publication Notes **************/{/*

Customizable Eye Tube / Cup   by  SavageRodent
Original at: https://www.thingiverse.com/thing:3839789
Last updated: 01/09/2019
Published under: the Creative Commons CC - BY 3.0 licence
Licence details here: https://creativecommons.org/licenses/by/3.0/
OpenSCAD version 2019.05 
*/}
/******************* Other ********************/{
/*/Derivative Variable:*/{
ball_d  = ball_r*2;
tube_d  = tube_r*2;

//distance between balls along tube cecomfrance 
spacing_c   = (ball_d*.4)+ per(ball_d*1, 0, con(1, 100, tweak_spac));
spacing_h   = (ball_d*.3)+ per(ball_d*.7, 0, con(1, 100, tweak_h));
b_rad       = ball_r + per(ball_r, 0, con(1, 100, tweak_ball_r));    

rot_ball    = angle_A(spacing_c,tube_r);
base_thick  = 2;
}
//echo("b_rad = ",b_rad);
//echo("spacing_c = ",spacing_c);
//echo("spacing_h = ",spacing_h);
//echo("Angle of rotation per inc = ",angle_A(ball_r,tube_r));
}

/******************* Render *******************/{
eye=1;look=8;

//ball_spiral(inc, b_rad, eye);
ball_spiral_pluss(inc,b_rad, eye=1);
//eye(ia=60, id=4, pa=23, pd=10, look=look);


}
/****************** Modules *******************/{
module ball_spiral_pluss(incraments,b_rad, eye){
//shell
difference(){
//cut inner edge
difference(){
//flat bottom y or n
if(flat_bottom==1){
    difference(){
    ball_spiral(incraments,b_rad, eye);
    bottom(base_thick, sub_add=0);//crop bottom
    }
    }
    else{
    ball_spiral(incraments,b_rad, eye);
    }
translate([0,0,-1000])
cylinder(r=(tube_r-(b_rad))+per((b_rad*2),1,con(0,2000,inner_edge)), h=2000, $fn=80);
}
if(shell>0 && shell_off==1){
ball_spiral(incraments, per(b_rad, 0, con(0,95,shell)), eye=0);
}
}

//add_base y or n
if(add_base==1&&flat_bottom==1){
    bottom(base_thick, sub_add=1);
    }
}




module ball_spiral(incraments, ball_rad, eye){   
for(i=[0:incraments]){
x=rands(0,1,3,seed+i);
e_col=[0,x[1],x[2]];  
look=i;
    //height 
    translate([0,0,((spacing_h)/(360/rot_ball))*i])
    rotate([0,0,rot_ball*i])
    translate([tube_r,0,0])
    
if(eye==1){
eye(ia=60, id=4, pa=23, pd=10, eye_color=e_col, look=look);}
else
sphere(r=ball_rad);    
}
}



// ia=irus_angle, id=irus_depth, pa=pupil_angle, pupil_depth 
module eye(ia, id, pa, pd, eye_color, look){
eb_r = b_rad*.95; 
//orientation
    look_dir = rands(-30, 30, 2, seed+look);
    //echo("look_dir = ",look_dir);
    rotate([0,look_dir[0],look_dir[1]])//eye look direction
//geometry    
    rotate([0,-90,0]){//face outward
        eye_layers(r=eb_r           , a=ia, c="white");    //eye ball
        eye_layers(r=per(eb_r,1,id) , a=pa, c=eye_color);   //iris depth       
        eye_layers(r=per(eb_r,1,pd) , a=0 , c="black");    //pupil depth
        }
//eye lid
rotate([0,  con(-15, 15, look_dir[0]), 0] )//lid look direction
eye_lids();
}


//eb_r = b_rad*.95; eye_layers(r=eb_r, a=20, c="pink");

module eye_layers(r,a,c){
color(c)
rotate_extrude()
rotate([0,0,90])//rotate for extrude
difference(){
    difference(){//cut in half
        circle(r=r );
        translate([-1.5*r,0,0])
        square(3*r);//cut in half
        }
            rotate([0,0,a/2])
            translate([-1.5*r,0,0])
            square(3*r);//cut in half
            }
}

module eye_lids(){
color([1,.84,.8])
rotate([90,0,0])
difference(){
sphere(b_rad);//eye lid
translate([.35*b_rad,0,-1.4*b_rad])
linear_extrude(3*b_rad)
hull(){//opening
    circle(b_rad*.1);
    translate([1.1*b_rad,0,0])
    circle(b_rad*.8);
    }
}
}

//sub_add=0 (creates shape to cut from bottom.  sub_add=1 (creates base plate)
module bottom(base_thick, sub_add){
//remove bottom
if(sub_add==0){
translate([0,0,-b_rad])
cylinder(r=tube_d, h=b_rad*2);
}
else
//create base
intersection(){
union(){
translate([0,0,b_rad])
cylinder(r=tube_r*1.01, h=base_thick, $fn=80);
ball_spiral(720/rot_ball,b_rad, eye=1);
}
translate([0,0,b_rad])
cylinder(r=tube_d, h=base_thick);
}
}


module angle(angle){
intersection(){
rotate([0,0,-(angle/2)])
square(90000);
rotate([0,0,(angle/2)])
mirror([0,1,0])
square(90000);
}
}


/*Modules End*/}

/***************** Functions ******************/{
function per(val,inv,input)=
inv==0 || inv==undef ? (val/100)*input :
    val-((val/100)*input);


function con(mi, mx, input)=
input > mi && input < mx ? input : 
    input < mi ? mi : mx;

function c(a,b)=//side c
sqrt(pow(a,2)+pow(b,2));

function angle_A(a,b)=//this is the angle the ball will rotate each inc. 

acos(((b*b)+(c(a,b)*c(a,b))-(a*a))/(2*b*c(a,b)));





}