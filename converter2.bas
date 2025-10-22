!-https://patsos.de/New_Weblog/?p=671
!-V2
!- fixed the mem overwrite by lowering basic mem?
!-
!-V1
!-megabug in v0 converter was adding a useless ,
!-now we are saving space! kinda
!-converter in line 200 now spits out 3 bytes instead of 10 bytes per line,
!-saving the x'th 9 bit in command a
!- bit 2:if 0 then plot, else its a line.
!- use any disk size you want.
!-
!- asc stuff: https://www.c64-wiki.com/wiki/ASC
!-
1 rem vector graphics
6 rem goto 200:rem convert file
10 ifpeek(49152)<>76orpeek(49152+868)<>7thenload"gfx07c1",8,1:rem input"ready";a$
12 poke55,0:poke56,139:rem memsiz $8b00 : to go under colmem
14 poke51,peek(55):poke52,peek(56):clr:rem fretop $8b00 : to go under colmem
15 z$=chr$(0)
16 n$(1)="newhubble":n$(2)="newcourios":n$(3)="newvoyager":n$(4)="newteapot"
20 g=49152:cl=g+18:line=g+21:hires=g+15:text=g+6:plot=g:rem goto29
23 print"thanks to alvaro alonso for gfx-engine.":print
26 print"select file:":print:forx=1to4:printx;n$(x):next
27 input a:if a<1 or a>4 then26
28 f$=n$(a)
29 ti$="000000":sys hires,13,0:sys cl,1:poke53280,11:poke53281,0:rem enable hires and pen
30 open 2,8,2,f$+",s"
40 get#2,a$:get#2,b$:get#2,c$
41 a=asc(a$+z$):b=asc(b$+z$):c=asc(c$+z$)
42 if(a and 128)>0thenb=b+256
50 if(a and 64)=0thensysplot,b,c:goto75
60 sysline,x,y,b,c
75 x=b:y=c
77 ifpeek(198)>0then90:rem key to abort
80 l=l+1:if st<>64 then goto40:rem z=fre(0):
90 close2:rem close file
95 poke53280,0:inputa$ :rem wait for enter
100 sys text:print"{white}processed "l"lines.
110 print"time: "ti,ti$:end
199 rem convert a file - no error checking!
200 print"insert source in 8, destination in 9"
202 input"source filename: ";sf$
203 input"destination filename: ";df$
204 l=0:d=-1:e=-1:print"converting file "sf$
205 open 2,8,2,sf$+",s"
208 open 3,9,3,df$+",s,w"
210 input#2,a,b,c
215 ifa=3then250:rem end of file
220 ifd=bthenife=cthenprint"repeat "a,b,c:q=q+1:goto210
230 d=b:e=c:l=l+1:rem print"ok data"a,b,c
234 f=0:g=b:rem convert to 3 bytes
236 if b>255 then f=128:g=b and 255:rem enable 9th bit and clear
238 ifa=1 then f=f+64:rem enable line bit, otherwise plot
239 print"outdata: "f,g,c
240 print#3,chr$(f)+chr$(g)+chr$(c);
245 goto210
250 close2:close3
260 print"found "q" data repeats in "l" lines."
270 end
300 rem forx=.to 255:a$=str$(x):a$=right$(a$,len(a$)-1):print"-"a$"-":next