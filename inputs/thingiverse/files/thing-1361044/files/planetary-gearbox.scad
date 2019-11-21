/*  For physics used, refer to https://woodgears.ca/gear/planetary.html */

use <MCAD/involute_gears.scad>

$fn = 50 * 1;
PI = 3.14 * 1;

R = 168;                //  Amount of teeth in the ring
P = 74;                 //  Amount of teeth in the planets
S = 20;                 //  Amount of teeth in the sun

play = 0.075;           //  Play between the parts

pitch = 2.25;           //  The pitch of the gears
pAngle = 35;            //  The pressure angle of the gears
thicknessGear = 6;      //  The thickness of the gears
amountPlanets = 3;      //  The amount of planets in the gear, choose 3 or more
twistFactor = 2;        //  A measure for the angle of the herringbone gears. I believe for a factor of 2, the gear rotates 2 times the pitch over its height

extraRingHeight = 3.7;  //  The extra height of the ring gear for the screwholes
screwThreadRadius = 2;  //  Radius of the screw holes
amountScrews = 3;       //  Amount of screw holes
thickness = 3;      //  Wall thickness of the parts

planetAxRadius = 5;     //  Radius of the ax coming out of the planets
planetAxHeight = 6;     //  Radius of the ax coming out of the planets

SPitchRadius = S * pitch / (2 * PI);
RPitchRadius = R * pitch / (2 * PI);
PPitchRadius = P * pitch / (2 * PI);

module planet(){
    union(){
        createGear(P, PPitchRadius, 1);
        translate([0, 0, thicknessGear]){
            cylinder(r = planetAxRadius, h = planetAxHeight);
        }
    }
}

module sun(){
    difference(){
        createGear(S, SPitchRadius, -1);
        motorMount();
    }
}

module ring(){
    union(){
        difference(){
            hull(){
                cylinder(r = R * pitch / (2 * PI) + thicknessGear, h = extraRingHeight);
                for(i = [1:amountScrews]){
                    rotate([0,0,i * 360 / amountScrews]){
                        translate([0, R * pitch / (2 * PI) + thicknessGear + thickness + screwThreadRadius,0]){
                            cylinder(r = thickness + screwThreadRadius, h = extraRingHeight);
                        }
                    }
                }
            }
            translate([0, 0, -0.1])
            {
                cylinder(r = RPitchRadius / 1.1, h = extraRingHeight + 0.1);
            }
            for(i = [1:amountScrews]){
                rotate([0,0,i * 360 / amountScrews]){
                    translate([0, R * pitch / (2 * PI) + thicknessGear + thickness + screwThreadRadius,0]){
                        cylinder(r = screwThreadRadius, h = extraRingHeight);
                    }
                }
            }
        }
        
        translate([0,0,extraRingHeight]){
            difference(){
                cylinder(r = R * pitch / (2 * PI) + thicknessGear, h = thicknessGear);
                createGear(R, RPitchRadius, 1);
            }
        }
    }
}

module motorMount()
{
    
}

module createGearSub(teeth, pitchRadius, twistDirection){
    gear (
        number_of_teeth = teeth,
        circular_pitch = 180 / PI * pitch,
        diametral_pitch = false,
        pressure_angle = pAngle,
        clearance = play,
        gear_thickness = thicknessGear / 2,
        rim_thickness = thicknessGear / 2,
        rim_width = thicknessGear / 2,
        hub_thickness = thicknessGear / 2,
        hub_diameter = 0,
        bore_diameter = 0,
        circles = 0,
        backlash = 0,
        twist = twistDirection * twistFactor / (2 * PI * pitchRadius) * 360,
        involute_facets = 0,
        flat = false
    );
}

module createGear(T, R, t){
    createGearSub(T, R, t);
    
    rotate([0,0,-t * twistFactor / (2 * PI * R) * 360]){
        translate([0,0,thicknessGear / 2]){
            createGearSub(T, R, -t);
        }
    }
}

module gearCarrier(){
    difference(){
        union(){
            hull(){
                for(i = [1:amountPlanets]){
                    rotate([0,0,i * 360 / amountPlanets]){
                        translate([0, (RPitchRadius + SPitchRadius) / 2, 0]){
                            cylinder(r = planetAxRadius + thickness, h = planetAxHeight);
                        }
                    }
                }
            }
        }
        for(i = [1:amountPlanets]){
            rotate([0,0,i * 360 / amountPlanets]){
                translate([0, (RPitchRadius + SPitchRadius) / 2, -0.1]){
                    cylinder(r = planetAxRadius + play, h = planetAxHeight + 0.2);
                }
            }
        }
    }
}

module assembly(){
    scale(SPitchRadius / (SPitchRadius + play)){
        rotate([0,0,0*twistFactor]){
            sun();
        }
    }
    scale((RPitchRadius + play) / RPitchRadius){
        rotate([0,0,2.5*twistFactor]){
            ring();
        }
    }
    translate([2 * RPitchRadius + 2 * thicknessGear + 2 * thickness + 2 * screwThreadRadius, 0, 0]){
        for(i = [1:amountPlanets]){
            rotate([0,0,i * 360 / amountPlanets]){
                translate([0, (RPitchRadius + SPitchRadius) / 2 - play / 2, 0]){
                    scale(PPitchRadius / (PPitchRadius + play)){
                        rotate([0,0,-5*twistFactor]){
                            planet();
                        }
                    }
                }
            }
        }
    }
    translate([-2 * RPitchRadius - 2 * thicknessGear, 0, 0]){
        rotate([0,0,-30]){
            gearCarrier();
        }
    }
}

assembly();