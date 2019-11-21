

//Enter custom dimensions for your cup in mm

bottom_diameter = 50; //[1:400]
height = 90;//[1:1000]
top_diameter = 40; //[1:400]
wall_thickness = 10; //[10:100]
base_thickness = 5; //[5:100]

difference(){
cylinder($fn=100, height,bottom_diameter,top_diameter, center=true/false);
;
    translate([0,0,base_thickness]){
        cylinder($fn=100,height+1,bottom_diameter-wall_thickness,top_diameter-wall_thickness, center=true/false);}}