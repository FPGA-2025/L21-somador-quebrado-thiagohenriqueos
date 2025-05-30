`timescale 1ns/1ps

module tb_add();

reg [3:0] num1;
reg [3:0] num2;
wire [3:0] out;
wire cout;

add DUT (
    .num1(num1),
    .num2(num2),
    .out(out),
    .cout(cout)
);

integer i, j;
reg [4:0] soma_esperada;

initial begin
    $display("Iniciando testes do somador 4-bit:");
    $display("Num1  Num2  ->  Saida  Cout  |  Esperado");

    // Teste exaustivo: todos os pares possíveis (0 a 15)
    for (i = 0; i < 16; i = i + 1) begin
        for (j = 0; j < 16; j = j + 1) begin
            num1 = i[3:0];
            num2 = j[3:0];
            #1; // espera 1ns para estabilizar

            soma_esperada = i + j;

            $display("%4d + %4d ->  %4b  %b  |  %5b",
                      num1, num2, out, cout, soma_esperada);

            // Verificação automática
            if ({cout, out} !== soma_esperada) begin
                $display("ERRO: resultado incorreto para %d + %d", num1, num2);
            end
        end
    end

    $display("Testes concluídos.");
    $stop;
end

endmodule
