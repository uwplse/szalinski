
// Width of clip
extrude=6; // [3:25]

/* [Ring inside diameters] */
// Top
top_clip_inner=3; // [1:0.1:10]
// Middle
mid_clip_inner=6; // [1:25]
// Bottom
bot_clip_inner=14; // [1:50]

/* [Bottom Opening] */
// Size
opening_scale=0.75; // [0.4:0.05:1]
// Rotation
tilt=-15; //[-30:5:210]

/* [Wall Thickness] */
// Top ring
top_thickness=1.6; // [1:0.1:3]
// Middle ring
mid_thickness=1.6; // [1:0.1:3]
// Bottom ring
bot_thickness=1.6; // [1:0.1:5]


/* [Hidden] */
$fn=120; // control circle smoothness
top_outer=top_clip_inner + 2*top_thickness;
mid_outer=mid_clip_inner + 2*mid_thickness;
bot_outer=bot_clip_inner + 2*bot_thickness;
lip_out=bot_clip_inner*opening_scale; // opening size (relative to inner ring diameter)

translate([-(bot_outer+mid_outer)/2,0,0]) // center part on x-axis
linear_extrude(height=extrude) {
    
    // Top clip
    translate([-((top_outer/2)-top_thickness),0,0])
    difference()
    {
        circle(d=top_outer);
        circle(d=top_clip_inner); // wire diameter
        square(size=top_outer/2, center=false); // opening
    }
    
    // middle clip (spacer to allow easier access to bottom clip)
    translate([mid_outer/2,0,0])
    difference()
    {
        circle(d=mid_outer);
        circle(d=mid_clip_inner);
    } 
    
    // Bottom clip
    translate([mid_outer+(bot_outer/2)-mid_thickness,0,0]) rotate(tilt)
    difference()
    {
        union () {
            circle(d=bot_outer);
            translate([0,-lip_out/2,0]) square([lip_out,lip_out], center=true);
        }
        circle(d=bot_clip_inner);
        translate([0,-lip_out/2,0]) square([lip_out-(2*bot_thickness),lip_out], center=true);
    }
    
}