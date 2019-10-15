//coil
//Andrey Kostin 2016

hc =5;//coil height
dc = 6; //inner diameter
do = 16; //external diameter
dp = 1.2; //hole diameter

//hole location
sel = 1; //0 - down, 1 - side hole

rc = dc/2;
ro = do/2;
rp = dp/2;

difference(){
    union(){
hull(){
    cylinder(h=hc,r1=rc,r2=rc,$fn =70,center = false);
translate([0, rc*1.6, 0])cylinder(h=hc,r1=rc,r2=rc,$fn =70,center = false);
}

translate([0, 0, hc])hull(){
    cylinder(h=0.75,r1=rc-0.5,r2=rc-0.5,$fn =70,center = false);
translate([0, rc*1.6, 0])cylinder(h=0.75,r1=rc-0.5,r2=rc-0.5,$fn =70,center = false);
}
hull(){
    cylinder(h=0.75,r1=ro,r2=ro,$fn =70,center = false);
translate([0, rc*1.6, 0])cylinder(h=0.75,r1=ro,r2=ro,$fn =70,center = false);
}}
union(){
    //
 if(sel == 0)translate([rc+0.6, 2, -1])cylinder(h=10,r1=rp,r2=rp,$fn =70,center = false);

   //
    if(sel == 1)rotate(a=[0,90,0])translate([-(0.75+rp), rc, 0])cylinder(h=dc,r1=rp,r2=rp,$fn =70,center = false);    
    
   
  translate([0, 0, -1])hull(){
    cylinder(h=9,r1=1.5,r2=1.5,$fn =70,center = false);
translate([0, rc*1.6, 0])cylinder(h=9,r1=1.5,r2=1.5,$fn =70,center = false);
 
} }  
}

//hoop
translate([do+1, 0, 0])difference(){
  hull(){
    cylinder(h=0.75,r1=ro,r2=ro,$fn =70,center = false);
translate([0, rc*1.6, 0])cylinder(h=0.75,r1=ro,r2=ro,$fn =70,center = false);}  
    
translate([0, 0, -2])hull(){
    cylinder(h=6,r1=rc-0.45,r2=rc-0.45,$fn =70,center = false);
translate([0, rc*1.6, 0])cylinder(h=6,r1=rc-0.45,r2=rc-0.45,$fn =70,center = false);
}

}
