library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Booth_Multiplier is
    generic (
        N : integer := 4
    );

    port (
        clk          : in  std_logic;
        reset        : in  std_logic;
        start        : in  std_logic;

        multiplicand : in  signed(N-1 downto 0);
        multiplier   : in  signed(N-1 downto 0);

        product      : out signed(2*N-1 downto 0);
        done         : out std_logic
    );
end Booth_Multiplier;


architecture Behavioral of Booth_Multiplier is

    -- Accumulator: N+1 bits to safely handle signed operations
    signal A : signed(N downto 0);

    -- Sign-extended multiplicand
    signal M : signed(N downto 0);

    -- Multiplier
    signal Q : signed(N-1 downto 0);

    -- Q-1 register
    signal Q_minus_1 : std_logic;

    -- Iteration counter
    signal count : integer range 0 to N;

    signal busy : std_logic;

begin

    process(clk)

        variable A_temp : signed(N downto 0);
        variable P_temp : signed(2*N downto 0);

    begin

        if rising_edge(clk) then

            if reset = '1' then

                A         <= (others => '0');
                M         <= (others => '0');
                Q         <= (others => '0');
                Q_minus_1 <= '0';

                count     <= 0;
                busy      <= '0';

                product   <= (others => '0');
                done      <= '0';

            else

                done <= '0';

                -- Start a new multiplication
                if start = '1' and busy = '0' then

                    A <= (others => '0');

                    -- Sign extend multiplicand
                    M <= resize(multiplicand, N + 1);

                    Q <= multiplier;

                    Q_minus_1 <= '0';

                    count <= 0;

                    busy <= '1';

                -- Perform Booth algorithm
                elsif busy = '1' then

                    -- Start with current accumulator
                    A_temp := A;

                    -- Booth decision
                    case Q(0) & Q_minus_1 is

                        -- 00: No operation
                        when "00" =>
                            A_temp := A;

                        -- 01: Add multiplicand
                        when "01" =>
                            A_temp := A + M;

                        -- 10: Subtract multiplicand
                        when "10" =>
                            A_temp := A - M;

                        -- 11: No operation
                        when "11" =>
                            A_temp := A;

                        when others =>
                            A_temp := A;

                    end case;


                    -- Arithmetic right shift
                    Q_minus_1 <= Q(0);

                    Q <= A_temp(0) & Q(N-1 downto 1);

                    A <= A_temp(N) & A_temp(N downto 1);


                    -- Check if this was the final iteration
                    if count = N-1 then

                        -- Final product
                        P_temp := A_temp(N-1 downto 0) & Q;

                        product <= P_temp(2*N-1 downto 0);

                        done <= '1';

                        busy <= '0';

                        count <= 0;

                    else

                        count <= count + 1;

                    end if;

                end if;

            end if;

        end if;

    end process;

end Behavioral;
