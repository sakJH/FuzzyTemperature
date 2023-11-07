function [mse_new, trained_fis] = optimal1(data)
    input_matrix = data{:, {'denni_doba', 'rok', 'MnM', 'vitr', 'vlhkost'}};
    actual_temperature = data.teplota;

    [trainInd, ~, testInd] = dividerand(height(data), 0.7, 0, 0.3);
    train_input_matrix = input_matrix(trainInd, :);
    train_actual_temperature = actual_temperature(trainInd);
    test_input_matrix = input_matrix(testInd, :);
    test_actual_temperature = actual_temperature(testInd);

    fis = readfis('CloudFuzzyModel.fis');

    options = genfisOptions('SubtractiveClustering');
    fis_new = genfis(train_input_matrix, train_actual_temperature, options);

    numEpochs = 100;
    anfis_options = anfisOptions('InitialFIS', fis_new, 'EpochNumber', numEpochs);
    [trained_fis, anfis_info] = anfis([train_input_matrix, train_actual_temperature], anfis_options);

    trained_fis.input(3).range = [0, 1600]; % oprava

    output_new = evalfis(test_input_matrix, trained_fis);
    mse_new = mean((test_actual_temperature - output_new).^2);
end