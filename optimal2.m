function [optimal_mse2, optimal_fis2] = optimal2(data)
    % 1. Rozdeleni na tr�ninkov� a testovac� data
    [trainInd, ~, testInd] = dividerand(height(data), 0.7, 0, 0.3);
    train_data = data(trainInd, :);
    test_data = data(testInd, :);

    % 2. Priprava tr�ninkov�ch a testovac�ch vstup? a v�stup?
    train_input_matrix = train_data{:, 1:5};
    train_output_matrix = train_data{:, 6};
    test_input_matrix = test_data{:, 1:5};
    test_output_matrix = test_data{:, 6};

    % 3. Nacteni FIS z .fis souboru
    fis = readfis('CloudFuzzyModel.fis');

    % 4. Vypocet puvodni chyby (MSE) pred optimalizac�
    output_original = evalfis(test_input_matrix, fis);
    mse_original = mean((test_output_matrix - output_original).^2);

    % 5. Optimalizace pravidel
    options = genfisOptions('SubtractiveClustering');
    fis_opt = genfis(train_input_matrix, train_output_matrix, options);

    % 6. Tr�nov�n� FIS
    epochs = 100;
    trnOpt = anfisOptions('InitialFIS', fis_opt, 'EpochNumber', epochs, 'DisplayANFISInformation', 0, 'DisplayErrorValues', 0);
    [trained_fis, ~, ~] = anfis([train_input_matrix, train_output_matrix], trnOpt);

    % 7. Kontrola rozmez� vstupn�ch prom?nn�ch
    for i = 1:length(trained_fis.input)
        trained_fis.input(i).range;
    end

    % 8. Nastaveni rozmez� vstupn�ch prom?nn�ch, pokud je to nutn�
    trained_fis.input(3).range = [0 1600];

    % 9. Vypocet nove chyby (MSE) po optimalizaci a tr�ninku
    output_new = evalfis(test_input_matrix, trained_fis);
    mse_new = mean((test_output_matrix - output_new).^2);

    % 10. V�stup
    optimal_mse2 = mse_new;
    optimal_fis2 = trained_fis;
end