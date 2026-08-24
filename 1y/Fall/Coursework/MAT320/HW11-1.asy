if(!settings.multipleView) settings.batchView=false;
settings.tex="pdflatex";
defaultfilename="HW11-1";
if(settings.render < 0) settings.render=4;
settings.outformat="";
settings.inlineimage=true;
settings.embed=true;
settings.toolbar=false;
viewportmargin=(2,2);

defaultpen(fontsize(10pt));
unitsize(1cm);
size(8cm); // set a reasonable default
usepackage("amsmath");
usepackage("amssymb");
settings.tex="pdflatex";
settings.outformat="pdf";
// Replacement for olympiad+cse5 which is not standard
import geometry;
// recalibrate fill and filldraw for conics
void filldraw(picture pic = currentpicture, conic g, pen fillpen=defaultpen, pen drawpen=defaultpen)
{ filldraw(pic, (path) g, fillpen, drawpen); }
void fill(picture pic = currentpicture, conic g, pen p=defaultpen)
{ filldraw(pic, (path) g, p); }
// some geometry
pair foot(pair P, pair A, pair B) { return foot(triangle(A,B,P).VC); }
pair orthocenter(pair A, pair B, pair C) { return orthocentercenter(A,B,C); }
pair centroid(pair A, pair B, pair C) { return (A+B+C)/3; }
// cse5 abbreviations
path CP(pair P, pair A) { return circle(P, abs(A-P)); }
path CR(pair P, real r) { return circle(P, r); }
pair IP(path p, path q) { return intersectionpoints(p,q)[0]; }
pair OP(path p, path q) { return intersectionpoints(p,q)[1]; }
path Line(pair A, pair B, real a=0.6, real b=a) { return (a*(A-B)+A)--(b*(B-A)+B); }
// cse5 more useful functions
picture CC() {
picture p=rotate(0)*currentpicture;
currentpicture.erase();
return p;
}
pair MP(Label s, pair A, pair B = plain.S, pen p = defaultpen) {
Label L = s;
L.s = "$"+s.s+"$";
label(L, A, B, p);
return A;
}
pair Drawing(Label s = "", pair A, pair B = plain.S, pen p = defaultpen) {
dot(MP(s, A, B, p), p);
return A;
}
path Drawing(path g, pen p = defaultpen, arrowbar ar = None) {
draw(g, p, ar);
return g;
}

fill((-3,2)--(-2,2)--(-2,5/2)--(-1,5/2)--(-1,19/6)--(1,19/6)--(1,7/6)--(2,7/6)--(2,2/3)--(3,2/3)--(3,0)--(-3,0)--cycle,red+opacity(0.2));
draw((-3,2)--(-2,2),red+linewidth(1));
filldraw(circle((-3,2),0.05),red,red);
filldraw(circle((-2,2),0.05),white,red);
draw((-2,5/2)--(-1,5/2),red+linewidth(1));
filldraw(circle((-2,5/2),0.05),red,red);
filldraw(circle((-1,5/2),0.05),white,red);
draw((-1,19/6)--(1,19/6),red);
filldraw(circle((-1,19/6),0.05),red,red);
filldraw(circle((1,19/6),0.05),red,red);
draw((1,7/6)--(2,7/6),red+linewidth(1));
filldraw(circle((1,7/6),0.05),white,red);
filldraw(circle((2,7/6),0.05),red,red);
draw((2,2/3)--(3,2/3),red+linewidth(1));
filldraw(circle((2,2/3),0.05),white,red);
filldraw(circle((3,2/3),0.05),red,red);
draw((-4,0)--(4,0),Arrows(5));

for (int i = -3; i <= 3; ++i) {
draw((i, 0.1)--(i, -0.1));
label("$" + string(i) + "$", (i, -0.1),dir(-90));
}
