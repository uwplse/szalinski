/* [Global] */
// Number of Rows
rows = 4;
// Number of Columns
columns = 3;

/* [Preferences] */
// Width/Height of Box
a = 33;
// Depth of Box
depth = 39;
// Outside Wall Thickness
wall_outer = 4.5;
// Divider Thickness
wall_inner = 2;

difference(){
    cube([depth,columns*a+2*wall_outer+(columns-1)*wall_inner, rows*a+2*wall_outer+(rows-1)*wall_inner],false);
    union() {
        for (y = [a/2+wall_outer:a+wall_inner:rows*a+(rows-1)*wall_inner+wall_outer]){
            for (x = [(a/2)+wall_outer:a+wall_inner:columns*a+(columns-1)*wall_inner+wall_outer]){
                translate([depth/2,x,y]) cube([depth,a,a],true);
            }
        }
    };
};