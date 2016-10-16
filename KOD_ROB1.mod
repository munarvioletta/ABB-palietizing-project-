MODULE Module1
	CONST robtarget Target_10:=[[593.178726827,865.74737191,317.97197579],[0.354211744,-0.611229917,0.613512916,0.352893654],[0,-1,0,0],[9E9,9E9,9E9,9E9,9E9,9E9]];
	CONST robtarget Target_20:=[[194.026876309,472.653788018,317.97197579],[0.002891356,-0.866010987,0.005007978,0.49999153],[0,0,-1,0],[9E9,9E9,9E9,9E9,9E9,9E9]];
	CONST robtarget Target_30:=[[135.946,699.409,150.722],[0,1,0,0],[0,0,-1,0],[9E9,9E9,9E9,9E9,9E9,9E9]];
	CONST robtarget Target_60:=[[678.650956882,774.956017247,304.821967345],[-0.00000001,-0.499999961,0.866025426,-0.00000001],[-1,-1,0,0],[9E9,9E9,9E9,9E9,9E9,9E9]];
	CONST robtarget Target_50:=[[671.6,776.72,101],[0,-0.500000001,0.866025403,0],[-1,0,0,0],[9E9,9E9,9E9,9E9,9E9,9E9]];
	CONST robtarget Target_40:=[[134.946,694.409,50.722],[0,1,0,0],[0,0,-1,0],[9E9,9E9,9E9,9E9,9E9,9E9]];
    CONST robtarget Target_40_2:=[[134.946,694.409,150.722],[0,1,0,0],[0,0,-1,0],[9E9,9E9,9E9,9E9,9E9,9E9]];
    CONST robtarget Target_70:=[[603.191337153,855.11193197,293.004044519],[0.316678864,-0.608391936,0.655769008,0.315500805],[-1,-1,0,0],[9E9,9E9,9E9,9E9,9E9,9E9]];
    CONST robtarget Target_80:=[[605.023400602,901.677988325,258.020840055],[0.316678864,-0.608391936,0.655769008,0.315500805],[-1,-1,0,0],[9E9,9E9,9E9,9E9,9E9,9E9]];
	VAR   robtarget TempTarget:=[[134.585128488,694.410345379,50.722],[0,1,0,0],[0,0,-1,0],[9E9,9E9,9E9,9E9,9E9,9E9]];
    VAR   robtarget Target_Odlozenia:=[[671.6,776.72,105],[0,-0.500000001,0.866025403,0],[-1,0,0,0],[9E9,9E9,9E9,9E9,9E9,9E9]];
   
    PROC main()
        
    Reset;   
    ConfL\Off;
    SetDO  DO_ROB1_NT0, 1; 
    WaitTime \InPos, 2;
    Path_10; 
    
     ENDPROC    
      
    
      PROC Reset()
        
       MoveL Target_60,vmax,fine,Chwyt_1\WObj:=Workobject_przenosnik1;
   
       SetDO DO_ROB1, 0;
       SetDO DO_ROB1_Pose0, 0;
       SetDO DO_ROB2_W0,0;      
       SetDO DO_ROB1_T ,0;
                          
      ENDPROC          
    
      PROC Path_10()
        
       
        FOR j FROM 0 TO 3 DO    
                               
         FOR i FROM 0 TO 2 DO
             
                             
            MoveL Target_60,v500,fine,Chwyt_1\WObj:=Workobject_przenosnik1;          ! idz do punktu 60             
            TPWrite "i = : " \Num:= i;
            TPWrite "j = : " \Num:= j;                       
            TempTarget := ZmiennyPunkt(i, j, Target_40); 
            MoveL Offs(TempTarget, 0,0,100), v600, fine, Chwyt_1\WObj:=Workobject_przenosnik1;
      
            MoveL TempTarget, v100, fine, Chwyt_1\WObj:=Workobject_przenosnik1;      
         
            
            IF i=1 THEN
                SetDO DO_ROB1,1;          ! zamykanie calkowie chwytaka
            ELSE
                SetDO DO_ROB1_Pose0, 1;    !zamykanie polowiczne chwytaka  
            ENDIF           
            WaitTime \InPos, 0.5;
            
            TempTarget:=Offs(TempTarget, 0, 0, 100);
            MoveL TempTarget, v1500, fine, Chwyt_1\WObj:=Workobject_przenosnik1;             
            MoveL Target_60,v500,fine,Chwyt_1\WObj:=Workobject_przenosnik1;           
            Target_Odlozenia := Odloz(i,Target_50);    
            MoveL Target_Odlozenia,v100,fine,Chwyt_1\WObj:=Workobject_przenosnik1; 
            WaitTime \InPos, 0.5;
            SetDO DO_ROB1,0;  
            SetDO DO_ROB1_Pose0, 0; 
            MoveL Target_60,v500,fine,Chwyt_1\WObj:=Workobject_przenosnik1; 
            TPErase;
            
         ENDFOR
         
         SetDO DO_ROB1_S0,0;
         WaitTime \InPos, 0.2;
                  
         IF  j<1 THEN
             
                SetDO DO_Act_ROB20, 1;
         ELSE
                WaitDO DO_koniec_w0, 1;
         ENDIF
         
     
     ENDFOR
    
      SetDO DO_ROB1_T,1;    
      SetDO  DO_ROB1_NT0, 0;

      
    ENDPROC
     

 !-------Funkcja pobierajaca elementy z tacki------------       
    FUNC robtarget ZmiennyPunkt(num n, num k, robtarget PozycjaBazowa)
      
            TempTarget := Offs(PozycjaBazowa,k*(68),n*(-168),0);
    
        RETURN TempTarget;
    ENDFUNC
    
    !-------Funkcja odkladajaca elementy na stol obrotowy------------  
    
    FUNC robtarget Odloz(num n, robtarget punkPocz)
        IF n<2 THEN
        
            Target_Odlozenia := Offs(punkPocz,n*5.6,2,n*5);
        ELSE
             Target_Odlozenia := Offs(punkPocz,n*4.8,n-6.8,n*5.5);
        ENDIF    
         RETURN Target_Odlozenia;
    ENDFUNC
      
        
ENDMODULE
