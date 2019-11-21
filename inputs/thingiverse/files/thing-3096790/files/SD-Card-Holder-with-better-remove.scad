num_cards = 20;
sdkarte_dicke = 2.5;
sdkarte_breite = 24.4;
sdkarte_hoehe = 32.4;
sdkarte_offsetx = 3.1;
sdkarte_offsety = 3.1;

mode="both"; // [base, cap, both]

module cards(){
    for(i=[0:num_cards-1]){
      translate([sdkarte_offsetx+(4.5*i),sdkarte_offsety,2]) 
      cube([sdkarte_dicke,sdkarte_breite,sdkarte_hoehe],false);
    }    
}

module base(){
    color([1,0.75,0.75])
    difference(){
        union(){
            cube([num_cards*4.5+4.2,30.6,15]);
            translate([1.1,1.1,0])
            difference () {
                cube([num_cards*4.5+2,28.4,20],false);
                translate([0,28.4/2,25])
                    rotate([0,90,0])
                        cylinder(h=num_cards*4.5+4.2, r=10, center=false);
            }
        }
        cards();
    }

}

module cap(){
    
    translate([0,30.6,21.4])
    rotate([180,0,0])
    color([0.75,0.75,1])
    // translate([0,0,35.6])
    difference(){
        cube([num_cards*4.5+4.2,30.6,21.4]);
    
        color([1,0,1])
        translate([0.9,0.9,-1])
    
        cube([num_cards*4.5+2.4,28.8,6.2]);
        
        translate([2.9,2.9,5])
        cube([num_cards*4.5-1.6,24.8,14.4]);
    }
}

if (mode=="base"){
  base();
}else if (mode =="cap"){
    cap();
}else if (mode =="both"){
    base();
    translate([0,35.6,0])
    cap();
}