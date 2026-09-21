library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity overflow_detector is
    port (
        A        : in  signed(7 downto 0);
        B        : in  signed(7 downto 0);
        Result   : out signed(7 downto 0);
        Overflow : out std_logic
    );
end overflow_detector;

architecture Behavioral of overflow_detector is
    signal Sum : signed(8 downto 0);
begin

    Sum <= resize(A, 9) + resize(B, 9);

    Result <= Sum(7 downto 0);

    Overflow <=
        (not A(7) and not B(7) and Sum(7)) or
        (A(7) and B(7) and not Sum(7));

end Behavioral;
