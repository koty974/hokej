library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity top_level is
    Port ( CLK100MHZ : in STD_LOGIC;
           SW4 : in STD_LOGIC;  -- RESET
           BTNC : in STD_LOGIC;
           BTNL : in STD_LOGIC;
           BTNR : in STD_LOGIC;
           SW14 : in STD_LOGIC;
           SW15 : in STD_LOGIC;
           CA : out STD_LOGIC;
           CB : out STD_LOGIC;
           CC : out STD_LOGIC;
           CD : out STD_LOGIC;
           CE : out STD_LOGIC;
           CF : out STD_LOGIC;
           CG : out STD_LOGIC;
           AN : out STD_LOGIC_VECTOR (7 downto 0);
           LED16_B : out STD_LOGIC;
           LED16_G : out STD_LOGIC;
           LED16_R : out STD_LOGIC;
           LED17_G : out STD_LOGIC;
           LED17_B : out STD_LOGIC;
           LED17_R : out STD_LOGIC;     
           SW0         : in  STD_LOGIC; -- 2min
           SW1         : in  STD_LOGIC; -- 5min
           BTNU        : in  STD_LOGIC; --tim 1
           BTND        : in  STD_LOGIC; --tim 2
           SW8         : in  STD_LOGIC; -- gol tim 1
           SW5         : in  STD_LOGIC; -- gol tim 2
           SW13        : in  STD_LOGIC; -- celkovy reset
           LED10       : out STD_LOGIC; -- led tim 2
           LED11       : out STD_LOGIC; -- led tim 2
           LED12       : out STD_LOGIC; -- led tim 2
           LED13       : out STD_LOGIC; -- led tim 2
           LED14       : out STD_LOGIC; -- led tim 2
           LED1        : out STD_LOGIC; -- led tim 1
           LED2        : out STD_LOGIC;-- led tim 1
           LED3        : out STD_LOGIC;-- led tim 1
           LED4        : out STD_LOGIC;-- led tim 1
           LED5        : out STD_LOGIC);-- led tim 1
end top_level;

architecture Behavioral of top_level is
    -- Debounced BTN signals
    signal BTNU_db  : STD_LOGIC;
    signal BTND_db  : STD_LOGIC;
    signal BTNL_db  : STD_LOGIC;
    signal BTNR_db  : STD_LOGIC;
    signal BTNC_db  : STD_LOGIC;


    component debounce is
    Port (
        clk    : in  STD_LOGIC;
        btn_in : in  STD_LOGIC;
        btn_out: out STD_LOGIC := '0'
    );
end component;


    -- Component declarations
    component timer is
        Port (
        BTNC      : in STD_LOGIC;
        SW15      : in STD_LOGIC;
        clk100MHZ : in STD_LOGIC;
        clock1    : out STD_LOGIC_VECTOR (3 downto 0);
        clock2    : out STD_LOGIC_VECTOR (3 downto 0);
        clock3    : out STD_LOGIC_VECTOR (3 downto 0);
        clock4    : out STD_LOGIC_VECTOR (3 downto 0);
        LED16_B   : out STD_LOGIC:= '0';
        LED16_G   : out STD_LOGIC:= '0';
        LED16_R   : out STD_LOGIC:= '0';
        LED17_G   : out STD_LOGIC:= '0';
        LED17_B   : out STD_LOGIC:= '0';
        LED17_R   : out STD_LOGIC:= '0'
    );
    end component;

    component dyn_seg is
        Port ( clk : in STD_LOGIC;
               en : in STD_LOGIC;
               CA : out STD_LOGIC;
               CB : out STD_LOGIC;
               CC : out STD_LOGIC;
               CD : out STD_LOGIC;
               CE : out STD_LOGIC;
               CF : out STD_LOGIC;
               CG : out STD_LOGIC;
               AN : out STD_LOGIC_VECTOR (7 downto 0);
               SGD0 : in STD_LOGIC_VECTOR (6 downto 0);
               SGD1 : in STD_LOGIC_VECTOR (6 downto 0);
               SGD2 : in STD_LOGIC_VECTOR (6 downto 0);
               SGD3 : in STD_LOGIC_VECTOR (6 downto 0);
               SGD4 : in STD_LOGIC_VECTOR (6 downto 0);
               SGD5 : in STD_LOGIC_VECTOR (6 downto 0);
               SGD6 : in STD_LOGIC_VECTOR (6 downto 0);
               SGD7 : in STD_LOGIC_VECTOR (6 downto 0));
    end component;

    component bin2seg is
        Port ( clock1 : in STD_LOGIC_VECTOR(3 downto 0);
               clock2 : in STD_LOGIC_VECTOR(3 downto 0);
               clock3 : in STD_LOGIC_VECTOR(3 downto 0);
               clock4 : in STD_LOGIC_VECTOR(3 downto 0);
               goal1 : in STD_LOGIC_VECTOR(3 downto 0);
               goal2 : in STD_LOGIC_VECTOR(3 downto 0);
               goal3 : in STD_LOGIC_VECTOR(3 downto 0);
               goal4 : in STD_LOGIC_VECTOR(3 downto 0);
               seg1 : out STD_LOGIC_VECTOR(6 downto 0);
               seg2 : out STD_LOGIC_VECTOR(6 downto 0);
               seg3 : out STD_LOGIC_VECTOR(6 downto 0);
               seg4 : out STD_LOGIC_VECTOR(6 downto 0);
               seg5 : out STD_LOGIC_VECTOR(6 downto 0);
               seg6 : out STD_LOGIC_VECTOR(6 downto 0);
               seg7 : out STD_LOGIC_VECTOR(6 downto 0);
               seg8 : out STD_LOGIC_VECTOR(6 downto 0));
    end component;

    component clock_en is
        generic ( n_periods : integer := 100 );
        Port ( clk : in STD_LOGIC;
               rst : in STD_LOGIC;
               pulse : out STD_LOGIC);
    end component;

    component goal_counter is
        Port ( clk : in STD_LOGIC;
               rst : in STD_LOGIC;
               BTNL : in STD_LOGIC;
               BTNR : in STD_LOGIC;
               SW14 : in STD_LOGIC;
               goal1 : out STD_LOGIC_VECTOR(3 downto 0);
               goal2 : out STD_LOGIC_VECTOR(3 downto 0);
               goal3 : out STD_LOGIC_VECTOR(3 downto 0);
               goal4 : out STD_LOGIC_VECTOR(3 downto 0));
    end component;
    
    component power_play  is
    Port (
        clk         : in  STD_LOGIC;
        SW0         : in  STD_LOGIC; -- 2min
        SW1         : in  STD_LOGIC; -- 5min
        BTNU        : in  STD_LOGIC; --tim 1
        BTND        : in  STD_LOGIC; --tim 2
        SW8         : in  STD_LOGIC; -- gol tim 1
        SW5         : in  STD_LOGIC; -- gol tim 2
        SW15        : in  STD_LOGIC; -- zastavenie casu
        SW13        : in  STD_LOGIC; -- celkovy reset
        LED10       : out STD_LOGIC; -- led tim 2
        LED11       : out STD_LOGIC; -- led tim 2
        LED12       : out STD_LOGIC; -- led tim 2
        LED13       : out STD_LOGIC; -- led tim 2
        LED14       : out STD_LOGIC; -- led tim 2
        LED1        : out STD_LOGIC; -- led tim 1
        LED2        : out STD_LOGIC;-- led tim 1
        LED3        : out STD_LOGIC;-- led tim 1
        LED4        : out STD_LOGIC;-- led tim 1
        LED5        : out STD_LOGIC-- led tim 1
    );
    end component;

    -- Signals for interconnecting components
    signal clock1_sig : STD_LOGIC_VECTOR(3 downto 0);
    signal clock2_sig : STD_LOGIC_VECTOR(3 downto 0);
    signal clock3_sig : STD_LOGIC_VECTOR(3 downto 0);
    signal clock4_sig : STD_LOGIC_VECTOR(3 downto 0);
    signal goal1_sig : STD_LOGIC_VECTOR(3 downto 0);
    signal goal2_sig : STD_LOGIC_VECTOR(3 downto 0);
    signal goal3_sig : STD_LOGIC_VECTOR(3 downto 0);
    signal goal4_sig : STD_LOGIC_VECTOR(3 downto 0);
    signal seg1_sig : STD_LOGIC_VECTOR(6 downto 0);
    signal seg2_sig : STD_LOGIC_VECTOR(6 downto 0);
    signal seg3_sig : STD_LOGIC_VECTOR(6 downto 0);
    signal seg4_sig : STD_LOGIC_VECTOR(6 downto 0);
    signal seg5_sig : STD_LOGIC_VECTOR(6 downto 0);
    signal seg6_sig : STD_LOGIC_VECTOR(6 downto 0);
    signal seg7_sig : STD_LOGIC_VECTOR(6 downto 0);
    signal seg8_sig : STD_LOGIC_VECTOR(6 downto 0);
    signal pulse_dynseg_sig : STD_LOGIC;

begin
    
        u_debounce_BTNU : debounce
        port map (
            clk     => CLK100MHZ,
            btn_in  => BTNU,
            btn_out => BTNU_db
        );
    
    u_debounce_BTND : debounce
        port map (
            clk     => CLK100MHZ,
            btn_in  => BTND,
            btn_out => BTND_db
        );
    
    u_debounce_BTNL : debounce
        port map (
            clk     => CLK100MHZ,
            btn_in  => BTNL,
            btn_out => BTNL_db
        );
    
    u_debounce_BTNR : debounce
        port map (
            clk     => CLK100MHZ,
            btn_in  => BTNR,
            btn_out => BTNR_db
        );
    
    u_debounce_BTNC : debounce
        port map (
            clk     => CLK100MHZ,
            btn_in  => BTNC,
            btn_out => BTNC_db
        );


    -- Instantiate clock component
    u_clock : timer
        Port map (
            BTNC => BTNC_db,
            SW15 => SW15,
            clk100MHZ => CLK100MHZ,
            clock1 => clock1_sig,
            clock2 => clock2_sig,
            clock3 => clock3_sig,
            clock4 => clock4_sig,
            LED16_B => LED16_B,
            LED16_G => LED16_G,
            LED16_R => LED16_R,
            LED17_G => LED17_G,
            LED17_B => LED17_B,
            LED17_R => LED17_R
        );

    -- Instantiate dyn_seg component
    u_dyn_seg : dyn_seg
        Port map (
            clk => CLK100MHZ,
            en => pulse_dynseg_sig,
            CA => CA,
            CB => CB,
            CC => CC,
            CD => CD,
            CE => CE,
            CF => CF,
            CG => CG,
            AN => AN,
            SGD0 => seg1_sig,
            SGD1 => seg2_sig,
            SGD2 => seg3_sig,
            SGD3 => seg4_sig,
            SGD4 => seg5_sig,
            SGD5 => seg6_sig,
            SGD6 => seg7_sig,
            SGD7 => seg8_sig
        );

    -- Instantiate bin2seg component
    u_bin2seg : bin2seg
        Port map (
            clock1 => clock1_sig,
            clock2 => clock2_sig,
            clock3 => clock3_sig,
            clock4 => clock4_sig,
            goal1 => goal1_sig,
            goal2 => goal2_sig,
            goal3 => goal3_sig,
            goal4 => goal4_sig,
            seg1 => seg1_sig,
            seg2 => seg2_sig,
            seg3 => seg3_sig,
            seg4 => seg4_sig,
            seg5 => seg5_sig,
            seg6 => seg6_sig,
            seg7 => seg7_sig,
            seg8 => seg8_sig
        );

   
    -- Instantiate clock_en component for dyn_seg
    u_clock_en_dynseg : clock_en
        generic map ( n_periods => 200000 )
        Port map (
            clk => CLK100MHZ,
            rst => SW4,
            pulse => pulse_dynseg_sig
        );

    -- Instantiate goal_counter component
    u_goal_counter : goal_counter
        Port map (
            clk => CLK100MHZ,
            rst => SW4,
            BTNL => BTNL_db,
            BTNR => BTNR_db,
            SW14 => SW14,
            goal1 => goal1_sig,
            goal2 => goal2_sig,
            goal3 => goal3_sig,
            goal4 => goal4_sig
        );
        
        u_power_plays : power_play
        port map(
            clk => CLK100MHZ,
            SW0 => SW0,
            SW1 => SW1,
            SW5 => SW5,
            BTNU => BTNU_db,
            BTND => BTND_db,
            SW8 => SW8,
            SW15 => SW15,
            SW13 => SW13,
            LED10 => LED10,
            LED11 => LED11,
            LED12 => LED12,
            LED13 => LED13,
            LED14 => LED14,
            LED1 => LED1,
            LED2 => LED2,
            LED3 => LED3,
            LED4 => LED4,
            LED5 => LED5
        );
        
        
        
end Behavioral;