inch=25.4;
gold=1.61803398875;

build_stl=0;
gold_overrides=1;
inch_overrides=1;
shell_mm_overrides=1;
shell_fdm_overrides=1;
match_base_override=1;

halve_override=0;

stl_fineness=210;
low_fineness=15;

nozzle_size=0.4;
layer_height=0.30625;

hole_stl_fineness=90;
hole_low_fineness=6;

holes=3;

taper_pc=0.75;

width_mm=40;
height_mm=40;
cup_height_mm=20;
cup_width_mm=20;
hole_size_mm=8;
wall_thickness_mm=1.6;
floor_thickness_mm=1.53125;

width_inches=1.75;
height_inches=2.75;
cup_height_inches=0.375;
cup_width_inches=0.5;
hole_size_inches=0.25;
wall_thickness_inches=0.0625;
floor_thickness_inches=0.0625;

wall_thickness_multiple=4;
floor_thickness_multiple=5;

wall_thickness=shell_fdm_overrides?wall_thickness_multiple*nozzle_size:inch_overrides&&!shell_mm_overrides?wall_thickness_inches*inch:wall_thickness_mm;

floor_thickness=shell_fdm_overrides?floor_thickness_multiple*layer_height:inch_overrides&&!shell_mm_overrides?floor_thickness_inches*inch:floor_thickness_mm;

//cup_volume=1.5*15;

width=inch_overrides?width_inches*inch:width_mm;

height=gold_overrides?1/gold*width:inch_overrides?height_inches*inch:height_mm;


taper=gold_overrides?1/gold:taper_pc;

cup_height=gold_overrides?pow(1/gold,4)*width:inch_overrides?cup_height_inches*inch:cup_height_mm;

cup_width=match_base_override?(width-(cup_height/height)*(width-taper*width))-taper*width:gold_overrides?pow(1/gold,3)*width:inch_overrides?cup_width_inches*inch:cup_width_mm;

hole_size=gold_overrides?1/gold*cup_height-floor_thickness:inch_overrides?hole_size_inches*inch:hole_size_mm;



fineness=build_stl?stl_fineness:low_fineness;
hole_fineness=build_stl?hole_stl_fineness:hole_low_fineness;

hole_fineness_offset=(1+floor_thickness/height)*taper*width/2-cos(180/fineness)*(1+floor_thickness/height)*taper*width/2;


hole_offset=sin(asin( (hole_size/2) / ( (taper*width)/2 + ((floor_thickness/height)*taper*width)/2)));


hole_edge=((1+floor_thickness/height)*taper*width-wall_thickness*2)/2-hole_offset*(1+floor_thickness/height)*taper*width/2-hole_fineness_offset;

hole_depth=taper*width/2+hole_offset+((hole_size/2+floor_thickness)/height)*taper*width/2-hole_edge+hole_offset+0.002;


module terracotta_pot(){
    difference(){
        
        cylinder(height,taper*width/2,width/2,$fn=fineness);
        
        translate([0,0,floor_thickness])
        cylinder(height+0.001-floor_thickness,taper*width/2+(floor_thickness/height)*(width-taper*width)/2-wall_thickness,width/2-wall_thickness,$fn=fineness);
        
        for (i=[1:holes]){
            rotate([0,0,360*(i/holes)])
            scale([1,1/gold,1])
            translate([hole_edge-0.001,0,floor_thickness])
            rotate([0,90,0])
            cylinder(hole_depth+0.002,hole_size,hole_size,$fn=hole_fineness);
        }

        if (halve_override){
            translate([0,-width/2-(1+cup_height/height)*taper*width/2,-0.001])
            cube([cup_width/2+width/2+wall_thickness+(1+cup_height/height)*taper*width/2,cup_width+width+(1+cup_height/height)*taper*width+wall_thickness*2,height+0.002]);
        }
    }

    difference(){
        cylinder(cup_height,taper*width/2+cup_width/2,taper*width/2+(cup_height/height)*(1-taper)*width/2+cup_width/2,$fn=fineness);
        
        translate([0,0,floor_thickness])
        cylinder(cup_height+0.001-floor_thickness,taper*width/2+(floor_thickness/height)*(1-taper)*width/2+cup_width/2-wall_thickness,taper*width/2+(cup_height/height)*(width*(1-taper)/2)+cup_width/2-wall_thickness,$fn=fineness);
        
        if (halve_override){
            translate([0,-width/2-(1+cup_height/height)*taper*width/2,-0.001])
            cube([cup_width/2+width/2+wall_thickness+(1+cup_height/height)*taper*width/2,cup_width+width+(1+cup_height/height)*taper*width+wall_thickness*2,height+0.002]);
        }
    }

}

//translate([0,0,-height-0.01])
terracotta_pot();