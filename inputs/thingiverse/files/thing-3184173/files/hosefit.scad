// 2018-10-29 OpenSCAD hose adapter by Dan Royer @ marginallyclever.com

nozzle1diameter=30;  //[1:1000]
nozzle1height=10;  //[1:1000]

nozzle2diameter=20;  //[1:1000]
nozzle2height=10;  //[1:1000]

wallThickness=2; //[1:0.1:5]

z2 = abs(nozzle1diameter-nozzle2diameter);
z = nozzle1height+(nozzle2height)/2 + z2;
z3 = (nozzle1height+nozzle2height)/2 + z2/2;

intersection() {
    // uncomment this to see a cross section of the shape.
    // translate([-250,0,-250]) { cube(500,500,500,false); }
    
    union() {
        // nozzle 1
        translate([0,0,nozzle1height/2]) {
            difference() 
            {
                cylinder(h=nozzle1height,
                        d=(nozzle1diameter+wallThickness),
                        center=true,
                         $fn=100);
                cylinder(h=nozzle1height+0.01,
                        d=nozzle1diameter,
                        center=true,
                         $fn=100);
                translate([0,0,-(nozzle1height/2 +0.25)]) {
                    cylinder(h=1,
                             d =nozzle1diameter-1,
                             d1=nozzle1diameter+1,
                             center=false,
                             $fn=100);
                }
            }
        }

        // nozzle 2
        translate([0,0,z]) {
            difference() 
            {
                cylinder(h=nozzle2height,
                        d=nozzle2diameter+wallThickness,
                        center=true,
                         $fn=100);
                cylinder(h=nozzle2height+0.01,
                        d=nozzle2diameter,
                        center=true,
                         $fn=100);
                translate([0,0,nozzle2height/2-0.75]) {
                    cylinder(h=1,
                             d =nozzle2diameter+1,
                             d1=nozzle2diameter-1,
                             center=false,
                             $fn=100);
                }
            }
        }

        // cone part
        translate([0,0,nozzle1height+z2/2]) 
        {
            difference() 
            {
                cylinder(h=z2,
                        d1=nozzle1diameter+wallThickness,
                        d=nozzle2diameter+wallThickness,
                        center=true,
                         $fn=100);
                cylinder(h=z2+0.01,
                        d1=nozzle1diameter-1,
                        d=nozzle2diameter-1,
                        center=true,
                         $fn=100);
             
            }
        }
    }
}