
% Nacteni nejlepsiho model
fis = readfis('BestOptimalCloudFuzzyFIS.fis');

% vstupni hodnoty
denni_doba = input('Zadejte denn� dobu (hodiny): ');
rok = input('Zadejte mesic: ');
MnM = input('Zadejte v��ku nad mo�em (metry): ');
vitr = input('Zadejte rychlost v�tru (m/s): ');
vlhkost = input('Zadejte vlhkost (%): ');

% Z�skejte p�edpov�� teploty pomoc� funkce 'predict_temperature'
predicted_temperature = predict_temperature(fis, denni_doba, rok, MnM, vitr, vlhkost);

% V�sledek
fprintf('P�edpov�zen� teplota je: %.2f �C\n', predicted_temperature);



function predicted_temperature = predict_temperature(fis, denni_doba, rok, MnM, vitr, vlhkost)
    % Vytvo�te vstupn� matici pro FIS
    input_matrix = [denni_doba, rok, MnM, vitr, vlhkost];

    % Pou�ijte evalfis k z�sk�n� v�stupu
    predicted_temperature = evalfis(input_matrix, fis);
end