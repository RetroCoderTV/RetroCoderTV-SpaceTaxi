L0010:       equ  0010h
L0097:       equ  0097h
L0C0A:       equ  0C0Ah
L0D6E:       equ  0D6Eh
L0DAF:       equ  0DAFh
L0ECD:       equ  0ECDh
L15EF:       equ  15EFh
L16B0:       equ  16B0h
L1A1B:       equ  1A1Bh
L1B8A:       equ  1B8Ah
L229B:       equ  229Bh
L5C0B:       equ  5C0Bh
L5C16:       equ  5C16h
L5C3A:       equ  5C3Ah
L5C45:       equ  5C45h
L9814:       equ  9814h
L9818:       equ  9818h
LBFDC:       equ  BFDCh
LEAB0:       equ  EAB0h
LEAC0:       equ  EAC0h


             org 1300h


1300 L1300:
1300 CD 8A 1B     CALL L1B8A  
1303 76           HALT        
1304 FD CB 01 AE  RES  5,(IY+1) 
1308 FD CB 30 4E  BIT  1,(IY+48) 
130C C4 CD 0E     CALL NZ,L0ECD 
130F 3A 3A 5C     LD   A,(L5C3A) 
1312 3C           INC  A      
1313 F5           PUSH AF     
1314 21 00 00     LD   HL,0000h 
1317 FD 74 37     LD   (IY+55),H 
131A FD 74 26     LD   (IY+38),H 
131D 22 0B 5C     LD   (L5C0B),HL 
1320 21 01 00     LD   HL,0001h 
1323 22 16 5C     LD   (L5C16),HL 
1326 CD B0 16     CALL L16B0  
1329 FD CB 37 AE  RES  5,(IY+55) 
132D CD 6E 0D     CALL L0D6E  
1330 FD CB 02 EE  SET  5,(IY+2) 
1334 F1           POP  AF     
1335 47           LD   B,A    
1336 FE 0A        CP   0Ah    
1338 38 02        JR   C,L133C 
133A C6 07        ADD  A,07h  
133C L133C:
133C CD EF 15     CALL L15EF  
133F 3E 20        LD   A,20h  
1341 D7           RST  10h    
1342 78           LD   A,B    
1343 11 91 13     LD   DE,1391h 
1346 CD 0A 0C     CALL L0C0A  
1349 AF           XOR  A      
134A 11 36 15     LD   DE,1536h 
134D CD 0A 0C     CALL L0C0A  
1350 ED 4B 45 5C  LD   BC,(L5C45) 
1354 CD 1B 1A     CALL L1A1B  
1357 3E 3A        LD   A,3Ah  
1359 D7           RST  10h    
135A FD 4E 0D     LD   C,(IY+13) 
135D 06 00        LD   B,00h  
135F CD 1B 1A     CALL L1A1B  
1362 CD 97 00     CALL L0097  


             org 9800h


9800 L9800:
9800 CD AF 0D     CALL L0DAF  
9803 3E 01        LD   A,01h  
9805 CD 9B 22     CALL L229B  
9808 C3 0B 98     JP   L980B  
980B L980B:
980B CD 14 98     CALL L9814  
980E CD 18 98     CALL L9818  
9811 C3 0B 98     JP   L980B  


             org C038h


C038 LC038:
C038 B2           OR   D      
C039 77           LD   (HL),A 
C03A C9           RET         


C03B 21           defb 21h    
C03C 00           defb 00h    
C03D 00           defb 00h    
C03E 7B           defb 7Bh    
C03F 6F           defb 6Fh    
C040 29           defb 29h    
C041 29           defb 29h    
C042 D5           defb D5h    
C043 E5           defb E5h    
C044 D1           defb D1h    
C045 29           defb 29h    
C046 C5           defb C5h    
C047 E5           defb E5h    
C048 C1           defb C1h    
C049 29           defb 29h    
C04A 09           defb 09h    
C04B 19           defb 19h    
C04C C1           defb C1h    
C04D D1           defb D1h    
C04E 5A           defb 5Ah    
C04F 16           defb 16h    
C050 00           defb 00h    
C051 19           defb 19h    
C052 11           defb 11h    
C053 00           defb 00h    
C054 80           defb 80h    
C055 19           defb 19h    
C056 0A           defb 0Ah    
C057 CB           defb CBh    
C058 27           defb 27h    
C059 56           defb 56h    
C05A B2           defb B2h    
C05B 77           defb 77h    
C05C 03           defb 03h    
C05D 11           defb 11h    
C05E 1C           defb 1Ch    
C05F 00           defb 00h    
C060 19           defb 19h    
C061 0A           defb 0Ah    
C062 CB           defb CBh    
C063 27           defb 27h    
C064 56           defb 56h    
C065 B2           defb B2h    
C066 77           defb 77h    
C067 03           defb 03h    
C068 11           defb 11h    
C069 1C           defb 1Ch    
C06A 00           defb 00h    
C06B 19           defb 19h    
C06C 0A           defb 0Ah    
C06D CB           defb CBh    
C06E 27           defb 27h    
C06F 56           defb 56h    
C070 B2           defb B2h    
C071 77           defb 77h    
C072 03           defb 03h    
C073 11           defb 11h    
C074 1C           defb 1Ch    
C075 00           defb 00h    
C076 19           defb 19h    
C077 0A           defb 0Ah    
C078 CB           defb CBh    
C079 27           defb 27h    
C07A 56           defb 56h    
C07B B2           defb B2h    
C07C 77           defb 77h    
C07D 03           defb 03h    
C07E 11           defb 11h    
C07F 1C           defb 1Ch    
C080 00           defb 00h    
C081 19           defb 19h    
C082 0A           defb 0Ah    
C083 CB           defb CBh    
C084 27           defb 27h    
C085 56           defb 56h    
C086 B2           defb B2h    
C087 77           defb 77h    
C088 03           defb 03h    
C089 11           defb 11h    
C08A 1C           defb 1Ch    
C08B 00           defb 00h    
C08C 19           defb 19h    
C08D 0A           defb 0Ah    
C08E CB           defb CBh    
C08F 27           defb 27h    
C090 56           defb 56h    
C091 B2           defb B2h    
C092 77           defb 77h    
C093 03           defb 03h    
C094 11           defb 11h    
C095 1C           defb 1Ch    
C096 00           defb 00h    
C097 19           defb 19h    
C098 0A           defb 0Ah    
C099 CB           defb CBh    
C09A 27           defb 27h    
C09B 56           defb 56h    


             org EAD0h


EAD0 LEAD0:
EAD0 CD DC BF     CALL LBFDC  
EAD3 C1           POP  BC     
EAD4 10 EA        DJNZ LEAC0  
EAD6 11 05 00     LD   DE,0005h 
EAD9 DD 19        ADD  IX,DE  
EADB C3 B0 EA     JP   LEAB0  


EADE C9           defb C9h    
EADF 00           defb 00h    
EAE0 00           defb 00h    
EAE1 00           defb 00h    
EAE2 00           defb 00h    
EAE3 00           defb 00h    
EAE4 00           defb 00h    
EAE5 00           defb 00h    
EAE6 00           defb 00h    
EAE7 00           defb 00h    
EAE8 00           defb 00h    
EAE9 00           defb 00h    
EAEA 00           defb 00h    
EAEB 00           defb 00h    
EAEC 00           defb 00h    
EAED 00           defb 00h    
EAEE 00           defb 00h    
EAEF 00           defb 00h    
EAF0 00           defb 00h    
EAF1 00           defb 00h    
EAF2 00           defb 00h    
EAF3 00           defb 00h    
EAF4 CD           defb CDh    
EAF5 FB           defb FBh    
EAF6 BD           defb BDh    
EAF7 CD           defb CDh    
EAF8 05           defb 05h    
EAF9 BE           defb BEh    
EAFA CD           defb CDh    
EAFB F1           defb F1h    
EAFC BD           defb BDh    
EAFD CD           defb CDh    
EAFE 05           defb 05h    
EAFF BE           defb BEh    
EB00 CD           defb CDh    
EB01 FB           defb FBh    
EB02 BD           defb BDh    
EB03 00           defb 00h    
EB04 00           defb 00h    
EB05 00           defb 00h    
EB06 00           defb 00h    
EB07 00           defb 00h    
EB08 00           defb 00h    
EB09 00           defb 00h    
EB0A 00           defb 00h    
EB0B 00           defb 00h    
EB0C 00           defb 00h    
EB0D 00           defb 00h    
EB0E 00           defb 00h    
EB0F 00           defb 00h    
EB10 00           defb 00h    
EB11 00           defb 00h    
EB12 00           defb 00h    
EB13 00           defb 00h    
EB14 00           defb 00h    
EB15 00           defb 00h    
EB16 00           defb 00h    
EB17 00           defb 00h    
EB18 00           defb 00h    
EB19 00           defb 00h    
EB1A 00           defb 00h    
EB1B 00           defb 00h    
EB1C 00           defb 00h    
EB1D 00           defb 00h    
EB1E 00           defb 00h    
EB1F 00           defb 00h    
EB20 00           defb 00h    
EB21 00           defb 00h    
EB22 00           defb 00h    
EB23 00           defb 00h    
EB24 00           defb 00h    
EB25 00           defb 00h    
EB26 00           defb 00h    
EB27 00           defb 00h    
EB28 00           defb 00h    
EB29 00           defb 00h    
EB2A 00           defb 00h    
EB2B 00           defb 00h    
EB2C 00           defb 00h    
EB2D 00           defb 00h    
EB2E 00           defb 00h    
EB2F 00           defb 00h    
EB30 00           defb 00h    
EB31 00           defb 00h    
EB32 00           defb 00h    
EB33 00           defb 00h    