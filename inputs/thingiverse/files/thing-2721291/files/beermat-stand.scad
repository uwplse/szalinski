// Bierdeckelhalter
// by Sönke Simon

/* [Hidden] */
$fs=0.1;
$fn=90;

/* [General] */
// Width of the beermat
$mat_width = 95;

// Height of the beermat stack (depth of the standing stack)
$mat_stack_height = 40;

// How high should the beermat be covered 
$mat_height_cover = 50;

// Wall thickness
$thickness = 3;

// Thickness of the feet
$deko_thickness=6;
$deko_width = $mat_stack_height/2.5;

// Angle of the walls
$angle = 7;


$curve_offset = $mat_width / 18 ;

$outerwidth = $mat_width + 2 * $thickness;
$outerheight = $mat_height_cover + $thickness;
$outerlowerdepth = $mat_stack_height+2*$thickness;
$upperoffset = tan($angle)*$outerheight;
$outerupperdepth = $outerlowerdepth + 2*$upperoffset;
render(){
difference () {
    union()
    {
        base($outerlowerdepth,$outerheight,$angle,$outerwidth);
    
    // 4 Füße    
        deko($deko_thickness,$outerheight*2/3,$deko_width);   
        
        translate([$outerwidth-$deko_thickness,0,0]){
            deko($deko_thickness,$outerheight*2/3,$deko_width);   
        }
        
        translate([0,$outerlowerdepth,0]){
            mirror ([0,1,0]){
            deko($deko_thickness,$outerheight*2/3,$deko_width);   
        }}
        
        translate([$outerwidth-$deko_thickness,$outerlowerdepth,0]){
            mirror ([0,1,0]){
            deko($deko_thickness,$outerheight*2/3,$deko_width);   
        }}
        
        // Röhren
        translate([0,$upperoffset*-1,$outerheight-$thickness/3]){
            rotate([0,90,90]){
                cylinder(h=$outerupperdepth ,r=$thickness/2);
            }
        }

        translate([$outerwidth,$upperoffset*-1,$outerheight-$thickness/3]){
            rotate([0,90,90]){
                cylinder(h=$outerupperdepth ,r=$thickness/2);
            }
        }
    
    }
    
    // Innenraum
    translate ([$thickness,$thickness,$thickness])
    {
        base($mat_stack_height,$mat_height_cover+1,$angle,$mat_width);
    }
    
    // Rundungen
    translate([$thickness+$curve_offset,$mat_stack_height*1.5,$thickness]){
        wanne($mat_width-$curve_offset*2,$mat_height_cover,$mat_stack_height*2);
    }

}

}
module base ($depth,$height,$alpha,$width)
{
    rotate ([90,0,90])
    {    
        linear_extrude(height=$width) {
            polygon(
                points=[
                [0,0],
                [-1*tan($alpha)*$height,$height],
                [$depth+tan($alpha)*$height,$height],
                [$depth,0]
                ], paths=[[0,1,2,3]]
            );
        }  
    }
}

module deko ($thickness,$maxh,$maxw)
{
    $smallradius = $maxh/8;
    $bigradius = $maxh*2;
    
    $y1=$smallradius/1.5;
    $z1=0;
    
    $y2=$maxw;
    $z2=$maxh;
    
    $dy = abs($y2-$y1);
    $dz = abs($z2-$z1);
    
    //Höhe ausrechnen
    $hoehe = sqrt(pow($bigradius,2)-pow(norm([$dy,$dz]),2)/4);
    
    // Alpha = Winkel im gleichscheinkligen Dreieck
    $alpha = asin($hoehe/$bigradius);
    
    // Beta = Winkel im rechwinkligen Dreieck
    $beta  = atan($dz/$dy);
    
    //gamma ist der Winkel im rechtwinkligen Dreieck mit y1/z1 und Mittelpunkt
    $gamma = $alpha - $beta;
    
    $yM = $y1+cos($gamma)*$bigradius;
    $zM = $z1-sin($gamma)*$bigradius;
    
    translate([0,$maxw*-1,0]){
    intersection(){
        cube([$thickness,$maxw,$maxh]);
        union(){
            
            translate([0,$yM,$zM]){
                rotate([0,90,0]){
                    cylinder(h=$thickness,r=$bigradius);
                }
            }
            translate([0,$smallradius,$smallradius*2/3]){
                rotate([0,90,0]){
                    cylinder(h=$thickness,r=$smallradius);
                }
            }            
        }
    }}
}    



module wanne ($l,$h,$d)
{
$r=min($h/3,$l/8);
$lowerx=$l/3;

// Mittelpunkte der 4 Kreise
$x1=0;
$y1=$h-$r;

$x2=$lowerx;
$y2=$r;

$x3=$l-$lowerx;
$y3=$r;

$x4=$l;
$y4=$h-$r;

$dx=abs($x2-$x1);
$dy=abs($y2-$y1);


//Abstand der Mittelpunkte
$c = norm([$dx,$dy]);
$alpha = acos(2*$r/$c)-atan($dy/$dx);

$roffsetx = $r*cos($alpha);
$roffsety = $r*sin($alpha);;
rotate([90,0,0]){
linear_extrude(height=$d){
difference (){
    union()
    {
        translate([$x2,$y2]) {circle($r);}
        translate([$x3,$y3]) {circle($r);}
        
        polygon(points=[
        [$x1,$y1+$r+1],
        [$x1,$y1+$r],
        [$x1+$roffsetx,$y1+$roffsety],
        [$x2-$roffsetx,$y2-$roffsety],
        [$lowerx,0],
        [$l-$lowerx,0],
        [$x3+$roffsetx,$y3-$roffsety],
        [$x4-$roffsetx,$y4+$roffsety],
        [$x4,$y4+$r],
        [$x4,$y4+$r+1]
        ]);
    }

    translate([$x4,$y4]) {circle($r);}
    translate([$x1,$y1]) {circle($r);}

}}}
    
}
