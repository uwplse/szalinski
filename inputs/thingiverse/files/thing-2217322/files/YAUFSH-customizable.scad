$fn = 128;

spoolHolderUpperDiameter = 60;
spoolHolderLowerDiameter = 38;
spoolHolderHeight = 10;
spoolHolderThickness = 2;

bearingOuterDiameter = 22.2;
bearingHoleDiameter = 8;
bearingHeight = 7;

spokeThickness = 2;

a = (spoolHolderUpperDiameter-spoolHolderLowerDiameter)/2;
b = spoolHolderHeight;
c = sqrt(a*a+b*b);
q = (a*a)/c;
p = c-q;
h = sqrt(p*q);
beta = asin(h/a);
alpha = 90 - beta;
hNew = h + spoolHolderThickness;
pNew = hNew/tan(alpha);
qNew = hNew*hNew/pNew;
cNew = qNew+pNew;
aNew = sqrt(cNew*qNew);
bNew = sqrt(cNew*cNew-aNew*aNew);
offsetNew = (aNew-a)*2;

module basicShape() {
    difference() {
        // ---------- outer ----------
        cylinder(h=spoolHolderHeight, d1=spoolHolderLowerDiameter, d2=spoolHolderUpperDiameter);

        // ---------- inner ----------
        translate([0,0,-0.01])
        cylinder(h=spoolHolderHeight+0.02, d1=spoolHolderLowerDiameter-offsetNew, d2=spoolHolderUpperDiameter-offsetNew);
    }
};

module spokes() {
    difference() {
        // ---------- basic spokes ----------
        union() {
            translate([-spoolHolderUpperDiameter/2, -spokeThickness/2, 0])
            cube([spoolHolderUpperDiameter, spokeThickness, bearingHeight]);

            rotate([0, 0, 45])
            translate([-spoolHolderUpperDiameter/2, -spokeThickness/2, 0])
            cube([spoolHolderUpperDiameter, spokeThickness, bearingHeight]);

            rotate([0, 0, 90])
            translate([-spoolHolderUpperDiameter/2, -spokeThickness/2, 0])
            cube([spoolHolderUpperDiameter, spokeThickness, bearingHeight]);

            rotate([0, 0, 135])
            translate([-spoolHolderUpperDiameter/2, -spokeThickness/2, 0])
            cube([spoolHolderUpperDiameter, spokeThickness, bearingHeight]);
        };

        // ---------- cast ----------
        translate([0, 0, -0.01])
        difference() {
            translate([-spoolHolderUpperDiameter, -spoolHolderUpperDiameter, 0])
                cube([spoolHolderUpperDiameter*2, spoolHolderUpperDiameter*2, spoolHolderHeight]);

            translate([0, 0, -0.01])
                cylinder(h=spoolHolderHeight+0.02, d1=spoolHolderLowerDiameter-0.2, d2=spoolHolderUpperDiameter-0.2);
        };
    };
};


// ---------- finally: le spool holder ----------
union() {
    difference() {
        union() {
            // ---------- bearing cage ----------
            cylinder(h=bearingHeight+spoolHolderThickness, d=bearingOuterDiameter+spoolHolderThickness*2);
            
            // ---------- spokes ----------
            spokes();
        };

        // ---------- cutout bearing ----------
        translate([0, 0, spoolHolderThickness+0.01])
            cylinder(h=bearingHeight, d=bearingOuterDiameter);

        // ---------- cutout axle ----------
        translate([0, 0, -spoolHolderHeight])
            cylinder(h=spoolHolderHeight*3, d=bearingOuterDiameter-6);
    };

    basicShape();
};