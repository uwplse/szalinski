// Collar Diameter
collar_diameter = 150;

// Adapter Length
adapter_length = 90; // 80 standard, 140
// Belt Width
belt_width = 52;
// Bolt diameter
bolt_diameter = 3.8;
// Bolt X distance
boltX = 51; // 34 standard, 72 
// Bolt Y distance
boltY = 30;
// Material Thickness
material_thickness = 2;

// GPS board
gpsX = 56;
gpsY = 45;
gpsZ = 14;  // 7 GPS, 6 controller
// lid gap
lidX = gpsX + 3;
lidY= gpsY + 3;
lid_gap = 0.8;

// solar panels
solarX = 35;
solarY = 44;
solarZ = 3;

// LiPo battery
batteryX = 75;
batteryY = 45;
batteryZ = 6;

//%case(design=3,$fn=60);

//section() 
case(design=3,$fn=60);
//lid();


module case(design)
{
  bolt_angle = atan(boltX/(collar_diameter/2));

  difference() {
    if (design == 1) { // standard flat
     hull() {
       // case
       rcube(lidX+material_thickness*2,lidY+material_thickness*2,gpsZ + material_thickness*2 ,3);
       // belt mount
       translate([0,0,-material_thickness*5]) rcube(adapter_length,belt_width,5*material_thickness+gpsZ,3);
     }
   }
   else if (design == 2) { // rounded smooth
     dd =  collar_diameter*0.68;
     difference() {
        translate([0,belt_width/2,-dd/2]) rotate([90,0,0]) scale([1,1.22,1]) cylinder_chamfered(dd,belt_width,3,$fn=120);
     } 
   }
   else { // solar
     hull() {
       // case
       rcube(lidX+material_thickness*2,lidY+material_thickness*2,gpsZ + material_thickness*2 +  batteryZ,3);
       // belt mount
       translate([0,0,-material_thickness*8]) rcube(adapter_length,belt_width,material_thickness+gpsZ,3);
       translate([-adapter_length/2+4,0,-10]) rotate([90,0,0]) cylinder(d=18,h=belt_width,center=true);
       translate([adapter_length/2-4,0,-10]) rotate([90,0,0]) cylinder(d=18,h=belt_width,center=true);
     }
   }
     // collar
     translate([0,0,-collar_diameter/2]) rotate([90,0,0]) scale ([0.9,1,1]) cylinder(d=collar_diameter,h=belt_width+10*material_thickness,center=true,$fn=120);
     // collar bolt holes
     translate([0,-boltY/2,-collar_diameter/2]) rotate([0,-bolt_angle,0]) cylinder(d=bolt_diameter,h=collar_diameter,$fn=40);
     translate([0,boltY/2,-collar_diameter/2]) rotate([0,-bolt_angle,0]) cylinder(d=bolt_diameter,h=collar_diameter,$fn=40);
     translate([0,-boltY/2,-collar_diameter/2]) rotate([0,bolt_angle,0]) cylinder(d=bolt_diameter,h=collar_diameter,$fn=40);
     translate([0,boltY/2,-collar_diameter/2]) rotate([0,bolt_angle,0]) cylinder(d=bolt_diameter,h=collar_diameter,$fn=40);     
    
     // battery cut
     translate([0,0,1.2]) rcube(batteryX,batteryY,batteryZ,3);
     // board screw holes 
     difference() {
       union() {
          rcube(gpsX,gpsY,gpsZ+material_thickness+batteryZ,3);
          translate([0,0,-20]) 
         rcube(batteryX,batteryY,21+batteryZ,3);
         //rcube(lidX,lidY,material_thickness*4+1,3);
       }
       translate([-22,-18,gpsZ+material_thickness+batteryZ-2]) cylinder(d=6,h=10);
       translate([-22,18,gpsZ+material_thickness+batteryZ-2]) cylinder(d=6,h=10);
       translate([22,-18,gpsZ+material_thickness+batteryZ-2]) cylinder(d=6,h=10);
       translate([22,18,gpsZ+material_thickness+batteryZ-2]) cylinder(d=6,h=10);       
     }
     // screws
     translate([-22,-18,0]) cylinder(d=3.2,h=gpsZ+material_thickness+batteryZ);
     translate([-22,18,0]) cylinder(d=3.2,h=gpsZ+material_thickness+batteryZ);
     translate([22,-18,0]) cylinder(d=3.2,h=gpsZ+material_thickness+batteryZ);
     translate([22,18,0]) cylinder(d=3.2,h=gpsZ+material_thickness+batteryZ);       
   
     // usb port
     translate([0,-7,0]) cube([gpsX/2+3,14,gpsZ+material_thickness]);

     if (design == 2) { // solar panel cuts
        translate([-gpsX/2-solarX/2-1,0,0]) rotate([0,-38,0]) cube([solarX,solarY,solarZ+5],center=true);
        translate([gpsX/2+solarX/2+1,0,0]) rotate([0,38,0]) cube([solarX,solarY,solarZ+5],center=true);
        translate([-50,7,3]) cube([100,6,4]);
     }
     
     if (design == 3) { // solar panel cuts
        translate([-gpsX/2-solarX/2+5,0,gpsZ-7]) rotate([0,-60,0]) cube([solarX,solarY,solarZ+1],center=true);
        translate([gpsX/2+solarX/2-5,0,gpsZ-7]) rotate([0,60,0]) cube([solarX,solarY,solarZ+2],center=true);
        translate([-50,7,3]) cube([100,6,4]);
     }
  }
  
}

module section() 
{
  difference() {
    children(0);
    translate([-200,-200,-100]) cube([400,200,300]);
  } 
}


module lid()
{
  difference() {
    translate([0,0,-material_thickness]) rcube(lidX,lidY,material_thickness * 2,3,$fn=36);
   // collar
   translate([0,0,-collar_diameter/2]) rotate([90,0,0]) cylinder(d=collar_diameter,h=belt_width+10*material_thickness,center=true,$fn=120);
  }  
  
}

module cylinder_chamfered(dia,hh,cha)
{
  cylinder(r1=dia/2-cha,r2=dia/2,h=cha);
  translate([0,0,cha]) cylinder(d=dia,h=hh-cha*2);
  translate([0,0,hh-cha]) cylinder(r1=dia/2,r2=dia/2-cha,h=cha); 
}

module rcube(a,b,c,rr)
{
  linear_extrude(height=c) hull() {
    translate([-a/2+rr,-b/2+rr,0]) circle(r=rr);
    translate([-a/2+rr,b/2-rr,0]) circle(r=rr);
    translate([a/2-rr,-b/2+rr,0]) circle(r=rr);
    translate([a/2-rr,b/2-rr,0]) circle(r=rr);    
  } 
}