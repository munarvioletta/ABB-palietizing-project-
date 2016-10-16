MODULE Module1
	CONST robtarget Target_10:=[[227.85878762,-55.470494519,209.499969108],[0.065263082,-0.858616499,0.113039006,0.495722322],[-1,0,-1,0],[9E9,9E9,9E9,9E9,9E9,9E9]];
	CONST robtarget Target_20:=[[269.684596703,-66.677686274,234.499980059],[0.065263082,-0.858616499,0.113039006,0.495722322],[-1,0,-1,0],[9E9,9E9,9E9,9E9,9E9,9E9]];
    CONST robtarget Target_30_2:=[[483.841695156,280.377999998,96.6],[0,0.866025404,-0.5,0],[-1,0,-1,0],[9E9,9E9,9E9,9E9,9E9,9E9]];
    CONST robtarget Target_30:=[[484.62111802,280.827999998,26.6],[0,0.866025404,-0.5,0],[-1,0,-1,0],[9E9,9E9,9E9,9E9,9E9,9E9]];
    CONST robtarget Target_40:=[[323.841400519,-51.9,16],[0,1,0,0],[-1,0,-1,0],[9E9,9E9,9E9,9E9,9E9,9E9]];
    CONST robtarget Target_40_2:=[[323.841400519,-51.811759204,112.5],[0,1,0,0],[-1,0,-1,0],[9E9,9E9,9E9,9E9,9E9,9E9]];
	CONST robtarget Target_50_2:=[[311.841664523,-51.811606784,112.5],[0,1,0,0],[-1,0,-1,0],[9E9,9E9,9E9,9E9,9E9,9E9]];
	CONST robtarget Target_50:=[[311.841664523,-51.811606784,16],[0,1,0,0],[-1,0,-1,0],[9E9,9E9,9E9,9E9,9E9,9E9]];
	CONST robtarget Target_60:=[[327.841326936,-10.9,16],[0,1,0,0],[-1,0,-1,0],[9E9,9E9,9E9,9E9,9E9,9E9]];
    CONST robtarget Target_60_2:=[[327.841326936,-11.311834999,112.5],[0,1,0,0],[-1,0,-1,0],[9E9,9E9,9E9,9E9,9E9,9E9]];
    
	VAR   robtarget TempTarget2:=[[323.841400519,-51.9,16],[0,1,0,0],[-1,0,-1,0],[9E9,9E9,9E9,9E9,9E9,9E9]];
    VAR   robtarget Target_Odlozenia2:=[[327.841326936,-10.9,16],[0,1,0,0],[-1,0,-1,0],[9E9,9E9,9E9,9E9,9E9,9E9]];
    
    
    PROC main()	
         Reset;
         SetDO DO_ROB1_T, 0 ;
                 
    FOR m FROM 0 TO 3 DO   
        
         TPWrite "m = : " \Num:= m;     
         WaitDO DO_Act_ROB20,1;
         ConfL\Off;       
         
         TEST m

            CASE 0 :
                
                  TPWrite "m = : " \Num:= m;  
                  PulseDO\High\PLength:=1,DO_ROB1_S0;                             
                  Path_20;
                  SetDO DO_ROB3_NT0,1; 
                  SetDO DO_Act_ROB30, 1;      
                  TPErase;
                  WaitTime 2;    

            CASE 1 :
                    TPWrite "m = : " \Num:= m;                       
                    PulseDO\High\PLength:=1,DO_ROB1_S0;
                    SetDO DO_mierzCzas0 ,1;
                    SetDO DO_koniec_w0,1; 
                    Path_20;  
                    SetDO DO_mierzCzas0, 0;  
                    WaitTime \InPos, 1;
                    SetDO DO_ROB3_NT0, 1;                    
                    SetDO DO_koniec_w0, 0;
                    SetDO DO_Act_ROB30, 0;
                    
                    TPErase;
                    
            CASE 2:
                    TPWrite "m = : " \Num:= m;     
                    SetDO DO_Act_ROB30,1; 
                    PulseDO\High\PLength:=1,DO_ROB1_S0;
                  
                    SetDO DO_mierzCzas0, 1;
                    SetDO DO_koniec_w0,1;                      
                    Path_20;              
                    SetDO DO_mierzCzas0, 0; 
                    WaitTime \InPos, 1;                            
                    SetDO DO_koniec_w0, 0;
                    SetDO DO_Act_ROB30, 0;
                  
                    TPErase;
                     
            CASE 3: 
                    TPWrite "m = : " \Num:= m;     
                    SetDO DO_Act_ROB30,1;  
                    PulseDO\High\PLength:=1,DO_ROB1_S0;
                   
                    SetDO DO_mierzCzas0, 1;
                    SetDO DO_koniec_w0,1;                      
                    Path_20;                 
                    SetDO DO_mierzCzas0, 0;                  
                    WaitTime \InPos, 1;                   
                    SetDO DO_koniec_w0, 0;
                    SetDO DO_Act_ROB30, 0;
                    SetDO DO_ROB1_S0,0; 
                    TPErase;
                    SetDo DO_ROB1_S0,1;

            DEFAULT :
            TPWrite "Illegal choice";
            ENDTEST

    
    ENDFOR
        
	ENDPROC
    
    
    PROC Reset()
        
    MoveL Target_20,vmax,fine,wkretak\WObj:=Workobject_stol;  
    SetDO DO_ROB2_W0,0;
    
    ENDPROC   
    
    
        
    PROC Path_20()
        
        
        MoveL Target_20,v200,z100,wkretak\WObj:=Workobject_stol;   
      
        FOR y1 FROM 0 TO 1 DO 
                                
         FOR x1 FROM 0 TO 1 DO      
                                
            MoveL Target_30_2,v1500,z100,wkretak\WObj:=Workobject_stol;
           
            MoveL Target_30,v100,fine,wkretak\WObj:=Workobject_stol;
            WaitTime \InPos,1;
            SetDO DO_ROB2_W0, 1;
            MoveL Target_30_2,v1500,fine,wkretak\WObj:=Workobject_stol;
          
            
             TPWrite "x1 = : " \Num:= x1;
             TPWrite "y1 = : " \Num:= y1;   
            
            TempTarget2 := Punkt_wkrecania(x1, y1, Target_40);            
            MoveL Offs(TempTarget2, 0,0,100), v1500, fine, wkretak\WObj:=Workobject_stol;
            MoveL TempTarget2, v100, fine, wkretak\WObj:=Workobject_stol;
            WaitTime \InPos, 1; 
            SetDO DO_ROB2_W0, 0;   
        
       
            MoveL Offs(TempTarget2, 0,0,100), v1500, fine, wkretak\WObj:=Workobject_stol;
            
           
         
        ENDFOR     
        
     ENDFOR 
     
      FOR y2 FROM 0 TO 1 DO             
                  
         FOR x2 FROM 0 TO 1 DO
             
            IF y2 = 0 THEN
                SetDO DO_koniec_w0, 0;
            ENDIF        
            
                                
            MoveL Target_30_2,v1500,fine,wkretak\WObj:=Workobject_stol;
            MoveL Target_30,v200,fine,wkretak\WObj:=Workobject_stol;
            WaitTime \InPos, 1;
            SetDO DO_ROB2_W0, 1;
            MoveL Target_30_2,v1500,fine,wkretak\WObj:=Workobject_stol;
            
            TPWrite "x2 = : " \Num:= x2;
            TPWrite "y2 = : " \Num:= y2;   
            
            Target_Odlozenia2 := Punkt_wkrecania2(x2, y2, Target_60); 
         
            MoveL Offs(Target_Odlozenia2, 0,0,100), v1500, fine, wkretak\WObj:=Workobject_stol;           
            MoveL Target_Odlozenia2, v100,fine, wkretak\WObj:=Workobject_stol;
            WaitTime \InPos, 1;    
            SetDO DO_ROB2_W0, 0;                  
         
            MoveL Offs(Target_Odlozenia2, 0,0,100), v1500, fine, wkretak\WObj:=Workobject_stol;
                                  
         
        ENDFOR   
         SetDO DO_Act_ROB30, 0;
     ENDFOR 
                              
    MoveL Target_20,v200,z100,wkretak\WObj:=Workobject_stol;   
    WaitTime \InPos, 2.5;  
    SetDO DO_Act_ROB30, 1;
      
    ENDPROC

            
    FUNC robtarget Punkt_wkrecania(num n, num k, robtarget PozycjaPocz)
      
            TempTarget2 := Offs(PozycjaPocz,n*(-12),k*(104.31),0);                
    
        RETURN TempTarget2;
    ENDFUNC
    
    
    FUNC robtarget Punkt_wkrecania2(num n, num k, robtarget PozycjaPocz2)       
        
            Target_Odlozenia2 := Offs(PozycjaPocz2, n*(-19.8), k*(37.9),0);
       
         RETURN Target_Odlozenia2;
    ENDFUNC
   
    
ENDMODULE
 
