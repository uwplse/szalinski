// This is the name of the element. Use the element symbol here.
element = "H";

//This is the number of covalent bonds the atom makes.
bonds = 1; // min/max:[1:4]

module main(){
union(){
    translate([0,0,-3]) cylinder(3,40,40);
    translate([-10,-10,0]) scale([2,2,5]) linear_extrude(0.6) text(element);

    if(bonds>=1){
        translate ([30,0,0]) cylinder(10,6,6);
    }
    if(bonds>=2){
        translate ([-30,0,0]) cylinder(10,6,6);
    }
    if(bonds>=3){
        translate ([0,30,0]) cylinder(10,6,6);
    }
    if(bonds>=4){
        translate ([0,-30,0]) cylinder(10,6,6);
    }
}
}

main();