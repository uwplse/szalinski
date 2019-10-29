$fn = 50;
height = 20;
length = 147;
spacing = 7;

difference(){
    cube([length, 24, height]);
    if(height - 12 > 5 && spacing >= 7 && spacing <= 20){
        for(x = [10 : 10 : length-10]){
        hull(){
            translate([x, 6, height-4.5]) cube(4.5);
            translate([x, 12, height-4.5]) cube(4.5);
            translate([x, 12, height-12-4.5]) cube(4.5);
            translate([x, 6, height-12-4.5]) cube(4.5);
        }
        }

    }
}