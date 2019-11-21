$fn=90;

//Anzeige
$show_inv = 0;
$show_key = 1;
$show_example = 0;


//Parameter für den Schaft
$hoehe=90;
$hoehe_top=10;
$r_schaft=8.5;
$fluegel_dicke=6;
$fluegel_hoehe=10;
$fluegel_breite=60;


if ($show_inv==1 ){    
    translate([40,40,0])
    inverse(5.9,1.5);
}

if ($show_key==1 ){    
    key(5.5,1.2);
}

if ($show_example==1 ){
    example(5.5,1.2);
}




module example($r, $r2){    
    
    $hExample=10;
    translate([40,20,0])
    union(){
        cylinder(r=$r+2,h=$hExample/3);
        linear_extrude(height=$hExample)
        top($r, $r2);
    }
}

module key($r, $r2){    
    
    //union(){
        cylinder(r=$r_schaft,h=$hoehe-$hoehe_top-$r_schaft/2);
        translate([0,0,$hoehe-$hoehe_top-$r_schaft/2])
        sphere(r=$r_schaft);
        translate([0,0,$hoehe-$hoehe_top])
        linear_extrude(height=$hoehe_top)
        top($r, $r2);
        translate([-($fluegel_breite/12)*5,$fluegel_dicke/2,0])
        rotate([90,0,0])
        difference(){
            
            minkowski(){
                cube([($fluegel_breite/6)*5,$fluegel_hoehe,$fluegel_dicke]);
                cylinder(r=$fluegel_breite/6,h=.001);
            }
            translate([-$fluegel_breite/2,-$fluegel_hoehe,-$fluegel_dicke/2])
            cube([2*$fluegel_breite,$fluegel_hoehe,2*$fluegel_dicke]);
        }
    //}

}


module inverse($r, $r2){
    difference(){
        cylinder(r=$r+2,h=8);
        translate([0,0,3])
        linear_extrude(height=10)
        top($r, $r2);
    }
}

module squirt($ix,$iy,$angel=72){    
    translate([$ix,$iy,0])
    circle(r=$r2);    
    
    rotate([0,0,$angel])
    translate([0,-$r2,0])
    square([$r,2*$r2]);
}

module top($r1,r2){
    
    $b=sin(72) * ($r / sin(54));
    $x=sin(54) * ($b/sin(90));
    $y=sqrt(pow($b,2)-pow($x,2));
    $z=sqrt(pow($r,2)-pow(($b/2),2)); 
    
    union(){
        circle(r=$r, $fn=5);
        squirt($r,0,0);
        squirt($r-$y,-$x,-72);
        squirt(-$z,-$b/2,-144);
        squirt(-$z,$b/2,144);
        squirt($r-$y,$x,72);
    }
}

