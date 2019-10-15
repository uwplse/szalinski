module rCube(x,y,z,rd,fn){
    $fn=fn;
    hull(){
        translate([rd,rd,rd]) sphere(rd);
        translate([x-rd,rd,rd]) sphere(rd);
        translate([x-rd,y-rd,rd]) sphere(rd);
        translate([rd,y-rd,rd]) sphere(rd);
        translate([rd,rd,z-rd]) sphere(rd);
        translate([x-rd,rd,z-rd]) sphere(rd);
        translate([x-rd,y-rd,z-rd]) sphere(rd);
        translate([rd,y-rd,z-rd]) sphere(rd);
    }
}

rCube(10,20,30,2,20);