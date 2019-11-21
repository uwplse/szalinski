difference() {
    union() {
        import("/Volumes/Samsung1TbM3/Progetti Arduino/01 Personali/Delta/K250VS-master/k250_glcd_back.stl");
        translate([-24,34,2]) cylinder(r=2.7, h=5, $fn=100);
        translate([-24,56,2]) cylinder(r=2.7, h=5, $fn=100);    
    }

    translate([-30,30,0]) 
        union() {
            //cube([12,30,5]);
            // mount holes
            translate([6,4,3]) cylinder(r=1.5, h=17, $fn=100);
            translate([6,26,3]) cylinder(r=1.5, h=17, $fn=100);
            // control hole
            translate([6,15,-1]) cylinder(r=3.2, h=7, $fn=100);
        }
}