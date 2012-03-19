function [val] = getRatingVSMAgreement(ratings, vsm)
val = sum(sum((ratings > 0) == (vsm > 0)));