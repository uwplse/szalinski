

// edit battery height & width 
battery_height=24.5;
battery_width=14.5;


// Adjust height for Moskito Frame & part thickness
full_height=battery_height-10+2;

difference(){
    union() {

        hull(){
        intersection(){
            hull(){
                $fn=50;
               translate([0,0,full_height/2])
                minkowski()
                {
                    cube([battery_width-1,20-4,full_height],center=true);
                    cylinder(r=2,h=1);
                }
            }
            hull(){
                   rotate([0,0,45])translate([3.3/2-44/2,0,0])foot_base(2,1,44);
                   rotate([0,0,45])translate([3.3/2-44/2,0,full_height-0.5])foot_base(2,1.5,44);
            }
        }
         rotate([0,0,45])translate([2/2-(44-4)/2,0,0])foot_base(2,1.5,44-4);
        }

        rotate([0,0,45])translate([3.3/2-44/2,0,0])foot_base(3.3,1.5,44);


        hull(){
            intersection(){
                hull(){
                    $fn=50;
                   translate([0,0,full_height/2])
                    minkowski()
                    {
                        cube([battery_width-1,20-4,full_height],center=true);
                        cylinder(r=2,h=1);
                    }
                }
                hull(){
                       rotate([0,0,-45])translate([3.3/2-44/2,0,0])foot_base(2,1,44);
                       rotate([0,0,-45])translate([3.3/2-44/2,0,full_height-0.5])foot_base(2,1.5,44);
                }
            }
             rotate([0,0,-45])translate([2/2-(44-4)/2,0,0])foot_base(2,1.5,44-4);
        }

        rotate([0,0,-45])translate([3.3/2-44/2,0,0])foot_base(3.3,1.5,44);


        hull(){
            $fn=50;
           translate([0,0,full_height/2])
            minkowski()
            {
                cube([battery_width-1,20-4,full_height],center=true);
                cylinder(r=2,h=1);
            }
        }
    }
    cube([battery_width-2,20-4-2.5/2,full_height*3],center=true);
    cube([battery_width,20*2,(full_height-1.5/2)*2],center=true);
}    


module foot_base(width, height, length){
        translate([0,0,height/2])hull(){
            cylinder(d=width,h=height,center=true);
             translate([(length-width)/2,0,0])cylinder(d=width,h=height,center=true);
            translate([(length-width),0,0])cylinder(d=width,h=height,center=true);
        }
    }