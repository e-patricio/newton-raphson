import java.util.*;

public class altoNivel {
    // Método para calcular a raiz quadrada usando o método Newton-Raphson recursivamente
    public static int sqrt_nr(int x, int i) {
        int result = 0;
        // Caso base: se i for 0, retorna 1 e faz o primeiro cálculo do método
        if (i == 0) {
            result = 1;
        }
        // Caso contrário, faz o cálculo i-1 do método recursivamente
        if (i > 0) {
            result = (sqrt_nr(x, i - 1) + (x / sqrt_nr(x, i - 1))) / 2;
        }
        return result;
    }

    public static void main(String[] args) {
        Scanner in = new Scanner(System.in);
        int i = 0;
        int x = 0;
        System.out.println("\nPrograma de Raiz Quadrada - Newton-Raphson\r\n" +
                "Desenvolvedoras: Eduarda Patricio, Giovanna Castro, Naiumy dos Reis e Yasmin Aguirre");

        while (true) {
            System.out.println("\nDigite os parâmetros x e i para calcular sqrt_nr (x, i) ou -1 para abortar a execução");
            System.out.println("Digite o parâmetro x:");
            x = in.nextInt();

            if (x < 0) {
                break;
            }
            System.out.println("Digite o parâmetro i:");
            i = in.nextInt();
            if (i < 0) {
                break;
            }
            // Chama o método sqrt_nr e exibe o resultado
            int a = sqrt_nr(x, i);
            System.out.println("sqrt(" + x + ", " + i + ") = " + a);
        }
        in.close();
    }
}
