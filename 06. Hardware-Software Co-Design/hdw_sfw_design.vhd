library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity hardware_multiplier is
    Port (
        clk        : in  std_logic;
        reset      : in  std_logic;

        start      : in  std_logic;

        A          : in  std_logic_vector(31 downto 0);
        B          : in  std_logic_vector(31 downto 0);

        result     : out std_logic_vector(63 downto 0);
        done       : out std_logic
    );
end hardware_multiplier;

architecture Behavioral of hardware_multiplier is

begin

    process(clk)
    begin

        if rising_edge(clk) then

            if reset = '1' then

                result <= (others => '0');
                done   <= '0';

            else

                done <= '0';

                if start = '1' then

                    result <= std_logic_vector(
                        unsigned(A) * unsigned(B)
                    );

                    done <= '1';

                end if;

            end if;

        end if;

    end process;

end Behavioral;
