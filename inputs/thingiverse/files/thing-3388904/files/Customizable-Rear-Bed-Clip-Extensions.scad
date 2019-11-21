clip_width = 30; //How wide you want the clips to be.
glass_thickness = 3; //Thickness of your glass.
glass_y_dimension = 310; //Length of your glass bed from front to back

difference(){
union() {
    cube(size = [1.5,clip_width,325-glass_y_dimension], center = false );
translate([1.5,0,0])
    cube(size = [glass_thickness,clip_width,320-glass_y_dimension], center = false);
}
translate([0,(clip_width-20)/2,0])
    cube(size = [glass_thickness-1.5,20,6.5], center = false);
}