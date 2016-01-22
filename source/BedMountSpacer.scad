module tube(id=1, od=2, height = 5) {
    difference() {
        cylinder(d=od, h=height);
        translate([0,0,-1])cylinder(d=id, h=height+2);
        
    }
}

module bedMountSpacer(height = 5) {
    id=3.5;
    od=7;

    translate([-6,0,0])tube(id=id, od=od, height=height);
    translate([6,0,0])tube(id=id, od=od, height=height);
    translate([0,0,height/2])cube([14-od, 3, height], center=true);
}

$fs=0.3;
$fa=3;
bedMountSpacer(height = 5);