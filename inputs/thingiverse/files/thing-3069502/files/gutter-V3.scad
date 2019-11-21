echo(version=version());
echo(" gutter cleaner by Evelyn ");
//$fa=.5; $fs=0.5;
hole=5.3/2;
thck=6;
lgth=175;  //armlength
brkwidth=20;
hgh = 55+15;


difference(){
  union(){
     bracket();
     translate([0,14,0]) rotate([-90,0,0]) union(){arm();claw();};
  }
  translate([-10,-50.50,-100.00]) cube([lgth*1.15,105.1,100]);    
  // Holes Remove     
   translate([brkwidth/2,20,0]) cylinder(h=thck*13,r=hole+2,center=true);  
}



module bracket(){
  difference(){
    union(){
      color("blue")   cube([brkwidth,hgh,thck]);  
      color("green")  translate([brkwidth+6.5,24,-thck+6]) rotate([0,0,-10]) cylinder(r=brkwidth+4,h=thck+4,$fn=3);  
      //Add Strenghts         
      translate([brkwidth/2+brkwidth/3,hgh/2,thck/2]) rotate([90,0,0]) cylinder(h=hgh,r=brkwidth/10, center=true);
      translate([brkwidth/2,hgh/2,thck/2]) rotate([90,0,0]) cylinder(h=hgh, r=brkwidth/10, center=true);
      translate([brkwidth/2-brkwidth/3,hgh/2,thck/2]) rotate([90,0,0]) cylinder(h=hgh,r =brkwidth/10, center=true);
    }
    // Holes Remove     
    translate([brkwidth/2,20,0]) cylinder(h=thck*3,r=hole+2,center=true);          
    translate([brkwidth/2,38.5/2+20,0]) cylinder(h=thck*3,r=hole,center=true);
    translate([brkwidth/2,38.5+20,0]) cylinder(h=thck*3,r=hole+2,center=true);
   } 
}

module arm(){    
  wdth = 20;
  union(){
    translate([lgth/2,-wdth/2+9,-5]) rotate([0,97,0]) scale([1,1.3,1])cylinder(h=lgth, r=wdth/2, center=true); 
    rotate([0,95,0]) scale([.3,1,1])cylinder(h=lgth,r1=wdth/4*3,r2=44);  
    }    
}

module claw(){ 
    r = 20;
    union(){
      translate([lgth,0,0]) scale([.35,1.11,1.2]){
      translate([-20,-5,-10]) rotate([0,r,0]) cylinder(h=40,r1=15, r2=8);
      translate([-20,-25,-10]) rotate([0,r,0]) cylinder(h=40,r1=15, r2=8);
      //translate([-15,-20,0])  cylinder(h=40,r1=20, r2=4);
    }
  }
}