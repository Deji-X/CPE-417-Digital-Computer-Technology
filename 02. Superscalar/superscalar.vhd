library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity superscalar_2_issue is
    Port (
        clk     : in  std_logic;
        reset   : in  std_logic;

        valid0  : in  std_logic;
        valid1  : in  std_logic;

        opcode0 : in  std_logic_vector(3 downto 0);
        opcode1 : in  std_logic_vector(3 downto 0);

        A0      : in  std_logic_vector(31 downto 0);
        B0      : in  std_logic_vector(31 downto 0);

        A1      : in  std_logic_vector(31 downto 0);
        B1      : in  std_logic_vector(31 downto 0);

        result0 : out std_logic_vector(31 downto 0);
        result1 : out std_logic_vector(31 downto 0)
    );
end superscalar_2_issue;

architecture Behavioral of superscalar_2_issue is

begin

    process(clk)
    begin
        if rising_edge(clk) then

            if reset = '1' then
                result0 <= (others => '0');
                result1 <= (others => '0');

            else

                -- Execution lane 0
                if valid0 = '1' then

                    case opcode0 is

                        when "0000" =>
                            result0 <= std_logic_vector(
                                unsigned(A0) + unsigned(B0)
                            );

                        when "0001" =>
                            result0 <= std_logic_vector(
                                unsigned(A0) - unsigned(B0)
                            );

                        when "0010" =>
                            result0 <= A0 and B0;

                        when "0011" =>
                            result0 <= A0 or B0;

                        when others =>
                            result0 <= (others => '0');

                    end case;

                end if;


                -- Execution lane 1
                if valid1 = '1' then

                    case opcode1 is

                        when "0000" =>
                            result1 <= std_logic_vector(
                                unsigned(A1) + unsigned(B1)
                            );

                        when "0001" =>
                            result1 <= std_logic_vector(
                                unsigned(A1) - unsigned(B1)
                            );

                        when "0010" =>
                            result1 <= A1 and B1;

                        when "0011" =>
                            result1 <= A1 or B1;

                        when others =>
                            result1 <= (others => '0');

                    end case;

                end if;

            end if;
        end if;
    end process;

end Behavioral;
