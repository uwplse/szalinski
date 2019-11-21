LABEL = "STOP";

union(){
difference(){
translate ([-36/2,5,0])
    minkowski()
    {
        cube ([36,37,0.6]);
        cylinder (r=5,h=0.6);
    }
    
        translate([0,17.75,-0.5])    
            cylinder (r=15.5,h=4);
        translate([-2.5,30.65,-0.5])
            cube([5,5.2,4]);
}
color("DimGray"){
linear_extrude(height=2.2)translate([0,40,0])text(LABEL,font="tohoma:style=regular",halign="center",size=6);
}
}