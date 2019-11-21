// Which one would you like to see?
part = "Drawer"; // [Drawer:Drawer Only,Casing:Casing Only,both:Drawer and Casing]

//Number of Slots
Slots=7; // [1:21]

/////////////////////////////////
//simple parametric ER11 Collet Drawer by Christoph Queck
//chris@q3d.de

i=Slots;
if (part=="Drawer"){drawer();}
if (part=="Casing"){rotate([0,-90,0])hulle();}

if (part=="both"){

translate([18,26,9.25])rotate([0,-90,0])
hulle();
drawer();

}

//crosscut();
module crosscut(){
    
intersection(){
    union(){
hulle();
drawer();
    }
    rotate([0,90,0])cylinder(r=100,h=0.5);
}}
module hulle(){
    difference(){
    translate([15*(i-1)/2+2,0,11.5])cube([15*i+7.5,20,27],center=true);
        
        difference(){
            translate([15*(i-1)/2+5,0,11.25])cube([15*i+10.5,15.5,23],center=true);
            translate([-7.5,-8,1])rotate([45,0,0])cube([15*i+6,1.5,1.5]);
            translate([-7.5,8,1])rotate([45,0,0])cube([15*i+6,1.5,1.5]);
            }
    }
    }


module drawer(){
union(){
difference(){
translate([15*(i-1)/2+3,0,8])cube([15*i+6,15,16],center=true);
for(j=[0:(i-1)]){
translate([15*j,0,0.5+8])
rotate([0,20,0])translate([0,0,-7.5])union(){
cylinder(r1=4,r2=5.7,h=13.2,$fn=32);
   translate([0,0,13.2])scale([1,5,1])cylinder(r=6,h=10,$fn=32); 
}}
translate([-7.5,-7.5,1])rotate([45,0,0])cube([15*i+6,1.5,1.5]);
translate([-7.5,7.5,1])rotate([45,0,0])cube([15*i+6,1.5,1.5]);

//rotate([0,90,0])cylinder(r=2.25,h=10,$fn=32,center=true);
}
difference(){
translate([15*i,0,12.5])cube([3,20,25],center=true);
    translate([15*i-1.5,0,25])cube([2,10,10],center=true);
}
}
}