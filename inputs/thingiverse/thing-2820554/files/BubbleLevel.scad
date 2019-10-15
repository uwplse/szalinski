// Tripod head, base diameter
head_diameter = 51; // possible values
//bubble level diameter
bubble_diameter = 18; // possible values

difference()
    {
        difference()
        {
            difference()
            {
            hull()
                {
                cylinder($fn=100, 4, d=head_diameter+5, true);
                translate([(head_diameter/2) + (bubble_diameter/2) + 2.5,0,0]) cylinder($fn=100, 4, d=bubble_diameter+4, true);
                }
            translate([0,0,-10]) cylinder($fn=100, 20, d=10);
            }
        translate([0,0,2]) cylinder($fn=100, 4, d=head_diameter, true);
        }
    translate([(head_diameter/2) + (bubble_diameter/2) + 2.5,0,2]) cylinder($fn=100, 4, d=bubble_diameter, true);
    }