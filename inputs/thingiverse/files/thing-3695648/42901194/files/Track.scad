
/* [Basic settings] */
// Rail width (default 40.5)
rw=40.5;    // [35:0.5:40]
// Wheel way width (default 6)
ww=6;       // [5:0.1:7]
// Wheels spread (default 26)
wi=26;      // [20:0.5:30]
// Way depth (default 3)
wd=3;       // [2:0.5:4]
// Rail thickness (default 12)
thick=12;   // [10:0.5:14]
// Female hole diameter (default 13.8)
hd=12.8;      // [10:0.1:20]
// Hole clearance (default 0.5)
hc=0.5;        // [0:0.1:2]
sd=hd-hc;   /* slot diameter */
// Slot width (default 7.35)
sw=7.35;    // [6:0.1:8]

/* [Start and End settings] */
// Type of start
start=1;    // [0: Male, 1:Female]
// Type of end
end=0; // [0: Male, 1:Female]
// Type of female slot
female_slot_spring=1; // [0: Cylinder, 1: Spring]
// Type of male slot
male_slot_spring=1; // [0: Cylinder, 1: Spring]

/* [Flex settings] */
// Type of rail between start and end
between=1;          // [0: Rail, 1: Flex]
// Thickness of flex (default 3)
flex_thick=3;  // [1:0.1:4]
// Flex interval (default: 4)
between_part_length=4; // [3:0.5:6]
// Number of flex
between_count=15;    // [4:1:20]

// Size of end (default 21)
end_slot_size=21; // [15:1:30]
// Length of hook (default 17)
out_slot_length=17; // [15:1:20]
// Rail clearance (default 1)
out_slot_clearance=1; // [0.5:0.1:2]
// Chamfer (default 1)
chamfer=1; // [0:0.1:2]
// Resolution
res=32; // [16:8:64]

/* [Female Spring settings] */
// Width of female spring (default: 3)
wfs=3;  // [1:0.5:4]
// Thickness of female spring (default: 1)
tfs=1;  // [0.5:0.1:2]
// Number of wings (default: 4)
fs_wings=4; // [ 2:1:10]
// Angles of female springs (default: 5)
afs=5; //[4:1:8]
// Start/End angle of wings (default: 100)
fs_as=100;  // [10:5:120]

/* [Hidden] */
$fn=res;

thick2=thick+0.1;
between_length=between_count*between_part_length;
flex_ray=between_part_length/2;

module custom_slot(type)
{
    if (type)
        female_slot();
    else
        male_slot();
}

module flex_part_draw(y)
{
    o=y % 2;
    if (y % 2)
        flex_part();
    else
    {
        scale([1,-1,1])
        flex_part();
    }
}

module flex_part()
{
    re=flex_ray+flex_thick/2;
    ri=flex_ray-flex_thick/2;
    
    intersection()
    {
        translate([-rw/2+re/2, -between_part_length/2+re/2, 0])
        cube([re,re,thick], center=true);
        
        translate([-rw/2+1*re, -between_part_length/2, 0])
        difference()
        {
            cylinder(r=re, h=thick, center=true);
            cylinder(r=ri, h=thick2, center=true);
        }
    }
    
    cube([rw-re*2, flex_thick, thick], center=true);

    intersection()
    {
        translate([rw/2-re/2, -between_part_length/2+re/2+re-flex_thick, 0])
        cube([re,re,thick], center=true);
        
        translate([rw/2-1*re, between_part_length/2, 0])
        difference()
        {
            cylinder(r=re, h=thick, center=true);
            cylinder(r=ri, h=thick2, center=true);
        }
    }
}

module flex()
{
    for(n = [0 : 1 : between_count-1])
    {
        y=-between_length/2+n*between_part_length+between_part_length/2;
        translate([0,y,0]) flex_part_draw(n);
    }
}

module between()
{
    if (between)
    {
        difference()
        {
            flex(between_length+0.01);
            way(between_length+0.02);
        }
    }
    else
        rail(between_length+0.01);
}

module end()
{
    female_slot();
}

bw=between_length/2;
translate([0,bw+end_slot_size/2,0]) rotate([0,0,180]) custom_slot(start);
between();
translate([0,-bw-end_slot_size/2,0]) custom_slot(end);

module one_way(length)
{
    cube([ww,length+0.1,wd], center=true);
    if (chamfer)
    {
        // inside chamfers
        translate([ww/2,0,wd/2])
        rotate([0,45,0])
        cube([chamfer+0.01,length+0.1,chamfer+0.01], center=true);
        translate([-ww/2,0,wd/2])
        rotate([0,45,0])
        cube([chamfer+0.01,length+0.1,chamfer+0.01], center=true);
    }
}

module way(length)
{
   translate([0,0, (thick-wd)/2+0.01 ])
   {
       translate([wi/2, 0, 0])
        one_way(length);
       
       translate([-wi/2, 0, 0])
         one_way(length);
       
   }
} 

module rail(length)
{
   difference()
   {
       cube([rw, length,thick], center=true);
       way(length);
       
       // chamfers
       translate([rw/2,0,thick/2])
       rotate([0,45,0])
       cube([chamfer+0.01,length+0.1,chamfer+0.01], center=true);

       translate([-rw/2,0,thick/2])
       rotate([0,45,0])
       cube([chamfer+0.01,length+0.1,chamfer+0.01], center=true);

   }
}

module slot_end()
{
    rail(end_slot_size);
}

tfs2=2*tfs;

module female_spring_room(angle)
{
    rotate([0,0,angle])
        translate([0,hd/2,0.5])
            cube([wfs+0.4,tfs2+1.5+0.4,thick2],center=true);
}

module female_spring(angle)
{
    rotate([0,0,angle])
        translate([0,hd/2+tfs2/2, -thick/2])
            rotate([afs,0,0])
                translate([0,0,thick/2])
                    cube([wfs,tfs2,thick],center=true);
}

module female_slot()
{
    if (female_slot_spring)
    {
        a1=fs_as;
        da=-2*a1/(fs_wings-1);
        a2=a1+fs_wings*da-da/2;
        intersection()
        {
            union()
            {
                difference()
                {
                    female_slot_base(hd);
                    for(r=[a1:da:a2]) female_spring_room(r);
                }
                for(r=[a1:da:a2]) female_spring(r);
            }
            slot_end();
        }
    }
    else
    {
        female_slot_base(hd);
    }
}

module female_slot_base(hd)
{
    difference()
    {
        slot_end();
        translate([0, -end_slot_size/2-hd/2+out_slot_length])
        cylinder(d=hd, h=thick2, center=true);
        
        yc=out_slot_length-hd/2;
        translate([0,-end_slot_size/2+yc/2-0.1,0])
        cube([sw,yc,thick2 ], center=true);
    }
}

module male_slot_cylinder()
{
    if (male_slot_spring)
    {
        difference()
        {
            cylinder(d=sd, h=thick, center=true);
            cylinder(d=sd/1.5, h=thick2, center=true);
            
            xc=1;
            dx=(sw-2*out_slot_clearance)/2+xc/2;
            translate([dx, sd/4,0])
            cube([xc, sd/2, thick2], center=true);
            translate([-dx, sd/4,0])
            cube([xc, sd/2, thick2], center=true);
        }
    }
    else
        cylinder(d=sd, h=thick, center=true);
}

module male_slot()
{
    out_slot=out_slot_length+out_slot_clearance;
    slot_end();
    translate([0,-end_slot_size/2-out_slot+sd/2,0])
    male_slot_cylinder();
    
    lc=out_slot-sd/6;
    translate([0,-end_slot_size/2-lc/2+0.1,0])
    cube([sw-2*out_slot_clearance ,lc,thick], center=true);
    
}
