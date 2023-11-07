
% Nacteni nejlepsiho model
fis = readfis('BestOptimalCloudFuzzyFIS.fis');

% vstupni hodnoty
denni_doba = input('Zadejte denní dobu (hodiny): ');
rok = input('Zadejte mesic: ');
MnM = input('Zadejte výšku nad moøem (metry): ');
vitr = input('Zadejte rychlost vìtru (m/s): ');
vlhkost = input('Zadejte vlhkost (%): ');

% Získejte pøedpovìï teploty pomocí funkce 'predict_temperature'
predicted_temperature = predict_temperature(fis, denni_doba, rok, MnM, vitr, vlhkost);

% Výsledek
fprintf('Pøedpovìzená teplota je: %.2f °C\n', predicted_temperature);



function predicted_temperature = predict_temperature(fis, denni_doba, rok, MnM, vitr, vlhkost)
    % Vytvoøte vstupní matici pro FIS
    input_matrix = [denni_doba, rok, MnM, vitr, vlhkost];

    % Použijte evalfis k získání výstupu
    predicted_temperature = evalfis(input_matrix, fis);
end