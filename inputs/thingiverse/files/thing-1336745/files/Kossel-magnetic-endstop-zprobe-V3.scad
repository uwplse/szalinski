/*[Part]*/

//Choose true to only print the probe pin
Print = "probe"; //[probe: z-probe, pin: probing pin, both: both, nopin: z-probe without probe attachement]

/*[Probe holder]*/
//Overall height
height = 90;  

//Depth of bridge
depth1 = 10;   

//Depth of probe holder
depth2 = 6;   

//Width of upper bridge part
length1 = 55; 

//Width of lower bridge part
length2 = 26; 

//Width of probe holder (should be at least 2*r_probe + 2)
length3 = 10; 

// = Delta_Effector_Offset
offset = 26;  

//Adapt to your design (trial & error, the less the factor, the less material is printed)
savematerial = 1.1; 

//choose a little bit bigger than actual magnet diameter
magnetdia = 11;

//choose a little bit smaller than actual magnet depth
magnetdepth = 1; 
//seperation of magnets
magnetsep = 45; 

/*[Probe pin]*/

//Depth of probe pin
r_probe = 4; 

//Overall thickness
d_probe = 1; 

//Probe pin height, choose rather short, 2 mm'ish
h_pin = 2.5; 

//Clearance between probe pin and probe hole (on each side); should be a loose fit;
clearance = 0.3; 


/*[Hidden]*/
$fs = 0.5; //0.2 for production, 1 for draft;
$fa = 2; //0.5 for production, 2 for draft;

//Deducted variables
hfz = offset + depth1/2; //height from zero
rn = depth2; //radius of lower part to nailholder 
h_probe = depth2; //cross_radius
r_pin = d_probe; //pin radius




//###main###

if(Print == "pin"){probe_pin();}
else{

  //Bridge
  difference(){
  union(){
    hull(){
    translate ([depth2+3.5,0,depth1/2]) cube([1,length2,depth1],center = true);
     translate ([height-2.5,0,depth1/2]) cube([5,length1,depth1],center = true);
      }
      

    
    //probe pin holder
   if(Print != "nopin"){
     translate ([depth2/2,0,hfz/2]) 
     union()
      { hull(){
        translate([0,0,hfz/2-length3/2])
        cube([depth2,length3,.001],center=true);
        translate([0,0,hfz/2]) rotate([0,90,0]) cylinder(r=            length3/2, h=depth2, center = true);
        }
        hull(){
        translate([0,0,hfz/2-length3/2])
        cube([depth2,length3,.001],center=true);
        translate([depth2+3,0,-hfz/2+depth1])
        cube([depth2,length3,.001],center=true);
        }
      }
    
    translate([depth2+3,0,(hfz+11)/2])         cube([6,length3,hfz-20],center=true);
    }
        
      //Bridge lower part
      //translate([1.5*rn,-length2/2+rn,depth1/2]) cylinder(r=rn, h=depth1, center = true);
        
      //translate([1.5*rn,length2/2-rn,depth1/2]) cylinder(r=rn, h=depth1, center = true);
        
      //translate([depth2,0,depth1/2]) cube([depth2,length2-2*rn,depth1], center = true);
    }
    

    
    
  //Probe hole
    translate ([-1,0,hfz]) rotate([0,90,0]) probe_cut();
    
  //Material saving
    hull(){
      for (x=[height-depth1*savematerial,height/2+depth1*savematerial]) {
        tempy=(length2+(length1-length2)*x/height)/2;
        for (y=[tempy-depth1*savematerial,-(tempy-depth1*savematerial)]) {
          translate([x,y,depth1/2])
          cylinder(r=depth1/2,h=depth1+1,center=true);
        }}}
      
      hull(){
      for (x=[height/2-depth1/2,4+depth1+depth1*savematerial]) {
        tempy=(length2+(length1-length2)*x/height)/2;
        for (y=[tempy-depth1*savematerial,-(tempy-depth1*savematerial)]) {
          translate([x,y,depth1/2])
          cylinder(r=depth1/2,h=depth1+1,center=true);
        }}}
    
   //Magnets
  for(y=[-magnetsep/2,magnetsep/2]) 
    translate([height-magnetdepth,y,depth1/2])
    rotate([0,90,0])
    cylinder(r=magnetdia/2,h=magnetdepth+1,center=true);
  
  //Extramagnets
    for(y=[-magnetsep/2,magnetsep/2]) 
    translate([height-magnetdepth,y,depth1/2+magnetdia*1.2])
    rotate([0,90,0])
    cylinder(r=magnetdia/2,h=magnetdepth+1,center=true);
  
  //Pin
  }



  //Endstop holder
  translate([depth2+6,0,0]) holder();

  if(Print == "both"){translate([-r_probe*2,0,0]) rotate([0,0,90]) probe_pin();}

}  



//###modules###
module holder() {
    rotate([0,0,90]) translate([0,0,hfz/2]){
        //translate ([0,6,0])
          //  cube([length3,6,hfz-9],center=true);
    difference(){
        union(){
            translate([-19/2,0,0]) cylinder(r=3,h=hfz-9,center=true);
    translate([19/2,0,0]) cylinder(r=3,hfz-9,center=true);
    cube([20,6,hfz-9], center = true);
        }
    translate([-19/2,0,0]) cylinder(r=1.25,h=hfz,center=true);
    translate([19/2,0,0]) cylinder(r=1.25,hfz,center=true);
    }}}

module probe_pin(){
  translate([0,0,h_probe/2+1])
  union(){
    translate([0,0,h_probe/2]) cylinder(r=r_pin, h= h_pin);
    
    minkowski(){
      union(){
      cube([(r_probe-d_probe)*2,.001,h_probe-0.001], center=true);
      };
      cylinder(r=d_probe,h=0.001, center=true);}
      
    translate([0,0,-h_probe/2-0.5])
      difference(){
      union(){minkowski(){
      cube([(r_probe-d_probe)*2,0.001,0.001], center=true);
      cylinder(r=d_probe*2,h=1, center=true);}}
      translate([r_probe,-d_probe*2,-d_probe*2]) cube(d_probe*4,d_probe*4,d_probe*2);}
      }
      
    }
  
 module probe_cut(){
  translate([0,0,h_probe/2+1])
  union(){
    
    minkowski(){
      cube([(r_probe-d_probe)*2,.001,2*h_probe-0.001], center=true);
      cylinder(r=d_probe+clearance,h=0.001, center=true);
    }}}
  