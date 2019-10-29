/* [Led Type] */
side_opened= "true"; //[true:Opened, false:Closed]
led_diameter= 3; //[3:3mm, 5:5mm, 8:8mm, 10:10mm]
number_of_pins= 2; //[2:2, 3:3, 4:4]
pins_spacing= 2.54;
height= 10;

difference () {
    cylinder (h= height, d= led_diameter + 1, $fn= 50);
    union () {
        if (number_of_pins == 2) {
            translate ([-pins_spacing / 2, 0, -0.1]) cylinder (h= height + 0.2, d= 1, $fn= 32);
            translate ([pins_spacing / 2, 0, -0.1]) cylinder (h= height + 0.2, d= 1, $fn= 32);
            if (side_opened == "true" && pins_spacing > 1) {
                translate ([pins_spacing / 2 + 50, 0, height / 2])
                    cube (size= [100, 1, height + 0.2], center= true);
                translate ([-pins_spacing / 2 - 50, 0, height/ 2])
                    cube (size= [100, 1, height + 0.2], center= true);
            }
        } else if (number_of_pins == 3) {
            translate ([0, 0, -0.1]) cylinder (h= height + 0.2, d= 1, $fn= 50);
            translate ([-pins_spacing, 0, -0.1]) cylinder (h= height + 0.2, d= 1, $fn= 32);
            translate ([pins_spacing, 0, -0.1]) cylinder (h= height + 0.2, d= 1, $fn= 32);
            if (side_opened == "true" && pins_spacing > 1) {
                translate ([-0.5, 0, -0.1]) cube (size= [1, 100, height + 0.2]);
                translate ([pins_spacing - 0.5, 0, -0.1]) cube (size= [1, 100, height + 0.2]);
                translate ([-pins_spacing - 0.5, 0, -0.1]) cube (size= [1, 100, height + 0.2]);
            }
        } else if (number_of_pins == 4) {
            translate ([-pins_spacing / 2, 0, -0.1]) cylinder (h= height + 0.2, d= 1, $fn= 32);
            translate ([pins_spacing / 2, 0, -0.1]) cylinder (h= height + 0.2, d= 1, $fn= 32);
            translate ([-pins_spacing - pins_spacing / 2, 0, -0.1])
                cylinder (h= height + 0.2, d= 1, $fn= 32);
            translate ([pins_spacing + pins_spacing / 2, 0, -0.1])
                cylinder (h= height + 0.2, d= 1, $fn= 32);
            if (side_opened == "true" && pins_spacing > 1) {
                translate ([pins_spacing / 2 - 0.5, 0, -0.1]) cube (size= [1, 100, height + 0.2]);
                translate ([-pins_spacing / 2 - 0.5, 0, -0.1]) cube (size= [1, 100, height + 0.2]);
                translate ([pins_spacing + pins_spacing / 2 - 0.5, 0, -0.1])
                    cube (size= [1, 100, height + 0.2]);
                translate ([-pins_spacing - pins_spacing / 2 - 0.5, 0, -0.1])
                    cube (size= [1, 100, height + 0.2]);
            }
        }
        if (pins_spacing <= 1)
        {
            translate ([0, 0, height / 2])
                cube (size= [(number_of_pins - 1) * pins_spacing, 1, height + 0.2],
                center= true);
            if (side_opened == "true")
                translate ([0, 50, height / 2])
                    cube (size= [(number_of_pins - 1) * pins_spacing + 1, 100, height + 0.2],
                    center= true);
        }
    }
}