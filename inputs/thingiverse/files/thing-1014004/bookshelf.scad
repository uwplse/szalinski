width = 35;//[5:100]
height = 25;//[5:40]
depth = 20;//[5:40]
inner_support = 4;//[0:20]
support_size_percent = 75;//[50:100]
fillet_size_percent = 30;//[0:100]

fillet_size = fillet_size_percent/100;
support_size = support_size_percent/100;

make_main_support();
make_supports();

translate([width/2, depth/2, 0])
cube([width+0.5, depth, 0.5], center = true);

translate([0,0,height/4])
cube([width, 0.3, 0.5*height]);

module make_supports(){
    for(a=[1:inner_support]){
        translate([0,depth/2*support_size, height/2*support_size])
        difference(){
            translate([width/(inner_support+1)*a, 0,0])
            cube([0.2, depth*support_size, height*support_size], center = true);
            difference(){
                translate([0,depth/2*support_size, height/2*support_size])
                cube([2*width, height*fillet_size, height*fillet_size], center = true);
                
                translate([0, depth/2*support_size-height*fillet_size/2, height/2*support_size-height*fillet_size/2])
                rotate([0,90,0])
                cylinder(h=2*width, r=height*fillet_size/2, center = true);
            }
        }
    }
}

module make_main_support(){
    difference(){
        for(a=[0:1]){
            translate([a*width,depth/2, height/2])
            difference(){
                cube([0.5, depth, height], center=true);
                difference(){
                    translate([0,depth/2, height/2])
                    cube([2*width, height*fillet_size, height*fillet_size], center = true);
                    
                    translate([0, depth/2-height*fillet_size/2, height/2-height*fillet_size/2])
                    rotate([0,90,0])
                    cylinder(h=2*width, r=height*fillet_size/2, center = true);
                }
            }  
        }
    }
}