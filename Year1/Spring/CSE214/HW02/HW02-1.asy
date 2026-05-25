if(!settings.multipleView) settings.batchView=false;
settings.tex="pdflatex";
defaultfilename="HW02-1";
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

unitsize(0.5cm);
int[] A = {1, 2, 3, 4, 5};
pair s = (0,0);
draw((s+(0,0))--(s+(5,0))--(s+(5,1))--(s+(0,1))--cycle);
for (int i = 1; i < 5; ++i) draw((s+(i,0))--(s+(i,1)));
for (int i = 0; i < 5; ++i) label(string(A[i]), s+(i+0.5,0.5));
label("initial array", s + (2.5,-0.5));

for (int i = 0; i < 5; ++i) {
for (int j = 0; j < 5; ++j) {
pair s = (6*(j-2),-2.4*(i+1));
if (i == j) {
fill((s+(i,0))--(s+(i+1,0))--(s+(i+1,1))--(s+(i,1))--cycle,blue+opacity(0.3));
}
else {
fill((s+(i,0))--(s+(i+1,0))--(s+(i+1,1))--(s+(i,1))--cycle,red+opacity(0.3));
fill((s+(j,0))--(s+(j+1,0))--(s+(j+1,1))--(s+(j,1))--cycle,heavygreen+opacity(0.3));
}
if (A[i] < A[j]) { // swap
int tmp = A[i];
A[i] = A[j];
A[j] = tmp;
}
draw((s+(0,0))--(s+(5,0))--(s+(5,1))--(s+(0,1))--cycle);
for (int i = 1; i < 5; ++i) draw((s+(i,0))--(s+(i,1)));
for (int i = 0; i < 5; ++i) label(string(A[i]), s+(i+0.5,0.5));
label("("+string(i+1)+","+string(j+1)+")", s + (2.5,-0.5));
}
}
