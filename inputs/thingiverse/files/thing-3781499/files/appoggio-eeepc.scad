gancio_y=26;
gancio_z=6;

appoggio=22;

larghezza_tot=30;

eeepc_z=29;
eeepc_y=179;

sp=4;

module gancio(){
    difference(){
    cube([larghezza_tot,gancio_y,gancio_z]);
    translate([0,0,gancio_z-2])cube([larghezza_tot,gancio_y-sp,2]);
         }
    }

module appoggio_inf(){
    cube([larghezza_tot,appoggio,appoggio]);
    }

module corpo(){
    difference(){
        cube([larghezza_tot,eeepc_y+2*sp,eeepc_z+2*sp]);
        translate([0,sp,sp])
        cube([larghezza_tot,eeepc_y,eeepc_z]); // vuoto per eeepc
        translate([0,sp+30/2,sp])
        #cube([larghezza_tot,eeepc_y-30,eeepc_z+sp]); // vuoto per alette superiori
        }
    }

translate([0,0,appoggio])corpo();
translate([0,140,appoggio-gancio_z])gancio();
translate([0,40,0])appoggio_inf();