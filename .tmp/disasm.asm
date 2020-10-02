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
L987C:       equ  987Ch
L98DB:       equ  98DBh
LEAF6:       equ  EAF6h
LEB3D:       equ  EB3Dh


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
9808 21 00 58     LD   HL,5800h 
980B 06 44        LD   B,44h  
980D CD DB 98     CALL L98DB  
9810 C3 F6 EA     JP   LEAF6  


9813 CD           defb CDh    
             org 9BC7h


9BC7 L9BC7:
9BC7 CD           defb CDh    
9BC8 CB           defb CBh    
9BC9 9B           defb 9Bh    
9BCA C9           defb C9h    
9BCB 11           defb 11h    
9BCC 01           defb 01h    
9BCD 80           defb 80h    
9BCE 01           defb 01h    
9BCF 00           defb 00h    
9BD0 15           defb 15h    
9BD1 36           defb 36h    
9BD2 00           defb 00h    


9BD3 L9BD3:
9BD3 ED B0        LDIR        
9BD5 C9           RET         


9BD6 F3           defb F3h    
9BD7 FD           defb FDh    
9BD8 E5           defb E5h    
9BD9 DD           defb DDh    
9BDA E5           defb E5h    
9BDB E5           defb E5h    
9BDC D5           defb D5h    
9BDD C5           defb C5h    
9BDE F5           defb F5h    
9BDF ED           defb EDh    
9BE0 73           defb 73h    
9BE1 C2           defb C2h    
9BE2 9B           defb 9Bh    
9BE3 31           defb 31h    
9BE4 02           defb 02h    
9BE5 80           defb 80h    
9BE6 F1           defb F1h    
9BE7 C1           defb C1h    
9BE8 D1           defb D1h    
9BE9 E1           defb E1h    
9BEA DD           defb DDh    
9BEB E1           defb E1h    
9BEC FD           defb FDh    
9BED E1           defb E1h    
9BEE 31           defb 31h    
9BEF 0C           defb 0Ch    
9BF0 40           defb 40h    
9BF1 FD           defb FDh    
9BF2 E5           defb E5h    
9BF3 DD           defb DDh    
9BF4 E5           defb E5h    
9BF5 E5           defb E5h    
9BF6 D5           defb D5h    
9BF7 C5           defb C5h    
9BF8 F5           defb F5h    
9BF9 31           defb 31h    
9BFA 0E           defb 0Eh    
9BFB 80           defb 80h    
9BFC F1           defb F1h    
9BFD C1           defb C1h    
9BFE D1           defb D1h    
9BFF E1           defb E1h    
9C00 DD           defb DDh    
9C01 E1           defb E1h    
9C02 FD           defb FDh    
9C03 E1           defb E1h    
9C04 31           defb 31h    
9C05 18           defb 18h    
9C06 40           defb 40h    
9C07 FD           defb FDh    
9C08 E5           defb E5h    
9C09 DD           defb DDh    
9C0A E5           defb E5h    
9C0B E5           defb E5h    
9C0C D5           defb D5h    
9C0D C5           defb C5h    
9C0E F5           defb F5h    
9C0F 31           defb 31h    
9C10 1E           defb 1Eh    
9C11 80           defb 80h    
9C12 F1           defb F1h    
9C13 C1           defb C1h    
9C14 D1           defb D1h    
9C15 E1           defb E1h    
9C16 DD           defb DDh    
9C17 E1           defb E1h    
9C18 FD           defb FDh    
9C19 E1           defb E1h    
9C1A 31           defb 31h    
9C1B 0C           defb 0Ch    
9C1C 41           defb 41h    
9C1D FD           defb FDh    
9C1E E5           defb E5h    
9C1F DD           defb DDh    
9C20 E5           defb E5h    
9C21 E5           defb E5h    
9C22 D5           defb D5h    
9C23 C5           defb C5h    
9C24 F5           defb F5h    
9C25 31           defb 31h    
9C26 2A           defb 2Ah    
9C27 80           defb 80h    
9C28 F1           defb F1h    
9C29 C1           defb C1h    
9C2A D1           defb D1h    
9C2B E1           defb E1h    
9C2C DD           defb DDh    
9C2D E1           defb E1h    
9C2E FD           defb FDh    
9C2F E1           defb E1h    
9C30 31           defb 31h    
9C31 18           defb 18h    
9C32 41           defb 41h    
9C33 FD           defb FDh    
9C34 E5           defb E5h    
9C35 DD           defb DDh    
9C36 E5           defb E5h    


             org EB49h


EB49 LEB49:
EB49 CD 7C 98     CALL L987C  
EB4C D1           POP  DE     
EB4D C1           POP  BC     
EB4E 62           LD   H,D    
EB4F 6B           LD   L,E    
EB50 09           ADD  HL,BC  
EB51 54           LD   D,H    
EB52 5D           LD   E,L    
EB53 E1           POP  HL     
EB54 79           LD   A,C    
EB55 C6 01        ADD  A,01h  
EB57 4F           LD   C,A    
EB58 C3 3D EB     JP   LEB3D  


EB5B 00           defb 00h    
EB5C 00           defb 00h    
EB5D 00           defb 00h    
EB5E 00           defb 00h    
EB5F 00           defb 00h    
EB60 00           defb 00h    
EB61 00           defb 00h    
EB62 00           defb 00h    
EB63 00           defb 00h    
EB64 00           defb 00h    
EB65 00           defb 00h    
EB66 00           defb 00h    
EB67 00           defb 00h    
EB68 00           defb 00h    
EB69 00           defb 00h    
EB6A 00           defb 00h    
EB6B 00           defb 00h    
EB6C 00           defb 00h    
EB6D 00           defb 00h    
EB6E 00           defb 00h    
EB6F 00           defb 00h    
EB70 00           defb 00h    
EB71 00           defb 00h    
EB72 00           defb 00h    
EB73 00           defb 00h    
EB74 00           defb 00h    
EB75 00           defb 00h    
EB76 00           defb 00h    
EB77 00           defb 00h    
EB78 00           defb 00h    
EB79 00           defb 00h    
EB7A 00           defb 00h    
EB7B 00           defb 00h    
EB7C 00           defb 00h    
EB7D 00           defb 00h    
EB7E 00           defb 00h    
EB7F 00           defb 00h    
EB80 00           defb 00h    
EB81 00           defb 00h    
EB82 00           defb 00h    
EB83 00           defb 00h    
EB84 00           defb 00h    
EB85 00           defb 00h    
EB86 00           defb 00h    
EB87 00           defb 00h    
EB88 00           defb 00h    
EB89 00           defb 00h    
EB8A 00           defb 00h    
EB8B 00           defb 00h    
EB8C 00           defb 00h    
EB8D 00           defb 00h    
EB8E 00           defb 00h    
EB8F 00           defb 00h    
EB90 00           defb 00h    
EB91 00           defb 00h    
EB92 00           defb 00h    
EB93 00           defb 00h    
EB94 00           defb 00h    
EB95 00           defb 00h    
EB96 00           defb 00h    
EB97 00           defb 00h    
EB98 00           defb 00h    
EB99 00           defb 00h    
EB9A 00           defb 00h    
EB9B 00           defb 00h    
EB9C 00           defb 00h    
EB9D 00           defb 00h    
EB9E 00           defb 00h    
EB9F 00           defb 00h    
EBA0 00           defb 00h    
EBA1 00           defb 00h    
EBA2 00           defb 00h    
EBA3 00           defb 00h    
EBA4 00           defb 00h    
EBA5 00           defb 00h    
EBA6 00           defb 00h    
EBA7 00           defb 00h    
EBA8 00           defb 00h    
EBA9 00           defb 00h    
EBAA 00           defb 00h    
EBAB 00           defb 00h    
EBAC 00           defb 00h    