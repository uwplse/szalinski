
$angle=45;
$height=40;
$Donnotmesswithhalfheight=$height/2;
translate([0,0,$height])union(){
    sphere(r=10);
    union(){
        union(){
            rotate([0,$angle,0])       cube([5,$height,10],         center=true);
            rotate([0,$angle,180])    cube([5,$height,10],         center=true);
}
        rotate([0,0,90])union(){
            rotate([0,$angle,0])       cube([5,$height,10],         center=true);
            rotate([0,$angle,180])    cube([5,$height,10],         center=true);
    }
}
}
translate([0,0,$Donnotmesswithhalfheight])union(){
    sphere(r=10);
    cylinder(r=5, $Donnotmesswithhalfheight);
    union(){
        union(){
            rotate([0,$angle,0])       cube([5,$height,10],         center=true);
            rotate([0,$angle,180])    cube([5,$height,10],         center=true);
}
        rotate([0,0,90])union(){
            rotate([0,$angle,0])       cube([5,$height,10],         center=true);
            rotate([0,$angle,180])    cube([5,$height,10],         center=true);
    }
}
}
union(){
    sphere(r=10);
    cylinder(r=5, h=$height);
    union(){
        union(){
            rotate([0,$angle,0])       cube([5,$height,10],         center=true);
            rotate([0,$angle,180])    cube([5,$height,10],         center=true);
}
        rotate([0,0,90])union(){
            rotate([0,$angle,0])       cube([5,$height,10],         center=true);
            rotate([0,$angle,180])    cube([5,$height,10],         center=true);
    }
}
}