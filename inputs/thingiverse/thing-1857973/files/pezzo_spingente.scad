raggiodado=7.9;
altezzadado=7.1;
raggioLM8UU=7.85;
hLM8UU=24.6;
rasse8mm=4.3;
thickness=15;
cut=thickness+20;
r_piston=16;
r_plunger=11.5;
depthsiringehole=2;
difference()
{
union() {    
cube([82,85,thickness],center=true);
//LM8UU (1)
translate([30,0,-15-thickness/2]) {
    difference(){
    cube([22,22,30],center=true);
cylinder(h=hLM8UU,r=raggioLM8UU, center=true, $fn=50);
    translate([0,-10,0]) cube([raggioLM8UU*2,20,hLM8UU],center=true);
    }
        
    }    
//LM8UU (2)
translate([-30,0,-15-thickness/2]) {
    difference(){
    cube([22,22,30],center=true);
cylinder(h=hLM8UU,r=raggioLM8UU, center=true, $fn=50);
    translate([0,-10,0]) cube([raggioLM8UU*2,20,hLM8UU],center=true);
    }
        
    }    
}    
cylinder(h=40,r=rasse8mm, center=true, $fn=50);
rotate([0,0,30]) cylinder(h=altezzadado,r=raggiodado, center=true, $fn=6);
translate([0,10,0]) cube([raggiodado*2-1.5,20,altezzadado],center=true);
    
translate([30,0,-15])cylinder(h=60,r=rasse8mm, center=true, $fn=50);
translate([-30,0,-15])cylinder(h=60,r=rasse8mm, center=true, $fn=50);

translate([0,51,0]) cube([130,80,80],center=true);
//SMUSSI
      translate([45,-47.5,0]) rotate([0,0,45]) cube([40,40,cut],center=true);
translate([-45,-47.5,0]) rotate([0,0,45]) cube([40,40,cut],center=true);
//incavo siringa
translate([0,0,-depthsiringehole]){
translate([0,-30,0])cylinder(h=3,r=r_piston, center=true, $fn=50); 
translate([0,-30-r_piston,0]) cube([r_piston*2,r_piston*2,3],center=true);        
translate([0,-30,-(thickness-depthsiringehole)/2])cylinder(h=thickness-depthsiringehole,r=r_plunger, center=true, $fn=50);
translate([0,-30-r_piston,-(thickness-depthsiringehole)/2]) cube([r_plunger*2,r_piston*2,thickness-depthsiringehole],center=true);            

}
}



