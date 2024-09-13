----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.04.2022 14:30:22
-- Design Name: 
-- Module Name: project_reti_logiche - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity project_reti_logiche is
    port (
        i_clk       : in std_logic;
        i_rst       : in std_logic;
        i_start     : in std_logic;
        i_data      : in std_logic_vector(7 downto 0);
        o_address   : out std_logic_vector(15 downto 0);
        o_done      : out std_logic;
        o_en        : out std_logic;
        o_we        : out std_logic;
        o_data      : out std_logic_vector (7 downto 0)
    );
end project_reti_logiche;

architecture Behavioral of project_reti_logiche is
component datapath is
    Port(i_clk               : in std_logic;
         i_rst               : in std_logic;
         i_data              : in std_logic_vector(7 downto 0);
         fetch_load          : in std_logic;
         load_0              : in std_logic;
         load_1              : in std_logic; 
         load_2              : in std_logic;
         load_3              : in std_logic;
         load_4              : in std_logic;
         load_5              : in std_logic;
         load_6              : in std_logic;
         load_7              : in std_logic;
         m1_sel              : in std_logic_vector(2 downto 0);
         m2_sel              : in std_logic_vector(2 downto 0);
         m3_sel              : in std_logic_vector(2 downto 0);
         output_load         : in std_logic;
         output_sel          : in std_logic;
         o_data              : out std_logic_vector(7 downto 0);
         word_load           : in std_logic;
         in_count_init       : in std_logic;
         in_count_load       : in std_logic;
         out_count_init      : in std_logic;
         out_count_load      : in std_logic;
         o_end               : out std_logic;
         i_address           : out std_logic_vector(15 downto 0);
         o_address1          : out std_logic_vector(15 downto 0);
         o_address2          : out std_logic_vector(15 downto 0);
         out_reg_init        : in std_logic;
         load_0_rst          : in std_logic;
         load_1_rst          : in std_logic;
         load_2_rst          : in std_logic;
         load_3_rst          : in std_logic;
         load_4_rst          : in std_logic;
         load_5_rst          : in std_logic;
         load_6_rst          : in std_logic;
         load_7_rst          : in std_logic
     );
    end component;
    
    type state is(reset, fetch_num_of_word, save_num_of_word, serialize, bit0, bit1, bit2, bit3, bit4, bit5, bit6,
                  bit7, finish_load_out_reg, first_write, second_write, increment_address, done);
    
    signal fetch_load                : std_logic;
    signal load_0                    : std_logic;
    signal load_1                    : std_logic; 
    signal load_2                    : std_logic;
    signal load_3                    : std_logic;
    signal load_4                    : std_logic;
    signal load_5                    : std_logic;
    signal load_6                    : std_logic;
    signal load_7                    : std_logic;
    signal load_0_rst                : std_logic;
    signal load_1_rst                : std_logic;
    signal load_2_rst                : std_logic;
    signal load_3_rst                : std_logic;
    signal load_4_rst                : std_logic;
    signal load_5_rst                : std_logic;
    signal load_6_rst                : std_logic;
    signal load_7_rst                : std_logic;
    signal m1_sel                    : std_logic_vector(2 downto 0);
    signal m2_sel                    : std_logic_vector(2 downto 0);
    signal m3_sel                    : std_logic_vector(2 downto 0);
    signal output_load               : std_logic;
    signal output_sel                : std_logic;
    signal word_load                 : std_logic;
    signal in_count_init             : std_logic;
    signal in_count_load             : std_logic;
    signal out_count_init            : std_logic;
    signal out_count_load            : std_logic;
    signal o_end                     : std_logic;
    signal i_address                 : std_logic_vector(15 downto 0);
    signal o_address1                : std_logic_vector(15 downto 0);
    signal o_address2                : std_logic_vector(15 downto 0);
    signal out_reg_init              : std_logic;
    signal current_state, next_state :state;
    
begin
    DATAPATH0: datapath port map(
         i_clk => i_clk,               
         i_rst => i_rst,               
         i_data => i_data,                       
         fetch_load => fetch_load,             
         load_0 => load_0,              
         load_1 => load_1,              
         load_2 => load_2,             
         load_3 => load_3,              
         load_4 => load_4,             
         load_5 => load_5,             
         load_6 => load_6,              
         load_7 => load_7,
         load_0_rst => load_0_rst,
         load_1_rst => load_1_rst,
         load_2_rst => load_2_rst,
         load_3_rst => load_3_rst,
         load_4_rst => load_4_rst,
         load_5_rst => load_5_rst,
         load_6_rst => load_6_rst,
         load_7_rst => load_7_rst,              
         m1_sel => m1_sel,             
         m2_sel => m2_sel,          
         m3_sel => m3_sel,                       
         output_load => output_load,         
         output_sel => output_sel,          
         o_data => o_data,              
         word_load => word_load, 
         in_count_init => in_count_init,                  
         in_count_load => in_count_load,   
         out_count_init => out_count_init,           
         out_count_load => out_count_load,     
         o_end => o_end,              
         i_address => i_address,           
         o_address1 => o_address1,          
         o_address2 => o_address2,
         out_reg_init => out_reg_init     
    );  
    
    process(i_clk,i_rst) 
    begin
        if(i_rst = '1') then
            current_state <= reset;
        elsif rising_edge(i_clk) then
            current_state <= next_state;
        end if;
    end process;
    
    process(current_state, i_start, o_end)
    begin
        next_state <= current_state;
        case current_state is
            when reset =>
                if(i_start = '1') then
                    next_state <= fetch_num_of_word;
                end if;
            when fetch_num_of_word =>
                    next_state <= save_num_of_word;
            when save_num_of_word =>
                next_state <= serialize;
            when serialize =>
                if(o_end = '1') then 
                    next_state <= done;
                elsif(o_end = '0') then
                    next_state <= bit0;
                end if;
            when bit0 =>
                next_state <= bit1;
            when bit1 =>
                next_state <= bit2;
            when bit2 =>
                next_state <= bit3;
            when bit3 => 
                next_state <= bit4;
            when bit4 =>
                next_state <= bit5;
            when bit5 =>
                next_state <= bit6;
            when bit6 =>
                next_state <= bit7;
            when bit7 => 
                next_state <= finish_load_out_reg;
            when finish_load_out_reg =>
                next_state <= first_write;
            when first_write =>
                next_state <= second_write;
            when second_write =>
                next_state <= increment_address;
            when increment_address => 
                next_state <= serialize;
            when done =>
                next_state <= reset;
        end case; 
    end process;
    
    process(current_state, i_address, o_address1, o_address2)
    begin
        o_en <= '0';
        o_we <= '0';
        fetch_load <= '0';
        load_0 <= '0';
        load_1 <= '0';
        load_2 <= '0';
        load_3 <= '0';
        load_4 <= '0';
        load_5 <= '0';
        load_6 <= '0';
        load_7 <= '0';
        load_0_rst <= '0';
        load_1_rst <= '0';
        load_2_rst <= '0';
        load_3_rst <= '0';
        load_4_rst <= '0';
        load_5_rst <= '0';
        load_6_rst <= '0';
        load_7_rst <= '0';
        m1_sel <= "000";
        m2_sel <= "000";
        m3_sel <= "000";
        output_load <= '0';
        output_sel <= '0';
        o_done <= '0';
        word_load <= '0';
        in_count_init <= '0';
        in_count_load <= '0';
        out_count_init <= '0';
        out_count_load <= '0';
        o_address <= "0000000000000000";
        out_reg_init <= '0';
     
        case current_state is 
            when reset => 
            when fetch_num_of_word => o_en <= '1';
            when save_num_of_word => 
                        word_load <= '1';
                        o_en <= '1';
                        o_address <= i_address;
            when serialize => 
                        in_count_load <= '1';
                        fetch_load <= '1';
            when bit0 =>
                        load_0 <= '1';
            when bit1 =>
                        load_1 <= '1';
                        m1_sel <= "000";
                        m2_sel <= "000";
                        m3_sel <= "000";
                        output_load <= '1';                        
            when bit2 =>                      
                        load_2 <= '1';
                        m1_sel <= "001";
                        m2_sel <= "001";
                        m3_sel <= "001";
                        output_load <= '1';                        
            when bit3 =>                       
                        load_3 <= '1';
                        m1_sel <= "010";
                        m2_sel <= "010";
                        m3_sel <= "010";
                        output_load <= '1';                       
            when bit4 =>                       
                        load_4 <= '1';
                        m1_sel <= "011";
                        m2_sel <= "011";
                        m3_sel <= "011";
                        output_load <= '1';                        
            when bit5 =>                        
                        load_5 <= '1';
                        m1_sel <= "100";
                        m2_sel <= "100";
                        m3_sel <= "100";
                        output_load <= '1';                      
            when bit6 =>                       
                        load_6 <= '1';
                        m1_sel <= "101";
                        m2_sel <= "101";
                        m3_sel <= "101";
                        output_load <= '1';                       
            when bit7 =>                        
                        load_7 <= '1';
                        m1_sel <= "110";
                        m2_sel <= "110";
                        m3_sel <= "110";
                        output_load <= '1';                     
            when finish_load_out_reg =>
                        m1_sel <= "111";
                        m2_sel <= "111";
                        m3_sel <= "111";
                        output_load <= '1';                        
            when first_write =>  
                        o_en <= '1';
                        o_we <= '1';
                        o_address <= o_address1;
                        output_sel <= '0';
            when second_write =>
                        o_en <= '1';
                        o_we <= '1';
                        out_count_load <= '1';
                        o_address <= o_address2;
                        output_sel <= '1';
            when increment_address =>
                        o_en <= '1';
                        o_address <= i_address;
            when done => 
                        o_done <= '1';
                        in_count_init <= '1';
                        in_count_load <= '1';
                        out_count_init <= '1';
                        out_count_load <= '1';
                        out_reg_init <= '1';
                        output_load <= '1';
                        load_0_rst <= '1';
                        load_0 <= '1';
                        load_1_rst <= '1';
                        load_1 <= '1';
                        load_2_rst <= '1';
                        load_2 <= '1';
                        load_3_rst <= '1';
                        load_3 <= '1';
                        load_4_rst <= '1';
                        load_4 <= '1';
                        load_5_rst <= '1';
                        load_5 <= '1';
                        load_6_rst <= '1';
                        load_6 <= '1';
                        load_7_rst <= '1';
                        load_7 <= '1';
        end case;
    end process;        
end Behavioral;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity datapath is 
    port ( 
        i_clk               : in std_logic;
        i_rst               : in std_logic;
        i_data              : in std_logic_vector(7 downto 0);
        fetch_load          : in std_logic;
        load_0              : in std_logic;
        load_1              : in std_logic; 
        load_2              : in std_logic;
        load_3              : in std_logic;
        load_4              : in std_logic;
        load_5              : in std_logic;
        load_6              : in std_logic;
        load_7              : in std_logic;
        load_0_rst          : in std_logic;
        load_1_rst          : in std_logic;
        load_2_rst          : in std_logic;
        load_3_rst          : in std_logic;
        load_4_rst          : in std_logic;
        load_5_rst          : in std_logic;
        load_6_rst          : in std_logic;
        load_7_rst          : in std_logic;
        m1_sel              : in std_logic_vector(2 downto 0);
        m2_sel              : in std_logic_vector(2 downto 0);
        m3_sel              : in std_logic_vector(2 downto 0);
        output_load         : in std_logic;
        output_sel          : in std_logic;
        o_data              : out std_logic_vector(7 downto 0);
        word_load           : in std_logic;
        in_count_init       : in std_logic;
        in_count_load       : in std_logic;
        out_count_init      : in std_logic;
        out_count_load      : in std_logic;
        o_end               : out std_logic;
        i_address           : out std_logic_vector(15 downto 0);
        o_address1          : out std_logic_vector(15 downto 0);
        o_address2          : out std_logic_vector(15 downto 0);
        out_reg_init        : in std_logic
    );
    end datapath;
    
    architecture Behavioral of datapath is
    signal o_fetch_reg              : std_logic_vector(7 downto 0);
    signal serialized_bit           : std_logic;
    signal o_0_m1                   : std_logic;
    signal o_1_m1                   : std_logic;
    signal o_2_m1                   : std_logic;
    signal o_3_m1                   : std_logic;
    signal o_4_m1                   : std_logic;
    signal o_5_m1                   : std_logic;
    signal o_6_m1                   : std_logic;
    signal o_7_m1                   : std_logic;
    signal o_0_m2                   : std_logic;
    signal o_1_m2                   : std_logic;
    signal o_2_m2                   : std_logic;
    signal o_3_m2                   : std_logic;
    signal o_4_m2                   : std_logic;
    signal o_5_m2                   : std_logic;
    signal o_6_m2                   : std_logic;
    signal o_7_m2                   : std_logic;
    signal o_0_m3                   : std_logic;
    signal o_1_m3                   : std_logic;
    signal o_2_m3                   : std_logic;
    signal o_3_m3                   : std_logic;
    signal o_4_m3                   : std_logic;
    signal o_5_m3                   : std_logic;
    signal o_6_m3                   : std_logic;
    signal o_7_m3                   : std_logic;
    signal o_m1                     : std_logic;
    signal o_m2                     : std_logic;
    signal o_m3                     : std_logic;
    signal P1k                      : std_logic;
    signal P2k                      : std_logic;
    signal out_reg                  : std_logic_vector(15 downto 0);
    signal number_of_word           : std_logic_vector(7 downto 0);
    signal o_in_count_reg           : std_logic_vector(15 downto 0);
    signal o_out_count_reg          : std_logic_vector(15 downto 0);
    signal in_sum                   : std_logic_vector(15 downto 0);
    signal in_init                  : std_logic_vector(15 downto 0);
    signal out_sum1                 : std_logic_vector(15 downto 0);
    signal out_sum2                 : std_logic_vector(15 downto 0);
    signal out_init                 : std_logic_vector(15 downto 0);
    signal o_load_0_rst             : std_logic;
    signal o_load_1_rst             : std_logic;
    signal o_load_2_rst             : std_logic;
    signal o_load_3_rst             : std_logic;
    signal o_load_4_rst             : std_logic;
    signal o_load_5_rst             : std_logic;
    signal o_load_6_rst             : std_logic;
    signal o_load_7_rst             : std_logic;
                         
    begin 

----------------------------------------------------------------------------------------------------
--Register parallel in serial out                  
    process(i_clk, i_rst)
    begin
        if(i_rst = '1') then
            o_fetch_reg <= "00000000";
        elsif rising_edge(i_clk) then
            if(fetch_load = '1') then
                o_fetch_reg <= i_data;
            else
            o_fetch_reg <= o_fetch_reg(6 downto 0) & '0';
            end if;
        end if; 
    end process;
    
    serialized_bit <= o_fetch_reg(7);
    
-----------------------------------------------------------------------------------------
    
    with load_0_rst select
        o_load_0_rst <= '0'             when '1',
                        serialized_bit  when '0', 
                        '-'             when others; 
                             
    process(i_clk, i_rst)
    begin
        if(i_rst = '1') then
            o_0_m1 <= '0';
            o_0_m2 <= '0';
            o_0_m3 <= '0';
        elsif rising_edge (i_clk) then
            if (load_0 = '1') then
                o_0_m1 <= o_load_0_rst;
                o_0_m2 <= o_load_0_rst;
                o_0_m3 <= o_load_0_rst;
            end if;
        end if;
    end process;
        
    with load_1_rst select
        o_load_1_rst <= '0'             when '1',
                        serialized_bit  when '0', 
                        '-'             when others; 
                             
    process(i_clk, i_rst)
    begin
        if(i_rst = '1') then
            o_1_m1 <= '0';
            o_1_m2 <= '0';
            o_1_m3 <= '0';
        elsif rising_edge (i_clk) then
            if (load_1 = '1') then
                o_1_m1 <= o_load_1_rst;
                o_1_m2 <= o_load_1_rst;
                o_1_m3 <= o_load_1_rst;
            end if;
        end if;
    end process;
       
    with load_2_rst select
        o_load_2_rst <= '0'             when '1',
                        serialized_bit  when '0', 
                        '-'             when others; 
                             
    process(i_clk, i_rst)
    begin
        if(i_rst = '1') then
            o_2_m1 <= '0';
            o_2_m2 <= '0';
            o_2_m3 <= '0';
        elsif rising_edge (i_clk) then
            if (load_2 = '1') then
                o_2_m1 <= o_load_2_rst;
                o_2_m2 <= o_load_2_rst;
                o_2_m3 <= o_load_2_rst;
            end if;
        end if;
    end process;
       
    with load_3_rst select
        o_load_3_rst <= '0'             when '1',
                        serialized_bit  when '0', 
                        '-'             when others; 
                             
    process(i_clk, i_rst)
    begin
        if(i_rst = '1') then
            o_3_m1 <= '0';
            o_3_m2 <= '0';
            o_3_m3 <= '0';
        elsif rising_edge (i_clk) then
            if (load_3 = '1') then
                o_3_m1 <= o_load_3_rst;
                o_3_m2 <= o_load_3_rst;
                o_3_m3 <= o_load_3_rst;
            end if;
        end if;
    end process;
    
    with load_4_rst select
        o_load_4_rst <= '0'             when '1',
                        serialized_bit  when '0', 
                        '-'             when others; 
                             
    process(i_clk, i_rst)
    begin
        if(i_rst = '1') then
            o_4_m1 <= '0';
            o_4_m2 <= '0';
            o_4_m3 <= '0';
        elsif rising_edge (i_clk) then
            if (load_4 = '1') then
                o_4_m1 <= o_load_4_rst;
                o_4_m2 <= o_load_4_rst;
                o_4_m3 <= o_load_4_rst;
            end if;
        end if;
    end process;

      
    with load_5_rst select
        o_load_5_rst <= '0'             when '1',
                        serialized_bit  when '0', 
                        '-'             when others; 
                             
    process(i_clk, i_rst)
    begin
        if(i_rst = '1') then
            o_5_m1 <= '0';
            o_5_m2 <= '0';
            o_5_m3 <= '0';
        elsif rising_edge (i_clk) then
            if (load_5 = '1') then
                o_5_m1 <= o_load_5_rst;
                o_5_m2 <= o_load_5_rst;
                o_5_m3 <= o_load_5_rst;
            end if;
        end if;
    end process;
      
    with load_6_rst select
        o_load_6_rst <= '0'             when '1',
                        serialized_bit  when '0', 
                        '-'             when others; 
                             
    process(i_clk, i_rst)
    begin
        if(i_rst = '1') then
            o_6_m1 <= '0';
            o_6_m2 <= '0';
            o_6_m3 <= '0';
        elsif rising_edge (i_clk) then
            if (load_6 = '1') then
                o_6_m1 <= o_load_6_rst;
                o_6_m2 <= o_load_6_rst;
                o_6_m3 <= o_load_6_rst;
            end if;
        end if;
    end process;
    
    with load_7_rst select
        o_load_7_rst <= '0'             when '1',
                        serialized_bit  when '0', 
                        '-'             when others; 
                             
    process(i_clk, i_rst)
    begin
        if(i_rst = '1') then
            o_7_m1 <= '0';
            o_7_m2 <= '0';
            o_7_m3 <= '0';
        elsif rising_edge (i_clk) then
            if (load_7 = '1') then
                o_7_m1 <= o_load_7_rst;
                o_7_m2 <= o_load_7_rst;
                o_7_m3 <= o_load_7_rst;
            end if;
        end if;
    end process;      

---------------------------------------------------------------------------------------------
--Mux 1 
    with m1_sel select
        o_m1 <= o_0_m1  when "000",
                o_1_m1  when "001",
                o_2_m1  when "010",
                o_3_m1  when "011",
                o_4_m1  when "100",
                o_5_m1  when "101",
                o_6_m1  when "110",
                o_7_m1  when "111",
                '-'     when others;
                 
------------------------------------------------------------------------------------------------
-- Mux 2           
    with m2_sel select
        o_m2 <= o_6_m2  when "000",
                o_7_m2  when "001",
                o_0_m2  when "010",
                o_1_m2  when "011",
                o_2_m2  when "100",
                o_3_m2  when "101",
                o_4_m2  when "110",
                o_5_m2  when "111",
                '-'     when others;
------------------------------------------------------------------------------------------
-- Mux 3  
    with m3_sel select
        o_m3 <= o_7_m3  when "000",
                o_0_m3  when "001",
                o_1_m3  when "010",
                o_2_m3  when "011",
                o_3_m3  when "100",
                o_4_m3  when "101",
                o_5_m3  when "110",
                o_6_m3  when "111",
                '-'     when others;
----------------------------------------------------------------------------------------------------
-- Pk1 , Pk2
    P1k <= o_m1 xor o_m2;
    P2k <= o_m1 xor o_m2 xor o_m3;
                       
-----------------------------------------------------------------------------------------------------
-- register serial in parallel out 
      
    process(i_clk,i_rst) 
    begin
        if(i_rst = '1') then
            out_reg <= "0000000000000000";
        elsif rising_edge(i_clk) then
            if(output_load = '1')then
                if(out_reg_init = '1') then
                    out_reg <= "0000000000000000";
                elsif(out_reg_init = '0') then
                    out_reg(15 downto 2) <= out_reg(13 downto 0);
                    out_reg(1 downto 0) <= P1k & P2k;
                end if;
            end if;
        end if;
    end process;
    
-----------------------------------------------------------------------------------------------------
--Mux output sel
    with output_sel select
        o_data <= out_reg(15 downto 8)     when '0',
                  out_reg(7 downto 0)      when '1',
                  "XXXXXXXX"               when others;
                  
-----------------------------------------------------------------------------------------------------
 --Word register
    process(i_clk,i_rst) 
    begin
        if(i_rst = '1') then 
            number_of_word <= "00000000";
        elsif rising_edge(i_clk) then
            if(word_load = '1') then
                number_of_word <= i_data;
            end if;
        end if;
    end process;
    
-----------------------------------------------------------------------------------------------------
--Address counter 
    
    with in_count_init select
        in_init <= "0000000000000000"      when '1',
                   in_sum                  when '0',  
                   "XXXXXXXXXXXXXXXX"      when others;
                      
    process(i_clk, i_rst)
    begin
        if(i_rst = '1') then
            o_in_count_reg <= "0000000000000000";
        elsif rising_edge(i_clk) then
            if(in_count_load = '1') then 
                o_in_count_reg <= in_init;
            end if;
        end if;
    end process;
    
    in_sum <= o_in_count_reg + "0000000000000001";
    
    i_address <= in_sum;
    
    o_end <= '1' when o_in_count_reg = "00000000" & number_of_word else '0';
      
    with out_count_init select
        out_init <= "0000001111100111"       when '1',
                     out_sum2                when '0',  
                    "XXXXXXXXXXXXXXXX"       when others;  
                             
    process(i_clk,i_rst) 
    begin
        if(i_rst = '1') then 
            o_out_count_reg <= "0000001111100111";
        elsif rising_edge(i_clk) then
            if(out_count_load = '1') then 
                o_out_count_reg <= out_init;
            end if;
        end if;
    end process;
    
    out_sum1 <= o_out_count_reg + "0000000000000001";
    
    out_sum2 <= out_sum1 + "0000000000000001";
    
    o_address1 <= out_sum1;
    
    o_address2 <= out_sum2;
 
end Behavioral;