//mallet handle
height=250; //length of handle outside of mallet head
topradius=10; //radius of base of handle
bottomradius=10; //radius of top handle

//endstop below handle
endstop=12; //length of end of handle
endstopflare=15; //radius of endstop flare

diamalletheadhole=20; //depth of hole in mallet head
endbottomradius=12; //flare at the top?

//curved design in handle
design = 1; //1 means add design, 0 means no design

designfromhead=15; //distance design ends from mallet head
designL=120; //length of design
designD=8; //depth of design into handle -cannot exceed 2x handle radius

smooth=60; //resolution

//Calculations
designstart=((height-(.5*designL))-designfromhead); //beginning of design in handle (centerpoint) - can enter a number as well

if (design == 1){
difference(){
    
union(){
    translate([0,0,height]) cylinder(diamalletheadhole, bottomradius,endbottomradius, $fn=smooth);
    cylinder(height,topradius,bottomradius,$fn=smooth);
    rotate ([180,0,0]) cylinder(endstop, bottomradius,endstopflare, $fn=smooth);

}
translate([0,0,designstart])#rotate_extrude($fn=smooth)translate([bottomradius,0,0])resize([designD,designL]) circle(r=.5*bottomradius); 
}
}
else if (design == 0) {
    union(){
    translate([0,0,height]) cylinder(diamalletheadhole, bottomradius,endbottomradius, $fn=smooth);
    cylinder(height,topradius,bottomradius,$fn=smooth);
    rotate ([180,0,0]) cylinder(endstop, bottomradius,endstopflare, $fn=smooth);
    }
}