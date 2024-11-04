// https://www.lwfasteners.com.tw/index.php?option=module&lang=en&task=pageinfo&id=51&index=1

Bolt_M1_4 = 0;
Bolt_M1_6 = 1;
Bolt_M2 = 2;
Bolt_M2_5 = 3;
Bolt_M3 = 4;
Bolt_M4 = 5;
Bolt_M5 = 6;
// DIN 912 screws across flats sizes
DIN912_s = [1.5, 1.5, 1.5, 2.0, 2.5, 3.0, 4.0, 5.0, 6.0, 8.0, 10.0, 12.0, 14.0, 17.0];







module hex(s,h) {
    n = 6;
    rm = s / 2;
    r = rm / cos(180/n);
    cylinder(h=h, r=r,$fn=n,center=true);
}


hex_key_set1 = [1.5, 2.0, 2.5, 3.0, 4.0];
hex_key_set2 = [5.0, 6.0, 8.0, 10.0, 12.0];

module hexes(h, spacing, arr) {
    spaces = [for (x = [0:len(arr)-1]) arr[x]*spacing];
    //y = -arr[0]*spacing - spaces[len(spaces)-1]/2;
    y = -spaces[0] - spaces[len(spaces)-1]/3;
    translate([0, y, 0]) {
        for ( i = [0:len(arr)-1] ){
            s = arr[i];
            translate([0, spaces[i], 0]) {
                hex(s,h);
            }
        }
    }
}


translate([-20, 0, 0])
difference() {
    spacing = 20;
    cube([20,100,10],center=true);
    group() {
        translate([0, 0, 0]) {
            hexes(11, spacing, hex_key_set1);
        }
    }
}


translate([20, 0, 0])
difference() {
    spacing = 10;
    cube([20,100,10],center=true);
    group() {
        translate([0, 0, 0]) {
            hexes(11, spacing, hex_key_set2);
        }
    }
}


