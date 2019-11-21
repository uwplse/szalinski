// Tool Handle Diameter (in mm); max size is about 24 mm if doing multiple connected
tool_dia = 24;
// Thickness of the tool holder
shell_width = 2;
// Height of your tool holder (10mm is a good guess)
holder_height = 10;
// Peg Hole Size (6.5 is good for US)
peg_size = 6.5;
// Peg Length is the thickness of your peg board
peg_length = 2;
// Peg Spacing, US=25.4; Metric=25??
peg_spacing = 25.4;
// Number of holders
number_of_holders = 1;
// Arrangement, grid, inline, inline_connected
arrangement = "inline"; //[grid, inline]
// Grid rows, duplicates number_of_holders on multiple "rows"
grid_rows = 1;
// Front Cutout Percent; if you want an opening in the front, this is about how much of the ring to cut out.  .25 = 25% is a good start
front_cutout_percent = .15;
// Connected [yes,no] Adds a support brace across each row
connected = "yes"; // [yes,no]

/* [Hidden] */
outer_dia = tool_dia + (shell_width);
$fn=32;


// Loop
if(arrangement=="inline")
    for(n=[0:1:number_of_holders-1])
        translate([n*peg_spacing,0,5]) tool_holder(n);

if(arrangement=="grid")
    for(gr=[0:1:grid_rows-1])
        for(n=[0:1:number_of_holders-1])
            translate([n*peg_spacing,
                      gr*(outer_dia),
                      0]) tool_holder(n);

// Modules
module supports() {
}    

module connector(cn) {
    translate([cn>0?0:cn==0?-peg_spacing/4:peg_spacing/4,
                -outer_dia/2
                ,0]) 
            rotate([0,-90,-90]) 
                cube([holder_height,
                    cn>0?(peg_spacing)
                         :(peg_spacing/2),
                    shell_width*.75],center=true);
}
// tool shell
module tool_holder(hn) {
    rotate([0,-180,0]) union() {
        difference() {
            //outer shell
            cylinder(r1=(outer_dia/2)+(shell_width/2),
                     r2=(outer_dia/2),
                     h=holder_height,center=true);
            //inner cutout
            color("red") cylinder(r1=(outer_dia-(shell_width/2))/2,
                     r2=(tool_dia/2),
                     h=4+holder_height,center=true);
        // opening cutout
            if(front_cutout_percent!=0) translate([0,outer_dia*(1-front_cutout_percent),0]) color("pink") cube([outer_dia,outer_dia,holder_height],center=true);
        }
        // peg body
            union() {
                // peg leg
                color("green") translate([0,-((outer_dia/2)),0]) rotate([90,0,0]) cylinder(r=(peg_size-1)/2,h=peg_length);
                // peg head
                translate([0,-((peg_size/2)+(outer_dia/2)+(peg_length-(shell_width/2))),0]) peg_head();
     if(connected=="yes" && number_of_holders>1)
                if(hn==0)
                    color("red") connector(0); // start
                else if(hn==number_of_holders-1) 
                    color("blue") connector(-1); // end
                else connector(hn); // middle
            }
    }
}
module peg_head() {
    difference() {    
     // peg head
        sphere(r=peg_size/2);
        // peg slot clipping rectangle
        translate([0,-(peg_size/4),0]) rotate([0,0,-90]) cube([peg_size,peg_size/4,peg_size],center=true);
        // peg clipping side rectangles
        translate([-peg_size/1.75,0,0]) rotate([0,0,-90]) cube([peg_size/2,peg_size/4,peg_size],center=true);
        translate([peg_size/1.75,0,0]) rotate([0,0,-90]) cube([peg_size/2,peg_size/4,peg_size],center=true);   
} 
}