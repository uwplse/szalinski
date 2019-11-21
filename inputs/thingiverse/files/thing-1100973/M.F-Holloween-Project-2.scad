// BEGIN CUSTOMIZER
//select part(s) to render
 Parts_To_Render = 7;// [1:body, 2:PrintingBase, 3:Head, 4:Larm, 5:Rarm, 6:Fork, 7:Printable Whole Project,8:Real Project,9:DLC-Magic Truncheon,10:all]
 Project_Size = 100;// [100:300]
 Project_Quality= 30;// [30:Draft,60:Production]
 
 Weapon_to_select = 1;// [1:Demon Fork, 2: Magic Truncheon]
 
 
 // [CUSTOMIZER END]
$fn = Project_Quality;
scale_factor = 156*1;  // at project_size of this size the scaling factor is 1

module PrintingBase(){
//Printing Base

translate([-25,0,0])
cube([290,528,14],center=true);
}


module body(){

union(){

//Body

difference(){
union(){
difference(){
union(){
hull(){
cylinder (r1=100, r2=30, h=300);
translate([0,-130,0]) rotate([-20,0,0])
cylinder(r=10,h=310);
    translate([70,100,0]) rotate([20,-15,0])
cylinder(r=10,h=310);
translate([70,-100,0]) rotate([-20,-15,0])
cylinder(r=10,h=310);
translate([-100,-120,0]) rotate([-20,20,0])
cylinder(r=10,h=310);
translate([-160,0,0]) rotate([0,30,0])
cylinder(r=10,h=310);
translate([-120,120,0]) rotate([20,20,0])
cylinder(r=10,h=310);
translate([0,130,0]) rotate([20,0,0])
cylinder(r=10,h=310);}
translate([100,0,0]) rotate([0,-13,0])
   cube([5,15,280]);
translate([100,7.5,20])
sphere(r=5);
translate([93,7.5,60])
sphere(r=5);
translate([85,7.5,100])
sphere(r=5);
translate([75,7.5,140])
sphere(r=5);
translate([65,7.5,180])
sphere(r=5);
translate([55,7.5,220])
sphere(r=5);
translate([45,7.5,260])
sphere(r=5);}
difference(){
translate([35,0,310]) rotate([0,90,0])cylinder(r=30,h=20);
translate([34.5,0,320]) rotate([0,90,0])cylinder(r=30,h=21);
}}
difference(){
    translate([0,-55,220]) rotate([68,0,0])
      cylinder(r=30,h=10);
  translate([0,-54.5,220]) rotate([68,0,0])
    cylinder(r=10,h=21);
}
difference(){
translate([-15,65,220]) rotate([112,0,0])
cylinder(r=30,h=10);
    translate([-15,65.5,220]) rotate([112,0,0])
cylinder(r=10,h=14);
}
difference(){
translate([-25,0,270]) scale([0.7,0.7,0.7])rotate([0,30,0])
cylinder(r=100,h=10);

}
}
union(){
translate([0,0,320])
sphere(r=50);
cylinder (r1=90, r2=30, h=300);
}
}
}
}
//L arm
module Larm(){
translate([0,0,-100])
rotate([-66,-40,0]){
translate([0,-55,220]) 
rotate([68,0,0])
cylinder(r=10,h=70);
translate([0,-125,250]) 
sphere(r=12);
translate([0,-125,250]) 
rotate([20,70,0])
cylinder(r=9,h=90);
translate([80,-158,280])
sphere(r=11); 
translate([80,-158,280])
rotate([20,30,0])
cylinder(r=4,r2=1,h=55);
translate([80,-158,280])
rotate([45,35,0])
cylinder(r=3.8,r2=1,h=54);
translate([80,-158,280])
rotate([65,45,0])
cylinder(r=3,r2=1,h=50);
translate([80,-158,280])
rotate([-20,45,0])
cylinder(r=4,r2=1,h=54);
translate([80,-158,280])
rotate([-50,45,0])
cylinder(r=4,r2=1,h=45);
}
}
//R arm
module Rarm(){

translate([-15,-35,-150])
rotate([67,0,0]){
difference(){
union(){
    
translate([-15,65,220]) 
rotate([-68,0,0])
cylinder(r=10,h=70);
translate([-17,130,245]) 
sphere(r=12);
translate([-17,130,245]) 
rotate([-36,90,0])
cylinder(r=9,h=90);
    difference(){
translate([57,185,245])
sphere(r=15);
translate([57,185,220])
cylinder(r=9,h=50);
    }
}
translate([57,185,220])
cylinder(r=9,h=50);
}
}
}

//Fork
module Fork(){
translate([0,60,0]){
translate([57,185,0])
cylinder(r=6,h=380);
translate([57,185,0])
cylinder(r=15,h=11,center=true);
translate([55,185,380])
rotate([40,0,0])
cube([6,65,6]);
translate([55,189,386])
rotate([140,0,0])
cube([6,65,6]);
translate([57,185,380])
cylinder(r1=6,r2=1,h=100);
translate([57,140,420])
cylinder(r1=6,r2=1,h=40);
translate([57,230,420])
cylinder(r1=6,r2=1,h=40);
}
}
//Head
module Head(){
difference(){
union(){
difference(){
    union(){

translate([0,0,320]) rotate([0,0,0])scale([1.3,1,1])sphere(r=50);
    
translate([0,0,320]) rotate([0,0,45])scale([1.3,1,1])sphere(r=50);
translate([0,0,320]) rotate([0,0,90])scale([1.3,1,1])sphere(r=50);
translate([0,0,320]) rotate([0,0,-45])scale([1.3,1,1])sphere(r=50);
translate([0,0,320]) rotate([0,0,-90])scale([1.3,1,1])sphere(r=50);}
hull(){
translate([30,-40,340]) 
    cube([25,25,2]);
translate([30,-40,330]) 
    cube([25,2,20]);
    }
hull(){
translate([28,15,340]) 
    cube([25,25,2]);
translate([28,40,330]) 
    cube([25,2,20]);
    }
    hull(){
translate([45,0,318]) 
    cube([20,2,10]);
translate([47,-4,318]) 
    cube([20,10,2]);
}
difference(){
translate([35,0,310]) rotate([0,90,0])cylinder(r=30,h=20);
translate([34.5,0,320]) rotate([0,90,0])cylinder(r=30,h=21);
}
}

//Teeth
mirror([0,1,0]){
translate([40,8,290])
rotate([10,45,0])
cylinder(r1=5,r2=1,h=15,center=true);
translate([40,22,295])
rotate([35,45,0])
cylinder(r1=5,r2=1,h=15,center=true);
translate([40,25,310])
rotate([65,45,0])
cylinder(r1=5,r2=1,h=15,center=true);
}
translate([40,8,290])
rotate([10,45,0])
cylinder(r1=5,r2=1,h=15,center=true);
translate([40,22,295])
rotate([35,45,0])
cylinder(r1=5,r2=1,h=15,center=true);
translate([40,25,310])
rotate([65,45,0])
cylinder(r1=5,r2=1,h=15,center=true);
//Face
hull(){
translate([0,0,365])
cylinder(r=20,h=5);
translate([0,0,367])
cylinder(r=10,h=7); 
}

translate([0,0,369]) rotate([0,-20,0])
cylinder(r=7,h=30);

translate([-8,0,389]) rotate([0,-40,0])
cylinder(r=5,h=30);
 }
 translate([0,0,320])
 sphere(r=50);
 }
 }
 module Real_Project(){
   //Head
    
     difference(){
union(){
difference(){
    union(){

translate([0,0,320]) rotate([0,0,0])scale([1.3,1,1])sphere(r=50);
    
translate([0,0,320]) rotate([0,0,45])scale([1.3,1,1])sphere(r=50);
translate([0,0,320]) rotate([0,0,90])scale([1.3,1,1])sphere(r=50);
translate([0,0,320]) rotate([0,0,-45])scale([1.3,1,1])sphere(r=50);
translate([0,0,320]) rotate([0,0,-90])scale([1.3,1,1])sphere(r=50);}
hull(){
translate([30,-40,340]) 
    cube([25,25,2]);
translate([30,-40,330]) 
    cube([25,2,20]);
    }
hull(){
translate([28,15,340]) 
    cube([25,25,2]);
translate([28,40,330]) 
    cube([25,2,20]);
    }
    hull(){
translate([45,0,318]) 
    cube([20,2,10]);
translate([47,-4,318]) 
    cube([20,10,2]);
}
difference(){
translate([35,0,310]) rotate([0,90,0])cylinder(r=30,h=20);
translate([34.5,0,320]) rotate([0,90,0])cylinder(r=30,h=21);
}
}

//Teeth
mirror([0,1,0]){
translate([40,8,290])
rotate([10,45,0])
cylinder(r1=5,r2=1,h=15,center=true);
translate([40,22,295])
rotate([35,45,0])
cylinder(r1=5,r2=1,h=15,center=true);
translate([40,25,310])
rotate([65,45,0])
cylinder(r1=5,r2=1,h=15,center=true);
}
translate([40,8,290])
rotate([10,45,0])
cylinder(r1=5,r2=1,h=15,center=true);
translate([40,22,295])
rotate([35,45,0])
cylinder(r1=5,r2=1,h=15,center=true);
translate([40,25,310])
rotate([65,45,0])
cylinder(r1=5,r2=1,h=15,center=true);
//Face
hull(){
translate([0,0,365])
cylinder(r=20,h=5);
translate([0,0,367])
cylinder(r=10,h=7); 
}

translate([0,0,369]) rotate([0,-20,0])
cylinder(r=7,h=30);

translate([-8,0,389]) rotate([0,-40,0])
cylinder(r=5,h=30);
 }
 translate([0,0,320])
 sphere(r=50);
 }
 if(Weapon_to_select == 1){
 //Fork
 translate([57,185,0])
cylinder(r=6,h=380);
translate([57,185,0])
cylinder(r=15,h=11,center=true);
translate([55,185,380])
rotate([40,0,0])
cube([6,65,6]);
translate([55,189,386])
rotate([140,0,0])
cube([6,65,6]);
translate([57,185,380])
cylinder(r1=6,r2=1,h=100);
translate([57,140,420])
cylinder(r1=6,r2=1,h=40);
translate([57,230,420])
cylinder(r1=6,r2=1,h=40);
 }
 if(Weapon_to_select == 2){
//DLC
 translate([57,185,0])
cylinder(r=6,h=380);
translate([57,185,0])
cylinder(r=15,h=11,center=true);
translate([55,185,380])
cylinder(r1=6,r2=20,h=30);
 translate([55,185,438])
 sphere(r=30);
 }
     
     
     
 //Rarm
 difference(){
union(){
    
translate([-15,65,220]) 
rotate([-68,0,0])
cylinder(r=10,h=70);
translate([-17,130,245]) 
sphere(r=12);
translate([-17,130,245]) 
rotate([-36,90,0])
cylinder(r=9,h=90);
    difference(){
translate([57,185,245])
sphere(r=15);
translate([57,185,220])
cylinder(r=9,h=50);
    }
}
translate([57,185,220])
cylinder(r=9,h=50);
}
//Larm
   translate([0,-55,220]) 
rotate([68,0,0])
cylinder(r=10,h=70);
translate([0,-125,250]) 
sphere(r=12);
translate([0,-125,250]) 
rotate([20,70,0])
cylinder(r=9,h=90);
translate([80,-158,280])
sphere(r=11); 
translate([80,-158,280])
rotate([20,30,0])
cylinder(r=4,r2=1,h=55);
translate([80,-158,280])
rotate([45,35,0])
cylinder(r=3.8,r2=1,h=54);
translate([80,-158,280])
rotate([65,45,0])
cylinder(r=3,r2=1,h=50);
translate([80,-158,280])
rotate([-20,45,0])
cylinder(r=4,r2=1,h=54);
translate([80,-158,280])
rotate([-50,45,0])
cylinder(r=4,r2=1,h=45);  
//Body
union(){

//Body

difference(){
union(){
difference(){
union(){
hull(){
cylinder (r1=100, r2=30, h=300);
translate([0,-130,0]) rotate([-20,0,0])
cylinder(r=10,h=310);
    translate([70,100,0]) rotate([20,-15,0])
cylinder(r=10,h=310);
translate([70,-100,0]) rotate([-20,-15,0])
cylinder(r=10,h=310);
translate([-100,-120,0]) rotate([-20,20,0])
cylinder(r=10,h=310);
translate([-160,0,0]) rotate([0,30,0])
cylinder(r=10,h=310);
translate([-120,120,0]) rotate([20,20,0])
cylinder(r=10,h=310);
translate([0,130,0]) rotate([20,0,0])
cylinder(r=10,h=310);}
translate([100,0,0]) rotate([0,-13,0])
   cube([5,15,280]);
translate([100,7.5,20])
sphere(r=5);
translate([93,7.5,60])
sphere(r=5);
translate([85,7.5,100])
sphere(r=5);
translate([75,7.5,140])
sphere(r=5);
translate([65,7.5,180])
sphere(r=5);
translate([55,7.5,220])
sphere(r=5);
translate([45,7.5,260])
sphere(r=5);}
difference(){
translate([35,0,310]) rotate([0,90,0])cylinder(r=30,h=20);
translate([34.5,0,320]) rotate([0,90,0])cylinder(r=30,h=21);
}}
difference(){
    translate([0,-55,220]) rotate([68,0,0])
      cylinder(r=30,h=10);
  translate([0,-54.5,220]) rotate([68,0,0])
    cylinder(r=10,h=21);
}
difference(){
translate([-15,65,220]) rotate([112,0,0])
cylinder(r=30,h=10);
    translate([-15,65.5,220]) rotate([112,0,0])
cylinder(r=10,h=14);
}
difference(){
translate([-25,0,270]) scale([0.7,0.7,0.7])rotate([0,30,0])
cylinder(r=100,h=10);

}
}
union(){
translate([0,0,320])
sphere(r=50);
cylinder (r1=90, r2=30, h=300);
}
}
}
     
}
module DLC(){
translate([57,185,0])
cylinder(r=6,h=380);
translate([57,185,0])
cylinder(r=15,h=11,center=true);
translate([55,185,380])
cylinder(r1=6,r2=20,h=30);
 translate([55,185,438])
    sphere(r=30);
}
    



 scale([Project_Size/scale_factor, Project_Size/scale_factor, Project_Size/scale_factor]) {
 
if(Parts_To_Render == 1){
    body();
}
if(Parts_To_Render == 2){
    PrintingBase();
}
if(Parts_To_Render == 3){
    Head();
}
if(Parts_To_Render == 4){
    Larm();
}
if(Parts_To_Render == 5){
    Rarm();
}
if(Parts_To_Render == 6){
    Fork();
}
if(Parts_To_Render == 7){
   union(){
       body();
       PrintingBase();
       Head();
       Larm();
       Rarm();
    if(Weapon_to_select == 2){
     DLC();}
  else   
       Fork();
   }
   }
if(Parts_To_Render == 8){
    Real_Project();
   }

if(Parts_To_Render == 9){
    DLC();
}

if(Parts_To_Render == 10){
    translate([300,-330,-270])
    Head();
    body();
    translate([20,-100,0])
    Rarm();
    translate([20,100,-10])
    Larm();
    translate([400,0,0])
    PrintingBase();
    Fork();
    translate([40,-40,0])
    DLC();
    
    
    
    
    
    
}
}