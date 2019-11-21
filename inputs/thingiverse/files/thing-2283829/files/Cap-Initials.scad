// preview[view:south, tilt:top]

/* [Global] */

/* [Initials] */
//Initials to add?
initials = "QZ";
/* [Cap] */
//Cap Size?
cap_size = 22.015;
/* [Peg] */
//Inner Peg Size?
inner_peg = 8;

/* [Hidden] */
adjustment= -1 * (len(initials) / 2) - len(initials) ;
cap_inner = 1.25 + inner_peg;

print_cap();


module print_cap() {
    difference() {
        difference() {
            union() {
                union () {
                    cylinder(h=2.5,d=cap_size,$fa=0.0125,$fs=0.0125); 
                    cylinder(h=3.5,d=cap_inner,$fa=0.0125,$fs=0.0125);
                    
                }
                cylinder(h=5,d=inner_peg,$fa=0.0125,$fs=0.0125);
            }
            cylinder(h=2,d1=5,d2=3,$fa=0.0125,$fs=0.0125);   
        }
        for(r=[0:3]) {
            linear_extrude(1) rotate(a=(120*r),v=[0,0,1]) translate ([adjustment,5,0])text(initials, size=3,halign=true,valign=true);
        }
    }
}