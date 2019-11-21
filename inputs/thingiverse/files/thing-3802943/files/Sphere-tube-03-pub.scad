/************* Publication Notes **************/{/*

Customizable Sphere Tube/Cup   by  SavageRodent
Original at: https:www.thingiverse.com/thing:3802943
Last updated: 10/08/2019
Published under: the Creative Commons CC - BY 3.0 licence
Licence details here: https://creativecommons.org/licenses/by/3.0/
OpenSCAD version 2019.05 
*/}

/********** CUSTAMIZABLE PERAMITORS ***********/{
$fn         = 30; //smooth global
inc         = 120; //inraments i.e number of balls
ball_r      = 10; //ball radius, change will auto update ball spacing
tweak_ball_r= 0; //changes ball radius without altering spacing
tweak_spac  = 79;//0-100%
shell_off   = 1;//0=off 1=on (set to off to speed up preview)
shell       = 70; //0-100% 
tube_r      = 35; //distance of ball from center
inner_edge  = 50;//0-100%. 0=no hard inner edge
tweak_h     = 55;//-(ball_r/2);
flat_bottom = 1;//gives tube a flat bottom
add_base    = 1;//0=dont add base, 1=add base. flat_bottom must also =1.  
}
/******************* Other ********************/{
/*/Derivative Variable:*/{
ball_d  = ball_r*2;
tube_d  = tube_r*2;

//distance between balls along tube cecomfrance 
spacing_c   = (ball_d*.4)+ per(ball_d*.6, 0, con(1, 100, tweak_spac));
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

ball_spiral_pluss(inc,b_rad);

}
/****************** Modules *******************/{
module ball_spiral_pluss(incraments,b_rad){
//shell
difference(){
//cut inner edge
difference(){
//flat bottom y or n
if(flat_bottom==1){
    difference(){
    ball_spiral(incraments,b_rad);
    bottom(base_thick, sub_add=0);//crop bottom
    }
    }
    else{
    ball_spiral(incraments,b_rad);
    }
cylinder(r=(tube_r-(b_rad))+per((b_rad*2),1,con(0,2000,inner_edge)), h=200, $fn=80);
}
if(shell>0 && shell_off==1){
ball_spiral(incraments,per(b_rad, 0, con(0,95,shell)));
}
}

//add_base y or n
if(add_base==1&&flat_bottom==1){
    bottom(base_thick, sub_add=1);
    }
}
/*
#translate([0,0,-1000])
    cylinder(r=(tube_r-(b_rad))+per((b_rad*2),1,con(0,2000,inner_edge)), h=200, $fn=80);
*/




module ball_spiral(incraments,ball_rad){   
for(i=[0:incraments]){
    //height 
    translate([0,0,((spacing_h)/(360/rot_ball))*i])
    rotate([0,0,rot_ball*i])
    translate([tube_r,0,0])
    sphere(r=ball_rad);
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
ball_spiral(720/rot_ball,b_rad);
}
translate([0,0,b_rad])
cylinder(r=tube_d, h=base_thick);
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