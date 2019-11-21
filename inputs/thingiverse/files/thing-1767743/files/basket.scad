basket_width=75;
basket_depth=60;
basket_height=80;
basket_scale=1.25;
basket_projection_scale=0.25;
basket_round_radius=5;

basket_brim_width=2;
basket_brim_height=2;

wallwidth=1.8;

clip_stem_depth=7.1;
clip_stem_height=11;
clip_stem_width=3;
clip_lock_depth=2;
clip_lock_scale=0.8;
clip_lock_width=5.4;
clip_overhang=(clip_lock_width-clip_stem_width)/2;
clip_height=clip_stem_height + clip_overhang*2;
clip_depth=clip_stem_depth + clip_lock_depth;
clip_width=clip_lock_width;

clip_z=48.7;
clip_x=0;
clips_wide=1;
clips_high=1;
clips_x_spacing=88;
clips_z_spacing=62.5;


basket_full_depth=basket_depth+2*basket_round_radius;
basket_full_width=basket_width+2*basket_round_radius;

drainage=false;
base_holes=[
    [0, 0.3, 10],
    [-0.5, -0.5, 8],
    [-0.5, 1, 8],
    [0.5, -0.5, 8],
    [0.5, 1, 8]
];

module rotate_axis(axis, d) {
    rotate(list_for_axis(axis, d)) children();
}

module xrotate(d) {
    rotate_axis("x", d) children();
}

module yrotate(d) {
    rotate_axis("y", d) children();
}

module zrotate(d) {
    rotate_axis("z", d) children();
}

function list_for_axis(axis, d) =
(
    axis=="x" ? [d, 0, 0] : (
        axis=="y" ? [0, d, 0] : (
            axis=="z" ? [0, 0, d] : [0, 0, 0]))
);

module translate_axis(axis, d) {
    translate(list_for_axis(axis, d)) children();
}

module xmove(d) {
    translate_axis("x", d) children();
}

module ymove(d) {
    translate_axis("y", d) children();
}

module zmove(d) {
    translate_axis("z", d) children();
}

module spread_axis(axis, d, n=1) {
    x = d/2;
    if(d==0 || n==0) {
        children();
    }
    else
    {
        for(i=[-x:(d/n):x]) {
            translate_axis(axis, i) children();
        }
    } 
}

module xspread(d, n=1)
{
    spread_axis("x", d, n) children();
}

module yspread(d, n=1)
{
    spread_axis("y", d, n) children();
}


module zspread(d, n=1)
{
    spread_axis("z", d, n) children();
}

module keyhole() {
    xmove(-3.5/2) square([3.5, 9]);
    xmove(-3) ymove(9) square([6, 15]);
}


                
// size: [clip_width, clip_depth]
module clip() {
    ymove(-clip_lock_depth/2) {
        cube(size=[clip_stem_width, clip_stem_depth, clip_stem_height], center=true);
        ymove(clip_stem_depth/2) xrotate(90) mirror([0,0,1]) linear_extrude(clip_lock_depth, scale=clip_lock_scale) offset(clip_overhang) square(size=[clip_stem_width, clip_stem_height], center=true);
    }
}

module basket_shape() {
    union() {
        offset(basket_round_radius) square(size=[basket_width, basket_depth], center=true);
        
        ymove(basket_depth/2+basket_round_radius/2) square(size=[basket_full_width, basket_round_radius], center=true);
        difference() {
            ymove(basket_depth/2+basket_round_radius) scale([1, basket_projection_scale, 1]) circle(basket_full_width/2, center=true, $fn=120);
            ymove(-basket_width/2-basket_round_radius) square(size=[basket_width+basket_round_radius*2, basket_width+basket_round_radius*2], center=true);
      }
    }
}

module basket_base() {
    difference()
    {
        linear_extrude(wallwidth) basket_shape();
        if(drainage) zmove(-0.1) {
            for(hole=base_holes)
            {
                xmove(hole[0]*basket_full_width/2)
                ymove(hole[1]*basket_full_depth/2) cylinder(h=wallwidth+0.2, d=hole[2]);
            }
        }
    }
}


module basket_outline() {
    difference()
    {
        basket_shape();
        offset(-wallwidth) basket_shape();
    }
}

module basket_brim() {
    difference()
    {
        scale([basket_scale, basket_scale, 1]) linear_extrude(basket_brim_height) offset(basket_brim_width/2) basket_shape();
        scale([basket_scale, basket_scale, 1]) zmove(-0.1) linear_extrude(basket_brim_height+0.2) offset(-0.1) basket_shape();
    }
}

module basket() {
    xspread(clips_x_spacing, n=clips_wide-1) zspread(clips_z_spacing, n=clips_high-1) zmove(clip_z) ymove(-clip_depth/2) zrotate(180) clip();
    linear_extrude(basket_height, scale=basket_scale) ymove(basket_full_depth/2) basket_outline();
    ymove(basket_full_depth/2) basket_base();
    zmove(basket_height-basket_brim_height) ymove(basket_full_depth*basket_scale/2) basket_brim();
}
basket();