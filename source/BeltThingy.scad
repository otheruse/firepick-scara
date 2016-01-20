$fs=0.5;
$fa=4;
 echo("Version:",version());
difference () {
    
        translate([0,0,-1])rotate ([0,90,0])cylinder (d=10,h=10);
        translate([0,0,-1])rotate ([0,90,0])translate ([0,0,3])rotate_extrude ()translate ([4,0])square ([2,4]);
   translate ([5,0,-5])cube([12,12,10],center=true);
}
