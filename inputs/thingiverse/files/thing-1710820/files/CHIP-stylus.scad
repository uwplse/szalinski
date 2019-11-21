//How long your PocketCHIP stylus should be?
Length=140;//[40:300]
leng=Length-11;

//What's diameter of PoketCHIP stylus?
Width=8;//[6:12]
rad=Width/2;

//Gap of "clamp". Depends on the thickness of your PoketCHIP's PCB and accuracy of your printer.
Gap=1.4;
difference(){
    union(){
        $fn=70;
        translate([-Width/2,0,0])
        cube([Width,15,15]);
        cylinder(leng, rad, rad);
        translate([0,0,leng])
        cylinder(10, rad, 1);
        translate([0,0,leng+10])
        sphere([1]);
    }
    translate([-Gap/2, rad, -0.1])
    cube([Gap, 20, 20]);
}