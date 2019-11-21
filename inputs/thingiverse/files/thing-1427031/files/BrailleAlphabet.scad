// ==================================================
// Braille Alphabet - Customizer
// Created by Daiju Watanbe ( Daizyu ).
// 19 March 2016. 
// ==================================================

// preview[view:south, tilt:top]

/* [Text information] */
// https://www.branah.com/braille-translator
my_text="⠃⠗⠁⠊⠇⠇⠑";

/* [Character] */
dot_diameter = 1.2;
dot_Height = 0.2;

/* [Character gap] */
dot_gap_X = 2.3;
dot_gap_Y = 2.5;

/* [ Between characters ] */
between_characters_X=6.2;
between_characters_Y=8;

/* [Board] */
board_type = 2;  // [1:Noamal,2:ConnectorLeft,3:ConnectorRight,4:ConneorBoth] 
board_thickness=2;
board_corner_R=4;
connector_offset=4;
connector_diameter=3;
corner_detail=30;   //  [1:30]

/* [Hidden] */
$fn=10;


boardBaseX = between_characters_X*(len(my_text)-1)+dot_gap_X;

module dot(dot_diameter,dot_Height)
{
    scale([dot_diameter/2,dot_diameter/2,dot_Height])rotate_extrude($fn=20)polygon([[0,0],[0,1],[0.277,1],[0.421,0.958],[0.518,0.926],[0.612,0.883],[0.727,0.789],[0.831,0.663],[0.893,0.505],[0.925,0.137],[0.950,0.058],[1,0]]);
}

module putBraille(x,y,brailleNo)
{
    minerDotX=[0,0,0,1];
    minerDotY=[0,1,2,0];
    magerDotX=[1,1,0,1];
    magerDotY=[1,2,3,3];
    
    dic2=[[0,0,0,0],[1,0,0,0],[0,1,0,0],[1,1,0,0],[0,0,1,0],[1,0,1,0],[0,1,1,0],[1,1,1,0],[0,0,0,1],[1,0,0,1],[0,1,0,1],[1,1,0,1],[0,0,1,1],[1,0,1,1],[0,1,1,1],[1,1,1,1]];
    mager = floor(brailleNo/16);
    miner = brailleNo - mager*16;
    
    for (dotIdx=[0:3]){
        if ( dic2[miner][dotIdx] == 1 ){
            translate([x + minerDotX[dotIdx]*dot_gap_X ,y-minerDotY[dotIdx]*dot_gap_Y,0])dot(dot_diameter,dot_Height);
        }
        if ( dic2[mager][dotIdx] == 1 ){
            translate([x + magerDotX[dotIdx]*dot_gap_X,y-magerDotY[dotIdx]*dot_gap_Y,0])dot(dot_diameter,dot_Height);
        }
    }     
}

//http://web.econ.keio.ac.jp/staff/nakanoy/article/braille/BR/chap3/3-2/3-2.html
//http://www.tokiwa-sp.com/brailleprint.html
//http://astamuse.com/ja/published/JP/No/2003002354
//http://sgry.jp/articles/brailletest.ja.html
module BrailleAlphabet(){
    dic = "\u2800\u2801\u2802\u2803\u2804\u2805\u2806\u2807\u2808\u2809\u280a\u280b\u280c\u280d\u280e\u280f\u2810\u2811\u2812\u2813\u2814\u2815\u2816\u2817\u2818\u2819\u281a\u281b\u281c\u281d\u281e\u281f\u2820\u2821\u2822\u2823\u2824\u2825\u2826\u2827\u2828\u2829\u282a\u282b\u282c\u282d\u282e\u282f\u2830\u2831\u2832\u2833\u2834\u2835\u2836\u2837\u2838\u2839\u283a\u283b\u283c\u283d\u283e\u283f\u2840\u2841\u2842\u2843\u2844\u2845\u2846\u2847\u2848\u2849\u284a\u284b\u284c\u284d\u284e\u284f\u2850\u2851\u2852\u2853\u2854\u2855\u2856\u2857\u2858\u2859\u285a\u285b\u285c\u285d\u285e\u285f\u2860\u2861\u2862\u2863\u2864\u2865\u2866\u2867\u2868\u2869\u286a\u286b\u286c\u286d\u286e\u286f\u2870\u2871\u2872\u2873\u2874\u2875\u2876\u2877\u2878\u2879\u287a\u287b\u287c\u287d\u287e\u287f\u2880\u2881\u2882\u2883\u2884\u2885\u2886\u2887\u2888\u2889\u288a\u288b\u288c\u288d\u288e\u288f\u2890\u2891\u2892\u2893\u2894\u2895\u2896\u2897\u2898\u2899\u289a\u289b\u289c\u289d\u289e\u289f\u28a0\u28a1\u28a2\u28a3\u28a4\u28a5\u28a6\u28a7\u28a8\u28a9\u28aa\u28ab\u28ac\u28ad\u28ae\u28af\u28b0\u28b1\u28b2\u28b3\u28b4\u28b5\u28b6\u28b7\u28b8\u28b9\u28ba\u28bb\u28bc\u28bd\u28be\u28bf\u28c0\u28c1\u28c2\u28c3\u28c4\u28c5\u28c6\u28c7\u28c8\u28c9\u28ca\u28cb\u28cc\u28cd\u28ce\u28cf\u28d0\u28d1\u28d2\u28d3\u28d4\u28d5\u28d6\u28d7\u28d8\u28d9\u28da\u28db\u28dc\u28dd\u28de\u28df\u28e0\u28e1\u28e2\u28e3\u28e4\u28e5\u28e6\u28e7\u28e8\u28e9\u28ea\u28eb\u28ec\u28ed\u28ee\u28ef\u28f0\u28f1\u28f2\u28f3\u28f4\u28f5\u28f6\u28f7\u28f8\u28f9\u28fa\u28fb\u28fc\u28fd\u28fe\u28ff";

    union(){
        for(txtIdx=[0:(len(my_text)-1)])
        {
            searched = search(my_text[txtIdx] ,dic);
            if(len(searched)==1){
                brailleNo = searched[0];
                putBraille(between_characters_X*txtIdx,0,brailleNo);
            }
        }

        if ( board_type==1 ){
            translate([0,-between_characters_Y,-board_thickness])
            minkowski()
            {
                cube([boardBaseX,between_characters_Y,board_thickness/2]);
                cylinder(r=board_corner_R,h=board_thickness/2,$fn=corner_detail);
            }
        }else if(board_type==2 ){
            echo (2);
            difference() {

                calcX2=connector_diameter/2+connector_offset+dot_diameter;
                translate([-calcX2,-between_characters_Y,-board_thickness])
                minkowski()
                {

                    cube([boardBaseX+calcX2,between_characters_Y,board_thickness/2]);
                    cylinder(r=board_corner_R,h=board_thickness/2,$fn=corner_detail);
                }

                translate([-calcX2,-between_characters_Y/2,-(board_thickness)/2])
                cylinder(h=board_thickness+1,r=connector_diameter/2 , center=true,$fn=corner_detail);
            }
        }else if(board_type==3 ){
            echo (2);
            difference() {

                calcX3=connector_diameter/2+connector_offset+dot_diameter;
                translate([0,-between_characters_Y,-board_thickness])
                minkowski()
                {

                    cube([boardBaseX+calcX3,between_characters_Y,board_thickness/2]);
                    cylinder(r=board_corner_R,h=board_thickness/2,$fn=corner_detail);
                }

                translate([boardBaseX+calcX3,-between_characters_Y/2,-(board_thickness)/2])
                cylinder(h=board_thickness+1,r=connector_diameter/2 , center=true,$fn=corner_detail);
            }
        }else if(board_type==4 ){
            echo (2);
            difference() {

                calcX4=(connector_diameter/2+connector_offset+dot_diameter)*2;
                translate([-calcX4/2,-between_characters_Y,-board_thickness])
                minkowski()
                {

                    cube([boardBaseX+calcX4,between_characters_Y,board_thickness/2]);
                    cylinder(r=board_corner_R,h=board_thickness/2,$fn=corner_detail);
                }

                {
                    translate([boardBaseX+calcX4/2,-between_characters_Y/2,-(board_thickness)/2])
                    cylinder(h=board_thickness+1,r=connector_diameter/2 , center=true,$fn=corner_detail);

                    translate([-calcX4/2,-between_characters_Y/2,-(board_thickness)/2])
                    cylinder(h=board_thickness+1,r=connector_diameter/2 , center=true,$fn=corner_detail);
                }

            }
        }
    }
}

BrailleAlphabet();