//
// Joint d'étanchéité pour bouchon d'évier
// (Gasket for strainer basket)
//
// copyright 2015 Sébastien Roy
//
// Licence: public domain
//


/* [Parameters] */

// Outside diameter (x 1/10 mm)
outsideDiameter=516; // [300:700]

// Inside diameter (x 1/10 mm)
insideDiameter=345; // [200:500]

// Height (x 1/10 mm)
height=60; // [40:80]


//inside=34.5/2;
//outside=51.6/2;
//height=6;
//ep=4;

out=outsideDiameter/20; // radius in mm
in=insideDiameter/20; // radius in mm
h=height/10; // in mm
h1=h*1/3; // height of exterior point from base
h2=h-h1; // height of exterior point from top

echo(h,h1,h2);
echo(in,out);

//             +--+                 --- ---
//             |   ---               h2  |   
//             |      ---            |   |
//             |         +          ---  h
//             |        /            h1  |
//             |       /             |   |
//             +------+             --- ---
//   |... in ..|
//   |... out ............|
//   |... out-h1 .....|
//   |... out-h2 ..|

rotate_extrude($fn=128) {
    polygon([[in,0],[out-h1,0],[out,h1],[out-h2,h],[in,h]]);
}

