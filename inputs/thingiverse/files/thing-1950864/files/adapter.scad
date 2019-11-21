// Bottom segment bottom inner diameter
bbi = 39.5; // [1:0.5:100]

// Bottom segment bottom outer diameter
bbo = 42.5; // [1:0.5:100]

// Bottom segment top inner diameter
bti = 38; // [1:0.5:100]

// Bottom segment top outer diameter
bto = 43; // [1:0.5:100]

// Bottom segment height
bh = 40; // [1:0.5:100]

// Junction height
jh = 10; // [1:0.5:100]

// Top segment bottom inner diameter
tbi = 28; // [1:0.5:100]

// Top segment bottom outer diameter
tbo = 33; // [1:0.5:100]

// Top segment top inner diameter
tti = 29; // [1:0.5:100]

// Top segment top outer diameter
tto = 31; // [1:0.5:100]

// Top segment height
th = 40; // [1:0.5:100]

//descr = [
//    [39.5, 42.5, 0], // internal
//    [38, 43, 40], // internal
//    [28, 33, 10], // external
//    [29, 31, 40], // external
//];

descr = [
    [bbi, bbo, 0],
    [bti, bto, bh],
    [tbi, tbo, jh],
    [tti, tto, th]
];

$fn = 100;

//use <pipe.scad>
//-------------------------------------------------------------------------------
// descr is a vector of vectors [inner_d, outer_d, height]
module pipe(descr, $fn=$fn) {
    function combine_descr(descr, i) =
        i == 0
            ? [[[descr[0][0], descr[0][2]]], [[descr[0][1], descr[0][2]]]]
            : let(p=combine_descr(descr, i-1), h=p[0][i-1][1]+descr[i][2])
                [concat(p[0], [[descr[i][0], h]]), concat(p[1], [[descr[i][1], h]])];
                
    function create_shape(descr) =
        let(c=combine_descr(descr, len(descr) - 1))
            concat(c[0], [for (i = [len(c[1])-1:-1:0]) c[1][i]]);
                
    rotate_extrude($fn=$fn)
        scale([0.5, 1]) // diameter -> radius
            polygon(create_shape(descr));
}
//-------------------------------------------------------------------------------

// print_part
pipe(descr);
