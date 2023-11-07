% Nacten� dat z Excelu do tabulky
filename = 'pocasi.xlsx';
data = readtable(filename);

% Optimalizace pomoci optimal1
[optimal_mse1, optimal_fis1] = optimal1(data);

% Optimalizace pomoci optimal2
[optimal_mse2, optimal_fis2] = optimal2(data);

% Vyber nejlepsiho modelu
if optimal_mse1 < optimal_mse2
    best_fis = optimal_fis1;
    best_mse = optimal_mse1;
else
    best_fis = optimal_fis2;
    best_mse = optimal_mse2;
end

% Vyhodnoceni nejlep��ho modelu na cel�m datasetu
input_matrix = data{:, {'denni_doba', 'rok', 'MnM', 'vitr', 'vlhkost'}};
actual_temperature = data.teplota;

predicted_temperature = evalfis(input_matrix, best_fis);
mse = mean((predicted_temperature - actual_temperature).^2);

fprintf('Nejlep�� model m� MSE: %f\n', best_mse);
fprintf('MSE tohoto modelu na cel�m datasetu: %f\n', mse);

% Ulo�en� nejlep��ho FIS do .fis souboru
writefis(best_fis, 'BestOptimalCloudFuzzyFIS.fis');