ThicknessStepper = 5;
WidthStepper = 56.2;
ScrewsStepper = 47.1;
HeightFoot = 25;

//change from stepper to bearing
Stepper=1;

$fn=50;
difference(){
    union(){
translate([WidthStepper/-2, WidthStepper/-2,0])
    cube([WidthStepper,WidthStepper,ThicknessStepper]);
translate([WidthStepper/2, WidthStepper/-2,0])
    cube([5,WidthStepper,HeightFoot]);

for(m=[1,0]){
mirror([0,m,0])side();
}
}

if(Stepper == 1){
//hole for stepper
translate([0,0,-0.1])cylinder(r=19.2, h=ThicknessStepper+0.2);
    
ScrewHoles();
}
else
{
translate([0,0,-0.1])cylinder(r=8, h=ThicknessStepper+0.2);
    
translate([0,0,1])cylinder(r=11.1, h=ThicknessStepper+0.2);    
}





for(i=[1,-1]){
translate([WidthStepper/2-0.1,i*WidthStepper/3,2*HeightFoot/3])
rotate([0,90,0])cylinder(r=2.1, h=ThicknessStepper+0.2);
}
}

module ScrewHoles(){
    for(r=[1:4])
{
    rotate([0,0,90*r])translate([ScrewsStepper/2,ScrewsStepper/2,-0.1])cylinder(r=2.6, h=ThicknessStepper+0.2);
}
}

module side()
{
    hull(){
translate([WidthStepper/-2, (WidthStepper/-2)-ThicknessStepper,0])
cube([WidthStepper, 5,5]);
        
translate([WidthStepper/2, (WidthStepper/-2)-ThicknessStepper,0])
cube([5, ThicknessStepper,HeightFoot]);
    }
}