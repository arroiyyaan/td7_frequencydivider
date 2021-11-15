-------------------------------------------------
-- architecture a4 du compteur de gray
-- on génère l'horloge divisée en sortie
-------------------------------------------------

architecture a4 of compteur_gray is
  
signal count : unsigned(7 downto 0) := (others => '0');
signal countc : unsigned(6 downto 0) := (others => '0');

begin

P1 : process(clk,reset)
begin
  if(reset='0') then
	count<= (0 => '1', others => '0');
	clock_out <= '0' ;
  elsif(clk'event and clk='1') then
      if (enable='1') then
	if (count(count'left downto 1)=bin2gray(factor)) then
	    count<= (0 => '1', others => '0');
	    clock_out <= '0' ;			-- quand le compteur est remis à 0, clock_out est aussi remis à 0
	else
	    count(0) <= not count(0);		
	    count(1) <= count(1) xor count(0) ;	
	    for i in 2 to count'left-1 loop	
	        if (count(i-1)='1') and (count(i-2 downto 0)=0 ) then
		    count(i) <= not count(i) ;
	        end if ;
	    end loop;  
	    if (count(count'left-2 downto 0)=0 ) then	
		count(count'left) <= not count(count'left) ;
	    end if ;
	end if ;
	if (count(count'left downto 1)=bin2gray(factor/2)) then  -- quand on atteint la moitié du modulo, clock_out est mis à 1
	  clock_out <= '1' ;
	end if ;
      end if ;
  end if;
end process;

P2 : process(clk2)
begin
  if(clk2'event and clk2='1') then
	countc <= count(count'left downto 1) ;
  end if ;
end process ;

P3 : count_out <= gray2bin(countc) ;

end a4 ;

