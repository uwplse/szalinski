//CUSTOMIZER VARIABLES

//	Number of bits on each side
number_of_bits_per_side = 6;	//	[1:50]

//	Decorative text on the side
decorative_text = "hackmeister.dk";

//CUSTOMIZER VARIABLES END


module hex(size, length)
{
    union()
    {
        rotate(30, [0, 0, 1])
            cube([size, size/sqrt(3), length], center = true);
        rotate(90, [0, 0, 1])
            cube([size, size/sqrt(3), length], center = true);
        rotate(150, [0, 0, 1])
            cube([size, size/sqrt(3), length], center = true);
    }
}

module bitHolder(numberOfBits, embossing)
{
    spacing = 10.07;
    difference()
    {
        union()
        {
            hull()
            {
                translate([-((numberOfBits-1)*spacing)/2, 0, 8])
                    cylinder(r1 = 15/2, r2 = 11/2, h = 8, center = true, $fn = 80);

                translate([-((numberOfBits-1)*spacing)/2, 0, 0])
                    cylinder(r = 15/2, h = 8, center = true, $fn = 80);

                translate([-((numberOfBits-1)*spacing)/2, 0, -8])
                    cylinder(r2 = 15/2, r1 = 11/2, h = 8, center = true, $fn = 80);

         
                translate([((numberOfBits-1+2)*spacing)/2, 0, 8])
                    cylinder(r1 = 15/2, r2 = 11/2, h = 8, center = true, $fn = 80);

                translate([((numberOfBits-1+2)*spacing)/2, 0, 0])
                    cylinder(r = 15/2, h = 8, center = true, $fn = 80);

                translate([((numberOfBits-1+2)*spacing)/2, 0, -8])
                    cylinder(r2 = 15/2, r1 = 11/2, h = 8, center = true, $fn = 80);
            }
        }
        union()
        {
            // bits upper side
            for(i = [0:numberOfBits-1])
            {
                translate([-((numberOfBits-1)*spacing)/2 + i * 10, 0, 8])
                    hex(7.2, 8.1);
            }

            // magnets
            for(i = [0:numberOfBits-1])
            {
                translate([-((numberOfBits-1)*spacing)/2 + i * 10, 0, 0])
                    cylinder(r = 11/2, h = 4, center = true, $fn = 40);

            }

            // bits lower side
            for(i = [0:numberOfBits-1])
            {
                translate([-((numberOfBits-1)*spacing)/2 + i * 10, 0, -8])
                    hex(7.2, 8.1);
            }

            // cutout for string            
            translate([((numberOfBits-1+2)*spacing)/2, 0, 8])
                cylinder(r = 9/2, h = 8.1, center = true, $fn = 80);

            hull()
            {
                translate([((numberOfBits-1+2)*spacing)/2+2, 0, 0])
                    cylinder(r = 4/2, h = 8, center = true, $fn = 80);
                translate([((numberOfBits-1+2)*spacing)/2-2, 0, 0])
                    cylinder(r = 4/2, h = 8, center = true, $fn = 80);
            }
            
            translate([((numberOfBits-1+2)*spacing)/2, 0, -8])
                cylinder(r = 9/2, h = 8.1, center = true, $fn = 80);
            
            // text decoration
            translate([5, -15/2+1/2, 0])
            rotate(90, [1, 0, 0])
            linear_extrude(height = 1)
            {
                text(embossing, size = 6, font = "Helvetica Neue:style=Bold", valign = "center", halign = "center");
            }
        }
    }
}

module strap_plug()
{
    difference()
    {
        cylinder(r = 8.6/2, r2 = 8.9/2, h = 5, $fn = 80);
        
        cylinder(r = 3.1/2, h = 6, $fn = 20);

        cylinder(r2 = 3.1/2, r1 = 6/2, h = 3, $fn = 40);

        translate([0, 0, 4])
            cylinder(r1 = 3.1/2, r2 = 4.5/2, h = 1, $fn = 40);
    }    
}

//bitHolder(4, "TX");
//bitHolder(2, "PH");
//bitHolder(2, "PZ");
//bitHolder(7, "hackmeister.dk");
bitHolder(number_of_bits_per_side, decorative_text);

//strap_plug();