//The width of the glass
length = 180.1; 

//The diameter of the led
led_size = 5.6; 

// The height of the led
led_height = 10;

//The backsupport length
length_support = 30; 

//Thickness of the glass (insert size)
glass_thickness = 2.6; 

//Extra height on the side
glass_holder_height = 6; 

//The angle (backwards) of the holder
angle = 10; 

//Number of leds/
nol = 7;

/* [hidden] */

ld = length / (nol + 1);
base_height = led_height + glass_holder_height;

difference()
{
    union()
    {
        difference()
        {
            rotate([-angle,0,0])
            difference()
            {
                union()
                {
                    cube([length + 6,glass_thickness + 8,base_height]);
                    
                    cube([10,glass_thickness + 8,base_height + glass_holder_height]);

                    translate([length-10+6,0,0])
                    cube([10,glass_thickness + 8,base_height + glass_holder_height]);
                }
                
                translate([3,4,led_height])
                cube([length,glass_thickness,50]);
                
                for(i=[1:nol])
                {
                    translate([(ld*i) + 3,(glass_thickness + 8)/2,0])
                    cylinder(r2=((glass_thickness + 8)/2)-1,r1=led_size/2,h=(led_height)+0.1,$fn=28);
                }
                
                translate([1,(glass_thickness + 8)/2,led_height])
                rotate([0,90,0])
                cylinder(r=led_size/2,h=length + 4,$fn=28);
            }

            translate([0,0,-10])
            cube([length + 6,glass_thickness + 18,10]);
        }

        translate([0,1,0])
        cube([20,glass_thickness + 8 + length_support,2]);

        translate([length-20+6,1,0])
        cube([20,glass_thickness + 8 + length_support,2]);
    }
    

    translate([1,(glass_thickness + 8)/2,0])
    rotate([0,90,0])
    cylinder(r=4,h=length + 4,$fn=28);

    translate([10,(glass_thickness + 8)/2,0])
    rotate([-45,0,0])
    cylinder(r=2,h=length + 4,$fn=28);

    translate([length+4-6,(glass_thickness + 8)/2,0])
    rotate([-45,0,0])
    cylinder(r=2,h=length + 4,$fn=28);
}