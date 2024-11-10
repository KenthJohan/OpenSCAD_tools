/*
https://www.lwfasteners.com.tw/index.php?option=module&lang=en&task=pageinfo&id=51&index=1
https://github.com/openscad/openscad/issues/405

Bolt_M1_4 = 0;
Bolt_M1_6 = 1;
Bolt_M2 = 2;
Bolt_M2_5 = 3;
Bolt_M3 = 4;
Bolt_M4 = 5;
Bolt_M5 = 6;

// DIN 912 screws across flats sizes
//          M1.4 M1.6 M2   M2.5 M3   M4   M5   M6
DIN912_s = [1.5, 1.5, 1.5, 2.0, 2.5, 3.0, 4.0, 5.0, 6.0, 8.0, 10.0, 12.0, 14.0, 17.0];

*/

module case(t,l,h,r) {
    hull(){
        translate([-t/2, l/2, h])
            cylinder(h=h, r=r,center=true);
        translate([t/2, l/2, h])
            cube([r,r,h],center=true);
        translate([t/2, -l/2, h])
            cube([r,r,h],center=true);
        translate([-t/2, -l/2, h])
            cylinder(h=h, r=r,center=true);
    }
}


case(20, 100, 14, 5);