// https://github.com/BelfrySCAD/BOSL2/wiki/

include <BOSL2/std.scad>



table_width = 2000;
table_depth = 800;
table_thick = 20;
profile_dim = 20;

desk_thick = 300;
desk_thick1 = desk_thick - profile_dim*2;

color([0,1,1])
cuboid([table_width,table_depth,table_thick],anchor=[0,1,1]);


color([1,0,1])
cuboid([table_width,profile_dim,table_thick],anchor=[0,1,-1]);


color([1,0,1])
translate([0,-(desk_thick-profile_dim),0])
cuboid([table_width,profile_dim,table_thick],anchor=[0,1,-1]);

