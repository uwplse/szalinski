$fn=40;
handle_len = 100;
handle_thickness = 5;
handle_width = 10;
spoon_id = 10;
spoon_thickness = 3;
spoon_od = spoon_id + spoon_thickness;

module almost() {
    
cube([handle_len,handle_width, handle_thickness]);
translate([2,handle_width/2,spoon_od/2]) sphere(d=spoon_od);

difference()
{
}
}
difference()
{
    almost();
    translate([-50,-50,handle_thickness]) cube([100,100,100]);    
    translate([2,handle_width/2,spoon_id/2]) sphere(d=spoon_id);

}
    
