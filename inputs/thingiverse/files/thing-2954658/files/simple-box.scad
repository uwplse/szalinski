//--------------Box V2------------------//
/*--------------------------------------//
**Designer: Kristina Nickerson @
            Basement Laser
**Start: 06-18-2018
**End:   
//--------------------------------------*/

//======================================//
//=============PARAMETERS===============//
//======================================//

//display: 0=3D box, 1=flat
flat    =   0;

//-------------USER INPUT---------------//

//material thickness
t   =   3;

//inside dimensions
Li  =   150;
Wi  =   100;
Hi  =   75;

//tab size
S   =   4*t;

//brace size
B   =   2;

//-----------END USER INPUT-------------//

//edge size
e   =   t+B;

//total dimensions
L   =   Li+2*e;
W   =   Wi+2*t;
H   =   Hi+e;

//======================================//
//=============APPEARANCE===============//
//======================================//

color_front = ("red");
color_back =("green");
color_side_1 =("darkviolet");
color_side_2 = ("deeppink");
color_bottom = ("coral");
color_cover = ("rosybrown");
color_insert = ("blue");
color_pegs = ("orange");

//======================================//
//==============FUNCTIONS===============//
//======================================//

function    func_n(q) = 
    ((q-(2*t)+S)/(2*S));
    
function    func_E(z) = 
    ((z-(floor(func_n(z))*2*S)+S)/2);
    
//======================================//
//===============MODULES================//
//======================================//

module whole_flat() {
    front();
    translate([0,H+B,0])
    back();
    translate([L+e,0,0])
    side_1();
    translate([L+e,H+B,0])
    side_2();
    translate([e,2*H+B+e])
    bottom(); 
    translate([-L-t,0,0])
    lid_flat();
}

module  whole_box() {
    translate([0,0,H-t])
    lid_box(); 
   
    color(color_back)
    translate([0,W,0])
    rotate([90,0,0])
    linear_extrude(t)
    back(); 
    
    color(color_bottom)
    translate([e,t,2])
    linear_extrude(t)
    bottom(); 
    
    color(color_side_1)
    translate([2,t,0])
    rotate([90,0,90])
    linear_extrude(t)
    side_1(); 
    
    color(color_side_2)
    translate([L-e,t,0])
    rotate([90,0,90])
    linear_extrude(t)
    side_2(); 
    
    color(color_front)
    translate([0,t,0])
    rotate([90,0,0])
    linear_extrude(t)
    front(); 
}

module  front() {
    E1  =   func_E(Li);
    E2  =   func_E(Hi);
    color(color_front)
    difference()    {
        square([L,H]);
        translate([e,0,0])
        hi_tabs(E1,Li,B);
        translate([0,e,0])
        vi_tabs(E2,Hi,[B,L-t-B]);
    }
}

module  back()   {
    color(color_back)
    front();
}

module  side_1()    {
    E1  =   func_E(Wi);
    E2  =   func_E(Hi);
    color(color_side_1)
    union() {
        difference()    {
            square([Wi,H]);
            hi_tabs(E1,Wi,B);
        }
        translate([0,e,0])
        vo_tabs(E2,Hi,[-t,Wi-t]);
    }
}

module  side_2()    {
    color(color_side_2)
    side_1();
}

module  bottom()    {
    E1  =   func_E(Li);
    E2  =   func_E(Wi);
    color(color_bottom)
    union() {
        square([Li,Wi]);
        translate([0,-t,0])
        ho_tabs(E1,Li,[0,Wi]);
        translate([-t,0,0])
        vo_tabs(E2,Wi,[0,Li]);
    }
}

module  lid_flat()   {
    cover();
    translate([0,W+t,0])
    translate([e,t,0])
    insert();
    translate([e,2*W+t,0])
    pegs_flat();
}

module  lid_box()   {
    color(color_pegs)
    translate([e,t,0])
    linear_extrude(2*t)
    pegs_box();
    
    color(color_cover)
    translate([0,0,t])
    linear_extrude(t)
    cover();
    
    color(color_insert)
    translate([e,t,0])
    linear_extrude(t)
    insert(); 
}

module  cover() {
    color(color_cover)
    difference()    {
        square([L,W]);
        for(x  =  [e+3*t,L-e-4*t], 
            y =[4*t,W-8*t])
        translate([x,y])
        square([t,4*t]);
    }
}

module  insert()    {
    color(color_insert)
    difference()    {
        square([Li,Wi]);
        for(x  =  [3*t,Li-4*t], 
            y =[3*t,Wi-7*t])
        translate([x,y])
        square([t,4*t]);
    }
}

module  pegs_flat()  {
    color("blue")
    for(x=[0:2*t+1:3*(2*t+1)])
        translate([x,0])
    square([2*t,4*t]);
}

module  pegs_box()  {
    color(color_pegs)
    for(x  =  [3*t,Li-4*t], 
            y =[3*t,Wi-7*t])
    translate([x,y])
    square([t,4*t]);
}
//======================================//
//==========REPEATING MODULES==========//
//======================================//

module hi_tabs(E,p,ys)    {
    //edge horizontal inside
            for(x=[E:2*S:p-E],
                y=ys)
            translate([x,y])
            x_tab_i();
        }
     
module  vi_tabs(E,p,xs)    {
        //edge vertical inside
            for(x=xs,
                y=[E:2*S:p-E])
            translate([x,y])
            y_tab_i(); 
        }
        
        module ho_tabs(E,p,ys)    {
    //edge horizontal inside
            for(x=[E:2*S:p-E],
                y=ys)
            translate([x,y])
            x_tab_o();
        }
     
module  vo_tabs(E,p,xs)    {
        //edge vertical inside
            for(x=xs,
                y=[E:2*S:p-E])
            translate([x,y])
            y_tab_o(); 
        }
module  x_tab_o() {
    square([S,t*2]);
}

module x_tab_i()    {
    square([S,t]);
}

module  y_tab_o() {
    square([t*2,S]);
}

module  y_tab_i()   {
    square([t,S]);
}

if (flat)
{
    whole_flat();
}
else
{
    whole_box();
}