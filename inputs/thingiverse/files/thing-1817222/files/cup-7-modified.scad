radius=2; //[2:8]
lines=1; //[0.0:5.0]
smoothness=200; //[0:200]

module handle(){
difference(){
    translate([2.4,0,0.1])
    rotate([90,0,0]){
        rotate_extrude($fn=100)
        translate([1.4,0,0])
        circle(0.35, $fn=smoothness);
        };
    }
}

module cup_substract(){
    translate([0,0,2]){
    cylinder(7.4, 1.8, 2.5, center=true, $fn=150);}
}


module cup(){
difference(){
    cylinder(7.5,2,2.75, center=true, $fn=150);
    translate([0,0,2]){
    cylinder(7.4, 1.8, 2.5, center=true, $fn=150);}
};
}

module pattern_real(){
difference(){
/*
pattern
*/
    translate([0,0,-3.9]){
    for(r=[0:(360/(lines*15)):360]){
        rotate([5,-4,r])
        linear_extrude(height=7.85, twist=180)
        translate([2,0,1])
        circle(radius*0.1, $fn=150);
    }
};


/*
pattern_subtract
*/
union(){
translate([0,0,3.75]){
cylinder(2,4,4);
}
translate([0,0,-5.75]){
cylinder(2,4,4);
}
cup_substract(){
}
};
}
}

module upper_round(){
difference(){
    translate([0,0,3.57])
    rotate([0,0,0]){
        rotate_extrude($fn=100)
        translate([2.5,0,0])
        circle(0.304, $fn=smoothness);
        };
    }
}

cup();

/*
handle - unnecessaries
*/
difference(){
    handle();
    translate([0,0,-2])cup_substract();
}


/*
erase unnecessary pattern
*/

pattern_real();



difference(){
    upper_round();
    translate([0,0,2.74]){
    cylinder(1,4,4);
    };
    cup_substract();
}





    