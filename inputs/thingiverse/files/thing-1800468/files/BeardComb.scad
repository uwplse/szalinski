size=65;
height=3;
Text="RafaelEstevam";
TextOffset=1;
FontSize=7;
TeethSpacing = 1.5;
TeethSize = 1.5;
/* HIDDEN */
$fn = 50;
difference(){
    union(){
        translate([size+10,0])
            rotate([-90,0]) scale([2.5,1,1])
                cylinder(r=height,h=size+3);    
    minkowski(){
        cube([size+10,size+3,height-1]);
        sphere(d=2);
    }}
    cylinder(r=size,h=height*3,
             center=true,$fn=128);
    translate([-5,-5,-5]) 
        cube([size*2,size*2,5]);
    step = TeethSpacing+TeethSize;
    for(x=[3:step:size]){
        translate([size+10,x,-1])
            cube([20,TeethSpacing,height*2]);
    }
    if(len(Text) > 0){
        translate([size+9,TextOffset,height-0.5])
            linear_extrude(height=2)
                rotate([0,0,90]) 
                    text(Text,size=FontSize);
    }
}