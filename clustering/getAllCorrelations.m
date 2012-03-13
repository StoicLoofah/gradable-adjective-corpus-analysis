function [] = getAllCorrelations(dataset, indices, actual_vals)

dataset = getAllWeightings(dataset);

display('RAW');
cur_vals = extract_stimuli_values(dataset.data, indices);
display(cur_vals);
cur_corr = corr([cur_vals actual_vals]);
display(cur_corr);

display('LOG');
cur_vals = extract_stimuli_values(dataset.log, indices);
display(cur_vals);
cur_corr = corr([cur_vals actual_vals]);
display(cur_corr);

display('THRESHOLDED');
cur_vals = extract_stimuli_values(dataset.thresholded, indices);
display(cur_vals);
cur_corr = corr([cur_vals actual_vals]);
display(cur_corr);

display('Rel Freq');
cur_vals = extract_stimuli_values(dataset.rel_freq, indices);
display(cur_vals);
cur_corr = corr([cur_vals actual_vals]);
display(cur_corr);

display('L2 Norm');
cur_vals = extract_stimuli_values(dataset.l2_normed, indices);
display(cur_vals);
cur_corr = corr([cur_vals actual_vals]);
display(cur_corr);

display('OOE');
cur_vals = extract_stimuli_values(dataset.ooe, indices);
display(cur_vals);
cur_corr = corr([cur_vals actual_vals]);
display(cur_corr);

display('PMI');
cur_vals = extract_stimuli_values(dataset.pmi, indices);
display(cur_vals);
cur_corr = corr([cur_vals actual_vals]);
display(cur_corr);

display('NORMALIZEDPMI');
cur_vals = extract_stimuli_values(dataset.normalized_pmi, indices);
display(cur_vals);
cur_corr = corr([cur_vals actual_vals]);
display(cur_corr);

display('PMI CR');
cur_vals = extract_stimuli_values(dataset.crpmi, indices);
display(cur_vals);
cur_corr = corr([cur_vals actual_vals]);
display(cur_corr);

display('PMI Smooth');
cur_vals = extract_stimuli_values(dataset.pmi_smoothed, indices);
display(cur_vals);
cur_corr = corr([cur_vals actual_vals]);
display(cur_corr);