 top = 15;  // [30:1:100]
 bottom = 20;  // [30:1:100]
 middle = 30;  // [30:1:100]
 high_bottom = 30;  // [30:1:100]
 high_top = 25;  // [30:1:100]
 high_mid = 2.5; // [2:0.5:10]
 high_mouse = 2.5;  // [2:0.5:10]
 
difference(){
    cylinder(h=high_bottom,r1=bottom,r2=middle,$fn=100);
    translate([0,0,3]){
    cylinder(h=high_bottom-3,r1=bottom-3,r2=middle-3,$fn=100);
    }
}


translate([0,0,high_bottom+high_mid]){
    difference(){
    cylinder(h=high_top,r1=middle,r2=top,$fn=100);
    cylinder(h=high_top,r1=middle-3,r2=top-3,$fn=100);
    }
}

translate([0,0,high_bottom]){
    difference(){
    cylinder(h=high_mid,r1=middle+1,r2=middle+1,$fn=100);
    cylinder(h=high_mid,r1=middle-3,r2=middle-3,$fn=100);
    }
}

translate([0,0,high_bottom+high_top+high_mid]){
    difference(){
    cylinder(h=high_mouse,r1=top,r2=top,$fn=100);
    cylinder(h=high_mouse,r1=top-3,r2=top-3,$fn=100);
    }
}
