# Carrega a biblioteca System.Windows.Forms
Add-Type -TypeDefinition @"
using System;
using System.Runtime.InteropServices;

public class MouseMove
{
    [DllImport("user32.dll")]
    public static extern bool SetCursorPos(int X, int Y);
}
"@

while ($true) {
    # Obtém a resolução da tela
    $screenWidth = [System.Windows.Forms.Screen]::PrimaryScreen.Bounds.Width
    $screenHeight = [System.Windows.Forms.Screen]::PrimaryScreen.Bounds.Height

    # Define a posição inicial do cursor (topo esquerdo)
    $startPosition = New-Object System.Drawing.Point(0, 0)

    # Define a posição final do cursor (topo direito) O primeiro parametro pode mudar de acordo com o tamanho do seu monitor.
    $endPosition = New-Object System.Drawing.Point(2500, 0)

    # Move o cursor para a posição inicial (topo esquerdo)
    [MouseMove]::SetCursorPos($startPosition.X, $startPosition.Y)

    # Calcula a posição final do cursor (topo direito)
    [MouseMove]::SetCursorPos($endPosition.X, $endPosition.Y)

    # Calcula a velocidade que o cursor vai do ponto inicial pro ponto final
    $increment = [Math]::Ceiling(($endPosition.X - $startPosition.X) / 10)

    # Move o cursor incrementalmente no eixo X até atingir a posição final (topo direito)
    for ($x = $startPosition.X; $x -lt $endPosition.X; $x += $increment) {
        [MouseMove]::SetCursorPos($x, $startPosition.Y)
        Start-Sleep -Milliseconds 10
    }

    # Aguarda 10 segundos antes de repetir o movimento
    Start-Sleep -Seconds 10
}
