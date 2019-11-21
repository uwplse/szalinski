//Bit size
Scale = .3; // [0.25:Small, 0.3:Normal, 0.4:Large]
Phillips = 1; // [0:No, 1:Yes]
Flathead = 0; // [0:No, 1:Yes]
Hex = 0; // [0:No, 1:Yes]

//TEXT LIMIT IS 15 CHARACTERS WITH NO SPACES. SPACES COUNT AS HALF A CHARACTER SINCE THEY TAKE UP LESS SPACE
Text = "it's a screwdriver";

//ROTATION OF BODY AND ROD AND BIT MUST BE ([0,0,90]) BEFORE PRINTING//


rotate([0,0,90]) scale([Scale,Scale,Scale]) /*PHILLIPS BIT*/ scale([Phillips,Phillips,Phillips]) difference() {
    union() {
        translate([30,245,30]) rotate([90,0,0]) cylinder(5,10,10);
        translate([30,255,30]) rotate([90,0,0]) cylinder(10,2,10);
            };
    translate([38,250,30]) scale([.5,20,.5]) sphere(10);
    translate([22,250,30]) scale([.5,20,.5]) sphere(10);
    translate([30,250,38.5]) scale([.5,20,.5]) sphere(10);
    translate([30,250,21.5]) scale([.5,20,.5]) sphere(10);
        }    
    
rotate([0,0,90]) scale([Scale,Scale,Scale]) /*FLATHEAD BIT*/ scale([Flathead,Flathead,Flathead]) difference() {
    translate([30,255,30]) rotate([90,0,0]) cylinder(15,10,10);
    translate([20,255,41]) rotate([0,90,0]) scale([1,2,1]) cylinder(20,10,10);
    translate([20,255,19]) rotate([0,90,0]) scale([1,2,1]) cylinder(20,10,10);
}
    

rotate([0,0,90]) scale([Scale,Scale,Scale]) /*HEX BIT*/ scale([Hex, Hex, Hex]) difference() {
    translate([30,255,30]) rotate([90,0,0]) scale([3.5,3.5,1]) cylinder(15,1.75,1.75);
}


/*ROD*/
rotate([0,0,90]) scale([Scale,Scale,Scale])
        translate([30,240,30]) rotate([90,0,0]) cylinder(120, 10, 10);

/*MAIN BODY*/
rotate([0,0,90]) difference() {
scale([Scale,Scale,Scale]) cube([60,120,60]);
scale([Scale,Scale,Scale]) translate([0,123,0]) rotate([90,90,0]) cylinder(150, 20,20);
scale([Scale,Scale,Scale]) translate([60,123,0]) rotate([90,90,0]) cylinder(150, 20,20);
scale([Scale,Scale,Scale]) translate([0,123,60]) rotate([90,90,0]) cylinder(150, 20,20);
scale([Scale,Scale,Scale]) translate([60,123,60]) rotate([90,90,0]) cylinder(150, 20,20);
scale([Scale,Scale,Scale]) translate([2,115,25]) rotate([90,0,-90]) linear_extrude(3) text(Text);
}