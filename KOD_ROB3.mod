MODULE Module1
	CONST robtarget Target_10:=[[823.806747465,843.804669206,317.308194765],[0.433012607,0.433012734,0.750000055,-0.249999945],[-1,0,0,0],[9E9,9E9,9E9,9E9,9E9,9E9]];
	CONST robtarget Target_20:=[[802.15611554,881.304663714,342.308205749],[0.433012607,0.433012734,0.750000055,-0.249999945],[-1,0,0,0],[9E9,9E9,9E9,9E9,9E9,9E9]];
    CONST robtarget Target_40_2:=[[772.144,846.566,203.222],[0,0.258819045,0.965925826,0],[-1,0,-1,0],[9E9,9E9,9E9,9E9,9E9,9E9]];
    CONST robtarget Target_40:=[[772.144,846.566,103.222],[0,0.258819045,0.965925826,0],[-1,0,-1,0],[9E9,9E9,9E9,9E9,9E9,9E9]];
    CONST robtarget Target_50:=[[315,971,50],[0,0,1,0],[-1,0,2,0],[9E9,9E9,9E9,9E9,9E9,9E9]];
    CONST robtarget Target_60:=[[245.842,971.836,58.384],[0,0,1,0],[-2,0,-2,0],[9E9,9E9,9E9,9E9,9E9,9E9]];
	
 
    VAR   robtarget Target_Odlozenia3:=[[315,971.836,50],[0,0,1,0],[-1,0,2,0],[9E9,9E9,9E9,9E9,9E9,9E9]];
    CONST robtarget Target_70:=[[772.144174968,846.565991955,209.23116735],[0.000000135,0.258818941,0.965925854,-0.000000107],[-1,0,-1,0],[9E9,9E9,9E9,9E9,9E9,9E9]];
   
    PROC main() 	 ! Program g³ówny
        
       Reset;        ! Procedura zerujaca wlaczone sygnaly i przywraca pozycje poczatkowa robota
       ConfL\Off;    
       Path_10;       ! Sciezka prazy robota 
       SetDo DO_ROB3_TZ0,1; !Zalaczenie sygnalu 
       Koniec;
              
	ENDPROC
    
    PROC Reset()
        
    SetDo DO_ROB3_TZ0,0;    
    MoveL Target_70,vmax,fine,chwytak_2\WObj:=Workobject_przenosnik_2;   
    SetDO DO_ROB3_CH20,0;
           
    ENDPROC   
    
    PROC Koniec()
        SetDO DO_Act_ROB20,0;
        SetDO DO_ROB3_TZ0,0; 
        SetDO DO_ROB3_NT0,0; 
        SetDO DO_ROB1_T,0;      
        SetDO DO_ROB1_S0,0;   
    ENDPROC
          
        
    PROC Path_10()
                                    
          FOR i FROM 0 TO 3 DO   ! Petla realizujaca pobranie elemntu ze stolu i umieszczenie go na przenosniku 2
     
            IF i = 0  THEN 
                
              WaitDO DO_ROB3_NT0,1;       
              WaitDI DI_ROB3_NT0,1; 
                                        
            ELSEIF i = 1 THEN
                
                 WaitDI DI_ROB1,1;           !Czekaj na obrot stolu
                 WaitDO DO_Act_ROB30, 1;     !Robot czeka na sygnal rozpoczecia poracy
                 WaitTime \InPos, 3;         !czekaj w aktualnej pozycji 3 s
                 
            ELSEIF i = 2 THEN
                
                 WaitDI DI_ROB1,1;          !Czekaj na obrot stolu
                 WaitDO DO_Act_ROB30, 1;    !Robot czeka na sygnal rozpoczecia poracy
                 WaitTime \InPos, 3;        !czekaj w aktualnej pozycji 3 s
            ELSEIF i = 3 THEN
                
                WaitDO DO_Act_ROB30, 1; !Robot czeka na sygnal rozpoczecia poracy
                WaitTime \InPos, 3;     !czekaj w aktualnej pozycji 3 s
            ELSE  
                WaitTime \InPos, 3;     ! czekaj w aktualnej pozycji 3 s
            ENDIF    
    
     
            MoveL Target_70,v150,fine,chwytak_2\WObj:=Workobject_przenosnik_2;  ! Idz do punku 70
            MoveJ Offs (Target_40, 0,0,100), v500, fine, chwytak_2\WObj:=Workobject_przenosnik_2; ! Idz do punktu oddalonego o 100 w  osi z od punktu T40
            MoveL Target_40,v500,fine,chwytak_2\WObj:=Workobject_przenosnik_2;  ! Idz do punku 40
            
            !sygnal zamniecia chwytaka 2
            SetDO DO_ROB3_CH20,1;
            
            MoveL Offs (Target_40, 0,0,100), v500, fine, chwytak_2\WObj:=Workobject_przenosnik_2; ! Idz do punktu oddalonego o 100 w  osi z od punktu T40
            Target_Odlozenia3:= Odloz(i, Target_50);    ! Przypisanie zwracanej wartosci przez funkcje Odloz do zmiennej Target_Odlozenia3
            MoveL Offs (Target_Odlozenia3, 0,0,50), v500, fine, chwytak_2\WObj:=Workobject_przenosnik_2;! Idz do punktu oddalonego o 50 w  osi z od punktu Target_Odlozenia3
            MoveL Target_Odlozenia3,v100,fine,chwytak_2\WObj:=Workobject_przenosnik_2;  ! Idz do punku Target_Odlozenia3
            WaitTime \InPos, 0.5; ! czekaj w aktualnej pozycji 0,5 s
            
            !sygnal otwirajacy chwytak 
            SetDO DO_ROB3_CH20,0;                       
            MoveL Offs (Target_Odlozenia3, 0,0,50), v500, fine, chwytak_2\WObj:=Workobject_przenosnik_2; ! Idz do punktu oddalonego o 50 w  osi z od punktu Target_Odlozenia3
            MoveL Target_70,v150,fine,chwytak_2\WObj:=Workobject_przenosnik_2; ! Idz do punku 70
            
        
            SetDO DO_Act_ROB30, 0; !Reset sygnalu
    
      ENDFOR                 
                   
           
    ENDPROC
  
    !-----------Funkcja odloz ktora w zaleznosci od wartosci n oddala punkt o wartosc n*65 w kierunku przeciwnym do x i pezypisuje ta wartosc do zmiennej Target_Odlozenia3
    
      FUNC robtarget Odloz(num n, robtarget punkPocz)
      
            Target_Odlozenia3 := Offs( punkPocz,n*(-65),0,0);                
    
        RETURN Target_Odlozenia3; ! funkcja zwraca wspolrzedne zmiennej Target_Odlozenia3
    ENDFUNC
    
ENDMODULE


