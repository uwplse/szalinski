/* [Parameters] */

width = 25;
height = 20;
gap = 2;
namePlateWidth = 10;
namePlateHeight = 5;

/* [Hidden] */
woodThick = 1.2;
woodGap = 0.4;
boardThick = 3;
baseThick = 2;
boxHeight = gap + woodThick + baseThick;

$fn = 32;

module frameBase(w, h)
{
    
    angle = atan2(h, w);

    difference() {
            union() {
            difference() {
                // main box
                cube([w, h, boxHeight], center=true);
                
                // start geometry for gaps
                translate([w/2, h/2, 0])
                rotate([0,0,45])
                cube([boardThick*3, woodGap, boxHeight*2], center=true);

                translate([-w/2, h/2, 0])
                rotate([0,0,-45])
                cube([boardThick*3, woodGap, boxHeight*2], center=true);

                translate([-w/2, h/2, 0])
                rotate([0,0,-45])
                cube([boardThick*3, woodGap, boxHeight*2], center=true);

                translate([-w/2, -h/2, 0])
                rotate([0,0,45])
                cube([boardThick*3, woodGap, boxHeight*2], center=true);

                translate([w/2, -h/2, 0])
                rotate([0,0,-45])
                cube([boardThick*3, woodGap, boxHeight*2], center=true);

                // extra corner boxes
                translate([w/2-woodGap*2,h/2-woodGap*2, -boxHeight])
                cube([5,5, boxHeight*2]);

                translate([-w/2+woodGap*2,h/2-woodGap*2, -boxHeight])
                rotate([0,0,90])
                cube([5,5, boxHeight*2]);

                translate([-w/2+woodGap*2,-h/2+woodGap*2, -boxHeight])
                rotate([0,0,180])
                cube([5,5, boxHeight*2]);

                translate([w/2-woodGap*2,-h/2+woodGap*2, -boxHeight])
                rotate([0,0,-90])
                cube([5,5, boxHeight*2]);
                
                translate([0,0, (boxHeight/2) + 2.5 + 1])
                cube([w+5, h+5, 5], center=true);
            }

            
            translate([0,0,-woodGap/2])
            cube([w-(woodGap*2), h-(woodGap*2), boxHeight-woodGap], center=true);
            }
            
            cube([w-(boardThick*2), h-(boardThick*2), boxHeight*2], center=true);
        
        translate([0,0,-woodThick])
        cube([w-(woodThick*2), h-(woodThick*2), boxHeight], center=true);
    }
}

module namePlate(w, h, thick)
{
    difference() {
        scale([1,1.2,1])
        cylinder(r=w/2, h=thick);
        
        translate([-w,h/2,-1.5])
        cube([w*2, h*5, thick*3]);

        rotate([0,0,180])    
        translate([-w,h/2,-1.5])
        cube([w*2, h*5, thick*3]);    
    }
}


module frame(w, h)
{
    totalWidth = w + ((woodThick + 0.5)*2);
    totalHeight = h + ((woodThick + 0.5)*2);
    
    namePlatePos = h/2;// - boardThick/2;
    
    union() {
        difference() {
            frameBase(totalWidth, totalHeight);

            translate([0, namePlatePos, boxHeight/2-woodThick/2])
            namePlate(namePlateWidth+(woodGap*2),namePlateHeight+(woodGap*2), 2);
        }

        translate([0, namePlatePos, boxHeight/2-woodThick/2-0.1])
        scale([1,1,woodThick/2+0.1])
        namePlate(namePlateWidth,namePlateHeight, 1);
    }
}

module insert(w, h)
{
    cube([w, h, baseThick], center=true);
}


translate([0,0,boxHeight/2])
rotate([180,0,0])
frame(width, height);

translate([width + 10,0,baseThick/2])
// translate([0,0,boxHeight])

insert(width, height);