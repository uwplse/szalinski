

label_Front_Left =  "FL";
label_Front_Right =  "FR";
label_Rear_Left =  "RL";
label_Rear_Reft =  "RL";


translate([20,30,0])label(label_Front_Left);
translate([-20,30,0])label(label_Front_Right);
translate([20,-30,0])label(label_Rear_Left);
translate([-20,-30,0])label(label_Rear_Reft);




module label(letters){
    translate([0,0,-1]){ 
    $fn=30;
    union(){
difference(){
difference(){
difference(){    
minkowski(){
    hull(){
        translate([-10,23,0])cylinder(r=2,h=2);
        translate([10,23,0])cylinder(r=2,h=2);
        translate([10,-3,0])cylinder(r=2,h=2); 
        translate([5,-23,0])cylinder(r=2,h=2);
        translate([-5,-23,0])cylinder(r=2,h=2);
        translate([-10,-3,0])cylinder(r=2,h=2);    
    }
    sphere(2);

}
translate([0,-18,-4]){
    cylinder(h=10,r=4.25);
}    

}

translate([0,7,-5]) {
    rotate([0,0,90]){ 
    linear_extrude(height=10, convexity=4)
                color("red",1) text(letters, 
                     size=24*22/30,
                     font="Archivo Black",
                      
                     halign="center",
                     valign="center");
}}}
translate([0,0,-1]) cube([40,80,4],center=true);
}
}
}}