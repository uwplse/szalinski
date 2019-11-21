/////////////////
////Variables////
/////////////////
type="Atom"; //[Atom, Electron]
element=1; //[1:Hydrogen, 2:Boron, 3:Carbon, 4:Nitrogen, 5:Oxygen, 6:Hologen (X)]
//7:Phosphorus, 8:Sulfur IV, 9:Sulphur VI]
//Distance between electron positions on atom.
atom_size=20; //[10:30]
electron="Lone Pair"; //[Lone Pair, Valence, Flexible Valence]
//Length of valence electrons, actual bond length is double.
bond_length=30; //[10:50]
/*[Hidden]*/
$fn=36;

{element_data=[
[0, "", "", ""],
[1, "H", "Hydrogen", "single"],
[2, "B", "Boron", "trigonal planar"],
[3, "C", "Carbon", "tetrahedral"],
[4, "N", "Nitrogen", "tetrahedral"],
[5, "O", "Oxygen", "tetrahedral"],
[6, "X", "Halogen", "tetrahedral"],
[7, "P", "Phosphorus", "trigonal bipyrimidal"],
[8, "S 4", "Sulfur IV", "trigonal bipyrimidal"],
[9, "S 6", "Sulfur VI", "octahedral"],
];}

///////////////
////Modules////
///////////////
module element_core(element, atom_size){
    rotate(a=90, v=[0, 1, 0]){
        difference (){
            cylinder(d=(atom_size/2), h=2);
            scale([1, 1, 2]){
                translate([0, 0, -1]){
                    rotate(a=90, v=[0, 0, 1]){
                        linear_extrude(h=2){
                            text(element_data[element][1], size=atom_size/4, font="SirinStencil", halign="center", valign="center");
                        }
                    }
                }
            }
        }
    }
}
module molecular_geometry(element, atom_size){
    geometry=element_data[element][3];
    if (geometry=="single"){
        translate([1, 0, 2*(atom_size/8)+2.5]){
            difference(){
                sphere(d=5);
                sphere(d=4);
                translate([-2.5, -2.5, 1]){
                    cube([5, 5, 1.5]);
                }
            }
        }
        translate([1, 0, (atom_size/4)-0.5]){
            cylinder(d=2, h=1);
        }
    }
    if (geometry=="trigonal planar"){
        translate([1, 0, (atom_size/4)-0.5]){
            cylinder(d=2, h=(atom_size/3));
        }
        translate([1, 0, 0]){
            difference(){
                union(){
                    translate([0, 0, 2*(atom_size/3)]){
                        sphere(d=5);
                    }
                    translate([0, (cos(30))*(2*(atom_size/3)), -(atom_size/3)]){
                        sphere(d=5);
                    }
                    translate([0, -(cos(30))*(2*(atom_size/3)), -(atom_size/3)]){
                        sphere(d=5);
                    }
                    rotate(a=90, v=[1, 0, 0]){
                        translate([0, -(atom_size/3), -(atom_size/2)]){
                            cylinder(d=2, h=atom_size);
                        }
                    }
                    rotate(a=150, v=[1, 0, 0]){
                        translate([0, (atom_size/3), -(atom_size/2)]){
                            cylinder(d=2, h=atom_size);
                        }
                    }
                    rotate(a=210, v=[1, 0, 0]){
                        translate([0, -(atom_size/3), -(atom_size/2)]){
                            cylinder(d=2, h=atom_size);
                        }
                    }
                }
                translate([0, 0, 2*(atom_size/3)]){
                    sphere(d=4);
                    translate([-2.5, -2.5, 1]){
                        cube([5, 5, 1.5]);
                    }
                }
                rotate(a=-120, v=[1, 0, 0]){
                    translate([0, 0, 2*(atom_size/3)]){
                        sphere(d=4);
                        translate([-2.5, -2.5, 1]){
                            cube([5, 5, 1.5]);
                        }
                    }
                }
                rotate(a=120, v=[1, 0, 0]){
                    translate([0, 0, 2*(atom_size/3)]){
                        sphere(d=4);
                        translate([-2.5, -2.5, 1]){
                            cube([5, 5, 1.5]);
                        }
                    }
                }
            }
        }
    }
    if (geometry=="tetrahedral"){
        translate([1, 0, (atom_size/4)-0.5]){
                cylinder(d=2, h=(atom_size/4)-0.5);
            }
        translate([1, 0, -atom_size/4]){
            difference(){
                union(){
                    translate([(atom_size/3)-1, atom_size/2, 0]){
                        sphere(d=5);
                    }
                    translate([-(cos(30))*(2*(atom_size/3)), 0, 0]){
                        sphere(d=5);
                    }
                    translate([(atom_size/3)-1, -(atom_size/2), 0]){
                        sphere(d=5);
                    }
                    translate([0, 0, 4*(atom_size/5)]){
                        sphere(d=5);
                    }
                    translate([(atom_size/3)-1, atom_size/2, 0]){
                        rotate(a=0, v=[0, 0, 1]){
                            rotate(a=90, v=[1, 0, 0]){
                                cylinder(d=2, h=atom_size);
                            }
                        }
                    }
                    translate([-(cos(30))*(2*(atom_size/3)), 0, 0]){
                        rotate(a=60, v=[0, 0, 1]){
                            rotate(a=90, v=[1, 0, 0]){
                                cylinder(d=2, h=atom_size);
                            }
                        }
                    }
                    translate([-(cos(30))*(2*(atom_size/3)), 0, 0]){
                        rotate(a=120, v=[0, 0, 1]){
                            rotate(a=90, v=[1, 0, 0]){
                                cylinder(d=2, h=atom_size);
                            }
                        }
                    }
                    translate([-(cos(30))*(2*(atom_size/3)), 0, 0]){
                        rotate(a=90, v=[0, 0, 1]){
                            rotate(a=35, v=[1, 0, 0]){
                                cylinder(d=2, h=atom_size);
                            }
                        }
                    }
                    translate([(atom_size/3)-1, (atom_size/2), 0]){
                        rotate(a=-30, v=[0, 0, 1]){
                            rotate(a=35, v=[1, 0, 0]){
                                cylinder(d=2, h=atom_size);
                            }
                        }
                    }
                    translate([(atom_size/3)-1, -(atom_size/2), 0]){
                        rotate(a=210, v=[0, 0, 1]){
                            rotate(a=35, v=[1, 0, 0]){
                                cylinder(d=2, h=atom_size);
                            }
                        }
                    }
                }
                translate([0, 0, 4*(atom_size/5)]){
                    sphere(d=4);
                    translate([-2.5, -2.5, 1]){
                        cube([5, 5, 1.5]);
                    }
                }
                translate([-(cos(30))*(2*(atom_size/3)), 0, 0]){
                    rotate(a=270, v=[0, 0, 1]){
                        rotate(a=120, v=[1, 0, 0]){
                            sphere(d=4);
                            translate([-2.5, -2.5, 1]){
                                cube([5, 5, 1.5]);
                            }
                        }
                    }
                }
                translate([(atom_size/3)-1, atom_size/2, 0]){
                    rotate(a=150, v=[0, 0, 1]){
                        rotate(a=120, v=[1, 0, 0]){
                            sphere(d=4);
                            translate([-2.5, -2.5, 1]){
                                cube([5, 5, 1.5]);
                            }
                        }
                    }
                }
                translate([(atom_size/3)-1, -atom_size/2, 0]){
                    rotate(a=30, v=[0, 0, 1]){
                        rotate(a=120, v=[1, 0, 0]){
                            sphere(d=4);
                            translate([-2.5, -2.5, 1]){
                                cube([5, 5, 1.5]);
                            }
                        }
                    }
                }
            }
        }
    }
}

module lone_pair(){
    difference(){
        union(){
            sphere(d=4);
            cylinder(d=2, h=5);
            translate([0, 0, 5]){
                sphere(d=4);
            }
            translate([0, 0, 5]){
                cylinder(d=4, h=4);
            }
            translate([0, 0, 9]){
                sphere(d=4);
            }
            translate([0, -4, 11]){
                sphere(d=8);
            }
            translate([0, 4, 11]){
                sphere(d=8);
            }
        }
        translate([-2, -0.25, -2]){
            cube([4, 0.5, 5]);
        }
        translate([-1, 0, 3]){
            rotate(a=90, v=[0, 1, 0]){
                cylinder(d=0.5, h=2);
            }
        }
    }   
}
module valence(bond_length){
    difference(){
        union(){
            sphere(d=4);
            cylinder(d=2, h=5);
            translate([0, 0, 5]){
                sphere(d=4);
            }
            translate([0, 0, 5]){
                rotate(a=atan(4/bond_length), v=[1, 0, 0]){
                    cylinder(d=4, h=bond_length);
                }
            }
            translate([0, -4, bond_length+5]){
                sphere(d=8);
            }
            translate([0, -4, bond_length+5]){
                rotate(a=-90, v=[1, 0, 0]){
                    cylinder(d=4, h=8);
                }
            }
        }
        difference(){
            translate([0, -4, bond_length+5]){
                rotate(a=-90, v=[1, 0, 0]){
                    cylinder(d=4, h=8);
                }
            }
            translate([0, -4, bond_length+3]){
                cube([2, 8, 4]);
            }
        }
        translate([-2, -0.25, -2]){
            cube([4, 0.5, 5]);
        }
        translate([-1, 0, 3]){
            rotate(a=90, v=[0, 1, 0]){
                cylinder(d=0.5, h=2);
            }
        }
    }
}
module flexible_valence(bond_length){
    difference(){
        union(){
            sphere(d=4);
            cylinder(d=2, h=5);
            translate([0, 0, 5]){
                sphere(d=4);
            }
            translate([-2, 0, 7]){
                rotate(a=atan(4/bond_length), v=[1, 0, 0]){
                    for(i=[0:6:bond_length-6]){
                        translate([0, 0, i]){
                            difference(){
                                rotate(a=90, v=[0, 1, 0]){
                                    cylinder(d=4, h=4);
                                }
                                rotate(a=90, v=[0, 1, 0]){
                                    cylinder(d=2, h=4);
                                }
                                translate([0, 0, -2]){
                                    cube([4, 2, 4]);
                                }
                            }
                            translate([0, 0, 3]){
                                difference(){
                                    rotate(a=90, v=[0, 1, 0]){
                                        cylinder(d=4, h=4);
                                    }
                                    rotate(a=90, v=[0, 1, 0]){
                                        cylinder(d=2, h=4);
                                    }
                                    translate([0, -2, -2]){
                                        cube([4, 2, 4]);
                                    }
                                }
                            }
                        }
                    }
                }
            }
            translate([0, -4, bond_length+5]){
                sphere(d=8);
            }
            translate([0, -4, bond_length+5]){
                rotate(a=-90, v=[1, 0, 0]){
                    cylinder(d=4, h=8);
                }
            }
        }
        difference(){
            translate([0, -4, bond_length+5]){
                rotate(a=-90, v=[1, 0, 0]){
                    cylinder(d=4, h=8);
                }
            }
            translate([0, -4, bond_length+3]){
                cube([2, 8, 4]);
            }
        }
        translate([-2, -0.25, -2]){
            cube([4, 0.5, 5]);
        }
        translate([-1, 0, 3]){
            rotate(a=90, v=[0, 1, 0]){
                cylinder(d=0.5, h=2);
            }
        }
    }
}
//////////////
////Render////
//////////////
if (type=="Atom"){
    element_core(element, atom_size);
    molecular_geometry(element, atom_size);
}
if (type=="Electron"){
    if (electron=="Lone Pair"){
        lone_pair();
    }
    if (electron=="Valence"){
        valence(bond_length);
    }
    if (electron=="Flexible Valence"){
        flexible_valence(bond_length);
    }
}
