/* [Global] */
//longuerur de la vis
longueur_vis = 10;
longueur_text = "longueur du filetage / thread lenght";
//diametre du filetage
diametre_filetage = 5;
diametre_text = "diametre du filetage / thread diameter";

largeur_rondelle = 3;
epaisseur_rondelle = 2;

/* [Hidden] */
defQ = 32;

module hex_nut(dia)
{
	$fn = get_sh_qual(dia);
	thr = get_thr_qual(dia);
	hi = hex_nut_hi(dia);
	difference()
	{
		cylinder(r = hex_nut_dia(dia)/2,h = hi, $fn=30);
		translate([0,0,-0.1])	cylinder(r = dia/2, h =hi + 0.2);
	}
	translate([0,0,0.1])	thread_in(dia,hi-0.1,thr);
}

module thread_in(dia,hi,thr=defQ)
{
	p = get_coarse_pitch(dia);
	h = (cos(30)*p)/8;
	Rmin = (dia/2) - (5*h);	// as wiki Dmin
	s = 360/thr;
	t = (hi-p)/p;			// number of turns
	n = t*thr;				// number of segments
	//echo(str("dia=",dia," hi=",hi," p=",p," h=",h," Rmin=",Rmin," s=",s));
	difference()
	{
		cylinder(r = (dia/2)+0.5,h = hi);
		translate([0,0,-1]) cylinder(r = (dia/2)+0.1, h = hi+2);
	}
	for(sg=[0:n])
		th_in_pt(Rmin+0.2,p,s,sg,thr,h,(hi-p)/n);
}
module th_in_pt(rt,p,s,sg,thr,h,sh)
// rt = radius of thread (nearest centre)
// p = pitch
// s = segment length (degrees)
// sg = segment number
// thr = segments in circumference
// h = ISO h of thread / 8
// sh = segment height (z)
{
//	as = 360 - (((sg % thr) * s) - 180);	// angle to start of seg
//	ae = as - s + (s/100);		// angle to end of seg (with overlap)
	as = ((sg % thr) * s - 180);	// angle to start of seg
	ae = as + s -(s/100);		// angle to end of seg (with overlap)
	z = sh*sg;

	cas=cos(as);
	sas=sin(as);
	cae=cos(ae);
	sae=sin(ae);
	rtp=rt+(5*h);

	casrt=cas*rt;
	casrtp=cas*rtp;
	sasrt=sas*rt;
	sasrtp=sas*rtp;
	caert=cae*rt;
	caertp=cae*rtp;
	saert=sae*rt;
	saertp=sae*rtp;

	//         2,5
	//          /|
	//  1,4 /  | 
 	//        \  |
	//          \|
	//         0,3
	//  view from front (x & z) extruded in y by sg
	//  
	polyhedron(
		points = [
			[casrtp,sasrtp,z],				//0
			[casrt,sasrt,z+(3/8*p)],			//1
			[casrtp,sasrtp,z+(3/4*p)],		//2
			[caertp,saertp,z+sh],			//3
			[caert,saert,z+(3/8*p)+sh],		//4
			[caertp,saertp,z+(3/4*p)+sh]],	//5
		triangles = [
			[0,1,2],			// near face
			[3,5,4],			// far face
			[0,3,4],[0,4,1],	// left face
			[0,5,3],[0,2,5],	// bottom face
			[1,4,5],[1,5,2]]);	// top face
}


// function for thread pitch
function get_coarse_pitch(dia) = lookup(dia, [
[1,0.25],[1.2,0.25],[1.4,0.3],[1.6,0.35],[1.8,0.35],[2,0.4],[2.5,0.45],[3,0.5],[3.5,0.6],[4,0.7],[5,0.8],[6,1],[7,1],[8,1.25],[10,1.5],[12,1.75],[14,2],[16,2],[18,2.5],[20,2.5],[22,2.5],[24,3],[27,3],[30,3.5],[33,3.5],[36,4],[39,4],[42,4.5],[45,4.5],[48,5],[52,5],[56,5.5],[60,5.5],[64,6],[78,5]]);
// function for shaft quality
function get_sh_qual(dia) = lookup(dia, [
[5,10],[6,12],[7,14],[8,16],[10,20],[12,24],[14,28],[16,32],[18,36],[20,40],[22,44],[24,48],[27,54],[30,60],[33,66],[36,72],[39,78],[42,84],[45,90],[48,96],[52,104],[56,112],[60,120],[64,128],[78,156]]);
function get_thr_qual(dia) = lookup(dia, [
[5,10],[6,12],[7,14],[8,16],[10,20],[12,12],[14,28],[16,32],[18,36],[20,40],[22,44],[24,48],[27,54],[30,60],[33,66],[36,72],[39,78],[42,84],[45,90],[48,96],[52,104],[56,112],[60,120],[64,128],[78,156]]);
// function for hex nut diameter from thread size
function hex_nut_dia(dia) = lookup(dia, [
[3,6.4],[4,8.1],[5,9.2],[6,11.5],[8,16.0],[10,19.6],[12,22.1],[16,27.7],[20,34.6],[24,41.6],[30,53.1],[36,63.5]]);
// function for hex nut height from thread size
function hex_nut_hi(dia) = lookup(dia, [
[3,2.4],[4,3.2],[5,4],[6,3],[8,5],[10,5],[12,10],[16,13],[20,16],[24,19],[30,24],[36,29]]);

module hex_bolt(dia,hi)
{
	$fn = get_sh_qual(dia);
	thr = get_thr_qual(dia);
	hhi = hex_bolt_hi(dia);
	//cylinder(r = hex_bolt_dia(dia)/2,h = hhi, $fn=6);
        difference()
    {
        cylinder(r1=3.5,r2=4,4,$fn=30);
        translate([0,0,-0.1])
        {
            cylinder(r=2.6,3,$fn=30);
        }
    }

	translate([0,0,hhi-0.1])	thread_out(dia,hi+0.1,thr);
}
// function for hex bolt head diameter from thread size
function hex_bolt_dia(dia) = lookup(dia, [
[3,6.4],[4,8.1],[5,9.2],[6,11.5],[8,14.0],[10,16],[12,22.1],[16,27.7],[20,34.6],[24,41.6],[30,53.1],[36,63.5]]);
// function for hex bolt head height from thread size
function hex_bolt_hi(dia) = lookup(dia, [
[3,2.4],[4,3.2],[5,4],[6,3.5],[8,4.5],[10,5],[12,10],[16,13],[20,16],[24,19],[30,24],[36,29]]);

module thread_out(dia,hi,thr=defQ)
{
	p = get_coarse_pitch(dia);
	h = (cos(30)*p)/8;
	Rmin = (dia/2) - (5*h);	// as wiki Dmin
	s = 360/thr;
	t = (hi-p)/p;			// number of turns
	n = t*thr;				// number of segments
	//echo(str("dia=",dia," hi=",hi," p=",p," h=",h," Rmin=",Rmin," s=",s));
	cylinder(r = Rmin, h = hi);
	for(sg=[0:n])
		th_out_pt(Rmin-0.1,p,s,sg,thr,h,(hi-p)/n);
}

module th_out_pt(rt,p,s,sg,thr,h,sh)
// rt = radius of thread (nearest centre)
// p = pitch
// s = segment length (degrees)
// sg = segment number
// thr = segments in circumference
// h = ISO h of thread / 8
// sh = segment height (z)
{
	as = (sg % thr) * s;			// angle to start of seg
	ae = as + s  - (s/100);		// angle to end of seg (with overlap)
	z = sh*sg;

	cas=cos(as);
	sas=sin(as);
	cae=cos(ae);
	sae=sin(ae);
	rtp=rt+(5*h);

	casrt=cas*rt;
	sasrt=sas*rt;
	caert=cae*rt;
	saert=sae*rt;

	//   1,4
	//   |\
	//   |  \  2,5
 	//   |  / 
	//   |/
	//   0,3
	//  view from front (x & z) extruded in y by sg
	//  
	//echo(str("as=",as,", ae=",ae," z=",z));
	polyhedron(
		points = [
			[casrt,sasrt,z],					// 0
			[casrt,sasrt,z+(3/4*p)],			// 1
			[cas*rtp,sas*rtp,z+(3/8*p)],		// 2
			[caert,saert,z+sh],				// 3
			[caert,saert,z+(3/4*p)+sh],		// 4
			[cae*rtp,sae*rtp,z+sh+(3/8*p)]],	// 5
		triangles = [
			[0,1,2],			// near face
			[3,5,4],			// far face
			[0,3,4],[0,4,1],	// left face
			[0,5,3],[0,2,5],	// bottom face
			[1,4,5],[1,5,2]]);	// top face
}



module milieu()
{
    // Milieu
    translate([1.8,1.8,-2])
    {
        cube([1.2,1.2,3.5]);
    }
    translate([0,2.4,-2])
    {
        cube([2,0.6,3.5]);
    }
    translate([2.4,0,-2])
    {
        cube([0.6,2,3.5]);
    }
    rotate([0,0,180])
    {
        translate([1.8,1.8,-2])
        {
            cube([1.2,1.2,3.5]);
        }
        translate([0,2.4,-2])
        {
            cube([2,0.6,3.5]);
        }
        translate([2.4,0,-2])
        {
            cube([0.6,2,3.5]);
        }
    }

    translate([0,0,-1.8])
    {
        difference()
        {
            translate([0,0,-0.7])
            {
                hex_nut(diametre_filetage);
            }
            translate([0,0,-1])
            {
                difference()
                {
                    cylinder(d=10,5,$fn=30);
                    translate([0,0,0.5])
                    {
                        cylinder(d=6,6,$fn=30);
                    }
                }
            }
        }
    }
}
module demi_fond()
{
    difference()
    {
        translate([-3,1,5])
        {
            sphere(d=22,$fn=40);
        }
        translate([-0,-0,0])
        {
            cube([10,10,10]);
        }
        translate([-15,-15,0])
        {
            cube([30,30,30]);
        }
        translate([-20,-10,-10.8])
        {
            cube([20,20,20]);
        }
        translate([-0.1,3,-5.8])
        {
            cube([8,8,8]);
        }
        translate([-0.1,-33,-20.8])
        {
            cube([30,30,30]);
        }
        translate([-5,-5,-13.8])
        {
            cube([10,10,10]);
        }
        translate([0,0,-5])
        {
            cylinder(d=6.0,10,$fn=30);
        }
        translate([-0.2,-0.1,2.1])
        {
            difference()
            {
                sphere(8,$fn=60);
                sphere(6.8,$fn=60);
            }
        }
    translate([-3,1,0])
    {
        difference()
        {
            sphere(10,$fn=50);
            sphere(8.5,$fn=50);
        }
    }
    }
}

module t_nut()
{
    translate([0,0,3.5])
    {
        milieu();
        demi_fond();
        rotate([0,0,180])
        {
            demi_fond();
        }
    }
}

module vis()
{
    hex_bolt(diametre_filetage,longueur_vis);
}

module rondelle()
{
    difference()
    {
        cylinder(d=diametre_filetage+1+largeur_rondelle,epaisseur_rondelle,$fn=30);
        translate([0,0,-0.5])
        {
            cylinder(d=diametre_filetage+1,epaisseur_rondelle+1,$fn=30);
        }
    }
}

translate([0,8,0])
{
    vis();
}

t_nut();
    
translate([0,-9,0])
{
    rondelle();
}
