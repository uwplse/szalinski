//CUSTOMIZER VARIABLES

InnerDiameter = 25;       //inner diameter 
OuterDiameter = 33;       //outer diameter
clampHight = 16;             // high of p2 part


// Which one would you like to see?
part = "both"; // [first:Barmount_sleve-print_PLA ,second:Clamp_cube-print_FLEX ,both:Sleve and Clamp]

module both(){
    translate([0,0,-0.05]){barmount();}    // print from PLA, disable with "*" for export to stl
    translate([0,25,0]){barmount_p2();}  // print from FLEX, disable with "*" for export to stl
    }
    

module barmount_sleve_PLA(){
    translate([0,0,-0.05]){barmount();}    // print from PLA, disable with "*" for export to stl
    }
    

module clamp_cube_FLEX(){
    translate([0,25,0]){barmount_p2();}  // print from FLEX, disable with "*" for export to stl
    }

/* [Hidden] */

  //recalculation
  Rin= InnerDiameter /2;
  Rout= OuterDiameter /2;
  h= clampHight;
  
  

  
module print_part() {
	if (part == "first") {
		barmount_sleve_PLA();
	} else if (part == "second") {
		clamp_cube_FLEX();
	} else if (part == "both") {
		both();
	} else {
		both();
	}
}  
  
module mounthole1(){
    difference(){   
        union(){  
            hull(){
                translate([-10.5,0,-3.8]){cube([2,14,10],true);}
                translate([-20.8, 0, -15.8]){
                rotate([90,0,0]){scale([1,0.9,1]){cylinder(14,Rout,Rout,true, $fn=30);}}}
                translate([0,0,-1]){ cylinder(4.4,5,5,true, $fn=30);}}}
        
        
        union(){
           cylinder(10,1.7,1.7,true, $fn=30);    
           translate([0,0,-13]){cylinder(18, 3, 7.3/2,true, $fn=6);}
           translate([3,0,-13]){cylinder(18, 3, 7.3/2,true, $fn=6);}
            }}
}
module barmount(){

    difference(){
        union(){
            translate([21,0,-1.15])mounthole1();
            translate([-21,0,-1.15])rotate([0,0,180]){mounthole1();    }}
        
        union(){
            hull(){
                translate([0,0,-14]){rotate([90,0,0]){cylinder(16,Rin,Rin,true,$fn=40); }}
                translate([0,0,0]){rotate([90,0,0]){cylinder(16, Rin, Rin,true,$fn=40);  } }}}    
    }
}

module barmount_p2(){
  
    difference(){
        union(){
           translate([-Rin-1, -18/2, -h+6])cube([Rin*2+2,18,h-6],false);}
            
        union(){
            scale([0.95,1.05,1]){barmount();}
        for(yuy =[-8: 4.1: 8.4]){
            translate([0,yuy,-h]){rotate([90,0,0]){cylinder(2.2, 23.9/2, 23.9/2,true,$fn=40); }}
            translate([0,yuy+2, -h]){rotate([90,0,0]){cylinder(2.2, 24.5/2, 24.5/2,true,$fn=40);}}}
        }
    }
}
            
 
print_part();
    
       
        