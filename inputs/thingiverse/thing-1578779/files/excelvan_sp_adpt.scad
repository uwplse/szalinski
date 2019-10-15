//excelvan spool holder
$fn=50;
module spoolholder(id,od){
    odrim = od +8;
    difference(){
        union(){
            cylinder(h=14,d=od);
            cylinder(h=4,d=odrim);
        }
        cylinder(h=14,d=id);
    }
}

spoolholder(30,57);