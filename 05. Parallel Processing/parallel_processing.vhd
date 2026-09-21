library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity parallel_adder is
    Port (
        A0 : in  std_logic_vector(31 downto 0);
        A1 : in  std_logic_vector(31 downto 0);
        A2 : in  std_logic_vector(31 downto 0);
        A3 : in  std_logic_vector(31 downto 0);

        B0 : in  std_logic_vector(31 downto 0);
        B1 : in  std_logic_vector(31 downto 0);
        B2 : in  std_logic_vector(31 downto 0);
        B3 : in  std_logic_vector(31 downto 0);

        Y0 : out std_logic_vector(31 downto 0);
        Y1 : out std_logic_vector(31 downto 0);
        Y2 : out std_logic_vector(31 downto 0);
        Y3 : out std_logic_vector(31 downto 0)
    );
end parallel_adder;

architecture Behavioral of parallel_adder is

begin

    Y0 <= std_logic_vector(
        unsigned(A0) + unsigned(B0)
    );

    Y1 <= std_logic_vector(
        unsigned(A1) + unsigned(B1)
    );

    Y2 <= std_logic_vector(
        unsigned(A2) + unsigned(B2)
    );

    Y3 <= std_logic_vector(
        unsigned(A3) + unsigned(B3)
    );

end Behavioral;
