

% Předpokládáme, že data, optimal_fis1 a optimal_fis2 jsou již definovány

% Rozdělení dat na tréninkovou a testovací sadu
[trainInd, ~, testInd] = dividerand(height(data), 0.7, 0, 0.3);
test_data = data(testInd, :);

% Příprava testovacích dat
test_input_matrix = test_data{:, {'denni_doba', 'rok', 'MnM', 'vitr', 'vlhkost'}};
test_actual_temperature = test_data.teplota;

% Vyhodnocení modelu optimal1
predicted_temperature1 = evalfis(test_input_matrix, optimal_fis1);
mse1 = mean((test_actual_temperature - predicted_temperature1).^2);
rmse1 = sqrt(mse1);

% Vyhodnocení modelu optimal2
predicted_temperature2 = evalfis(test_input_matrix, optimal_fis2);
mse2 = mean((test_actual_temperature - predicted_temperature2).^2);
rmse2 = sqrt(mse2);

% Výpis metrik výkonnosti
fprintf('MSE optimal1: %f, RMSE optimal1: %f\n', mse1, rmse1);
fprintf('MSE optimal2: %f, RMSE optimal2: %f\n', mse2, rmse2);

% Vizualizace výsledků
figure;
subplot(1,2,1);
plot(test_actual_temperature, 'b');
hold on;
plot(predicted_temperature1, 'r');
title('Porovnání Skutečných a Předpovězených Teplot - optimal1');
xlabel('Případ');
ylabel('Teplota');
legend('Skutečná teplota', 'Předpovězená teplota');
hold off;

subplot(1,2,2);
plot(test_actual_temperature, 'b');
hold on;
plot(predicted_temperature2, 'r');
title('Porovnání Skutečných a Předpovězených Teplot - optimal2');
xlabel('Případ');
ylabel('Teplota');
legend('Skutečná teplota', 'Předpovězená teplota');
hold off;
