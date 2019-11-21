/* [Slot Parameters] */
// cable cutout width
ccw=6.5; // [3:0.5:20]

// cable cutout height
cch=3.5; // [1:0.5:10]

// length of extrusion
extrudeLen=6; // [3:25]

// wall thickness
wall=1.5; // [1:0.5:6]

// slot opening width
sow=2.5; // [1:0.5:10]

/* [Replication] */
// number of slots in each part
slotCount=3; // [1:10]

// number of parts to create
copies=3; // [1:20]

// space between (if multiple parts)
gap=2; // [1:20]

/* [Hidden] */
off = (ccw/2) - (cch/2); // offset (from CL) for conductor centers
tw=ccw+(2*wall); // total width
th=cch+(2*wall); // total height
slotOrg=0; // used to position each slot
$fn=30; // make circles somewhat smooth
centerXOff=(((tw+gap)*(copies-1))/2); // center copies on x axis
centerYOff=(((cch+wall)*slotCount)+wall)/2; // center part on Y axis

for(offset = [0:copies-1]) // loop to create multiple parts
{
    xoff = offset*(tw + gap) - centerXOff;
    linear_extrude(height = extrudeLen) // extrude part(s)
    {
        for(slot = [0:slotCount-1])  // duplicate slot for each cable slot
        {
            slotOrg = (cch+wall)*slot;
            translate([xoff,slotOrg-centerYOff,0]) // move orgin for each part
            {
                translate([0,th/2,0]) // move orgin for each slot
                difference()
                {
                    square([tw, th], center=true); // outside
                    hull() // hole for cable
                    {
                        translate([off,0,0]) circle(d=cch);
                        translate([-off,0,0]) circle(d=cch);
                    }
                    translate([0,-(sow)/2,0]) square([(tw/2+1),sow]); // edge cutout
                }
            }
        }
    }
}