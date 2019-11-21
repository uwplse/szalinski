// preview[view:south, tilt:top]

//Select the element you want on the coaster.
choose_the_element=1; //[1:Hydrogen, 2:Helium, 3:Lithium, 4:Beryllium, 5:Boron, 6:Carbon, 7:Nitrogen, 8:Oxygen, 9:Fluorine, 10:Neon, 11:Sodium, 12:Magnesium, 13:Aluminium, 14:Silicon, 15:Phosphorus, 16:Sulfur, 17:Chlorine, 18:Argon, 19:Potassium, 20:Calcium]

atomic_number=choose_the_element;

coaster(atomic_number);

element_data=[
[0, "", "", 0],
[1, "H", "Hydrogen", 1.008],
[2, "He", "Helium", 4.003],
[3, "Li", "Lithium", 6.941],
[4, "Be", "Beryllium", 9.012],
[5, "B", "Boron", 10.811],
[6, "C", "Carbon", 12.011],
[7, "N", "Nitrogen", 14.007],
[8, "O", "Oxygen", 15.999],
[9, "F", "Fluorine", 18.998],
[10, "Ne", "Neon", 20.180],
[11, "Na", "Sodium", 22.990],
[12, "Mg", "Magnesium", 24.305],
[13, "Al", "Aluminium", 26.982],
[14, "Si", "Silicon", 28.086],
[15, "P", "Phosphorus", 30.974],
[16, "S", "Sulfur", 32.065],
[17, "Cl", "Chlorine", 35.453],
[18, "Ar", "Argon", 39.948],
[19, "K", "Potassium", 39.098],
[20, "Ca", "Calcium", 40.078]
];

module coaster(atomic_number){  
    
    symbol=element_data[atomic_number][1];
    element=element_data[atomic_number][2];
    atomic_mass=element_data[atomic_number][3];
    
    $fn = 50;
    difference(){
        cylinder(r=45, h=4);
        translate([0, 0, 2]){
            if(atomic_number<=2){
                cylinder(r=22, h=3);
            }
            if(atomic_number<=10 && atomic_number>2){
                cylinder(r=29, h=3);
            }
            if(atomic_number<=18 && atomic_number>10){
                cylinder(r=36, h=3);
            }
            if(atomic_number<=20 && atomic_number>18){
                cylinder(r=43, h=3);
            }
        }
    }
    if(atomic_number>18){
        translate([0, 0, 1]){
            difference(){
                cylinder(r=41, h=3);
                cylinder(r=36, h=4);
                if(atomic_number<=20){
                    for(r=[0:(360/(atomic_number-18)):360]){
                        rotate([0,0,r]){
                            translate([0, 38.5, 4]){
                                sphere(r=2);
                            }
                        }
                    }
                }
            }
        }
    }
    if(atomic_number>10){
        translate([0, 0, 1]){
            difference(){
                cylinder(r=34, h=3);
                cylinder(r=29, h=4);
                if(atomic_number<=18){
                    for(r=[0:(360/(atomic_number-10)):360]){
                        rotate([0,0,r]){
                            translate([0, 31.5, 4]){
                                sphere(r=2);
                            }
                        }
                    }
                }
                if(atomic_number>18){
                    for(r=[0:(360/8):360]){
                        rotate([0,0,r]){
                            translate([0, 31.5, 4]){
                                sphere(r=2);
                            }
                        }
                    }
                }
            }
        }
    }
    if(atomic_number>2){
        translate([0, 0, 1]){
            difference(){
                cylinder(r=27, h=3);
                cylinder(r=22, h=4);
                if(atomic_number<=10){
                    for(r=[0:(360/(atomic_number-2)):360]){
                        rotate([0,0,r]){
                            translate([0, 24.5, 4]){
                                sphere(r=2);
                            }
                        }
                    }
                }
                if(atomic_number>10){
                    for(r=[0:(360/8):360]){
                        rotate([0,0,r]){
                            translate([0, 24.5, 4]){
                                sphere(r=2);
                            }
                        }
                    }
                }
            }
        }
    }
    translate([0, 0, 1]){
        difference(){
            cylinder(r=20, h=3);
            cylinder(r=15, h=4);
            if(atomic_number<=2){
                for(r=[0:(360/atomic_number):360]){
                    rotate([0,0,r]){
                        translate([0, 17.5, 4]){
                            sphere(r=2);
                        }
                    }
                }
            }
            if(atomic_number>2){
                for(r=[0:(360/2):360]){
                    rotate([0,0,r]){
                        translate([0, 17.5, 4]){
                            sphere(r=2);
                        }
                    }
                }
            }
        }
    }
    font_choice="Russo One"; //set font
    linear_extrude(height=4){
        translate([0, 10, 2]){
            text(str(atomic_number), font=font_choice, size=3, halign="center", valign="center");
        }
        translate([0, 2, 2]){
            text(symbol, size=6, font=font_choice, halign="center", valign="center");
        }
        translate([0, -6, 2]){
            text(element, size=3, font=font_choice, halign="center", valign="center", spacing=1.2);
        }
        translate([0, -10, 2]){
            text(str(atomic_mass), size=3, font=font_choice, halign="center", valign="center", spacing=1.2);
        }
    }
}